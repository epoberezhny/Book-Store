RSpec.describe 'SortBooks' do
  describe '#query' do
    before do
      category = create(:category)
      @books = create_list(:book, 5, category: category)
    end

    context 'with unknown name' do
      it 'returns books in default order' do
        query_object = SortBooks.new('asfdsf')
        expect(query_object.query).to eq(@books.sort_by(&:title))
      end
    end

    context 'with known name' do
      it 'returns books ordered by price' do
        query_object = SortBooks.new('price')
        expect(query_object.query).to eq(@books.sort_by(&:price))
      end
    end
  end
end