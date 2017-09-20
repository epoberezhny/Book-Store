RSpec.describe 'SortingQuery' do
  let(:query) { Class.new(SortingQuery) }

  describe '::type' do
    it 'adds type' do
      value = { order: { name: :asc }, title: 'Name' }

      expect { query.type(:name, value) }
        .to change { query.sorting_types }
          .from(HashWithIndifferentAccess.new)
          .to({ name: value })
    end

    it 'may set default type' do
      query.type(:name,  order: { name: :asc },  title: 'Name')
      query.type(:title, order: { title: :asc }, title: 'Title', default: true)

      expect(query.default_sorting).to eq(:title)
    end

    it 'sets default title when title is not given' do
      query.type(:name,  order: { name: :asc })

      expect(query.sorting_types[:name][:title]).to respond_to(:call)
      expect(query.sorting_types[:name][:title].call).to eq('name')
    end
  end

  describe '::default_sorting' do
    it "returns first type if default isn't set" do
      query.type(:name,  order: { name: :asc },  title: 'Name')
      query.type(:price, order: { price: :asc }, title: 'Price')

      expect(query.default_sorting).to eq(:name)
    end
  end

  describe '::types_and_titles' do
    it 'returns array of names and titles' do
      array = [ ['name', 'Name'], ['quantity', 'Quantity'] ]

      array.each do |value|
        query.type(value.first, order: { value.first => :asc },  title: value.second)
      end

      expect(query.types_and_titles).to match_array(array)
    end

    it 'returns array of names and default titles' do
      array = [ ['name', 'name'], ['quantity', 'quantity'] ]

      array.each do |value|
        query.type(value.first, order: { value.first => :asc })
      end

      expect(query.types_and_titles).to match_array(array)
    end
  end

  describe '::active_sorting' do
    before do
      query.type(:name, order: { name: :asc },  title: 'Name')
      query.type(:quantity, order: { quantity: :asc })
    end

    it 'returns title of active sorting type' do
      expect(query.active_sorting('name')).to eq('Name')
    end

    it 'returns title of first sorting type with wrong argument' do
      expect(query.active_sorting('namedfgfgh')).to eq('Name')
    end

    it 'returns default title of active sorting type' do
      expect(query.active_sorting('quantity')).to eq('quantity')
    end
  end
end