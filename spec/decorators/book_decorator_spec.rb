RSpec.describe 'BookDecorator' do
  subject(:decorated_model) { BookDecorator.new(model) }

  let(:model) { create(:book_with_reviews) }

  describe '#formatted_price' do
    it 'returns formatted price' do
      expect(decorated_model.formatted_price).to eq( model.price.to_s(:currency) )
    end
  end

  describe '#joined_authors' do
    let(:author_1) { build(:author, first_name: 'Aa', last_name: 'Bb') }
    let(:author_2) { build(:author, first_name: 'Cc', last_name: 'Dd') }
    let(:author_3) { build(:author, first_name: 'Ee', last_name: 'Ff') }
    
    context 'more than 1 author' do
      before { model.authors = [author_1, author_2, author_3] }

      it "returns joined authors' full names" do
        expect(decorated_model.joined_authors).to eq('Aa Bb, Cc Dd, Ee Ff')
      end
    end

    context '1 author' do
      before { model.authors = [author_1] }

      it "returns author's full name" do
        expect(decorated_model.joined_authors).to eq('Aa Bb')
      end
    end
  end

  describe '#joined_materials' do
    let(:material_1) { build(:material, name: 'paper') }
    let(:material_2) { build(:material, name: 'glass') }
    let(:material_3) { build(:material, name: 'metal') }
    
    context 'more than 1 material' do
      before { model.materials = [material_1, material_2, material_3] }

      it "returns joined materials' names" do
        expect(decorated_model.joined_materials).to eq('paper, glass, metal')
      end
    end

    context '1 material' do
      before { model.materials = [material_1] }

      it "returns material's name" do
        expect(decorated_model.joined_materials).to eq('paper')
      end
    end
  end

  describe '#formatted_dimensions' do
    let(:dimensions) { { 'h' => 1, 'w' => 2, 'd' => 3 } }
    
    before { model.dimensions = dimensions }

    it "returns joined materials' names" do
      expect(decorated_model.formatted_dimensions).to eq('H: 1" x W: 2" x D: 3"')
    end
  end

  describe '#btn_class' do
    context 'when in stock' do
      before { allow(model).to receive(:in_stock?).and_return(true) }

      it 'returns btn-primary' do
        expect(decorated_model.btn_class).to eq('btn-primary')
      end
    end

    context 'when not in stock' do
      before { allow(model).to receive(:in_stock?).and_return(false) }

      it 'returns disabled' do
        expect(decorated_model.btn_class).to eq('disabled')
      end
    end
  end

  describe '#disabled_class' do
    context 'when in stock' do
      before { allow(model).to receive(:in_stock?).and_return(true) }

      it 'returns nil' do
        expect(decorated_model.disabled_class).to be_nil
      end
    end

    context 'when not in stock' do
      before { allow(model).to receive(:in_stock?).and_return(false) }

      it 'returns disabled' do
        expect(decorated_model.disabled_class).to eq('disabled')
      end
    end
  end

  context 'decorates association' do
    it 'decorates authors' do
      model.authors.reload
      expect(decorated_model.authors.first).to be_instance_of(AuthorDecorator)
    end

    it 'decorates reviews' do
      model.reviews.reload
      expect(decorated_model.reviews.first).to be_instance_of(ReviewDecorator)
    end
  end
end