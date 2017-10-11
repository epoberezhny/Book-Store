RSpec.describe 'AuthorDecorator' do
  subject(:decorated_model) { AuthorDecorator.new(model) }

  let(:model) { create(:author, first_name: 'Bruce', last_name: 'Wayne') }

  describe '#full_name' do
    it 'returns full name' do
      expect(decorated_model.full_name).to eq(model.first_name + ' ' + model.last_name)
    end
  end
end