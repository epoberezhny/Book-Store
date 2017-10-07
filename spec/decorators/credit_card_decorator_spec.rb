RSpec.describe 'CreditCardDecorator' do
  subject(:decorated_model) { CreditCardDecorator.new(model) }

  let(:model) { create(:credit_card, number: '1234123412345678', order: order) }
  let(:order) { create(:order) }

  describe '#formatted_number' do
    it 'returns masked number' do
      expect(decorated_model.formatted_number).to eq('************5678')
    end
  end
end