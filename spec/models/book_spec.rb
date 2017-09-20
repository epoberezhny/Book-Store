RSpec.describe Book, type: :model do
  let(:book) { build(:book) }
  
  context 'validations' do
    %i[title price description quantity year dimensions].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    context 'quantity' do
      it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(0) }
    end

    context 'price' do
      it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    end

    context 'dimensions' do
      it 'valid' do
        expect(book).to be_valid
      end

      it 'invalid without hegiht' do
        book.dimensions = { 'w' => '1', 'd' => '2' }
        expect(book).not_to be_valid
      end

      it 'invalid with negative values' do
        book.dimensions = { 'h' => '-5', 'w' => '1', 'd' => '2' }
        expect(book).not_to be_valid
      end
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:category).counter_cache(true) }
    it { is_expected.to have_many(:reviews).conditions(state: :approved) }
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to have_and_belong_to_many(:materials) }
  end

  context 'public instance methods' do
    describe '.in_stock?' do
      context 'if in stock' do
        it { expect(book.in_stock?).to be true }
      end

      context 'if no in stock' do
        let(:book) { build(:book, quantity: 0) }

        it { expect(book.in_stock?).to be false }
      end
    end
  end

  context 'scopes' do
    describe 'latest' do
      it 'returns n last books by created_at' do
        books = create_list(:book, 5)
        expect(Book.latest(3)).to match_array(books.last(3))
      end
    end
  end

  context 'callbacks' do
    it 'prepares dimension before save' do
      book.save
      expect(book.dimensions['h']).to be_instance_of(Float)
    end
  end
end
