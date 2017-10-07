RSpec.describe 'OrderItemDecorator' do
  subject(:decorated_model) { OrderItemDecorator.new(model) }

  let(:model) { create(:order_item) }

  describe '#formatted_total' do
    it 'returns formatted total price' do
      expect(decorated_model.formatted_total).to eq( model.total.to_s(:currency) )
    end
  end

  context 'decorates association' do
    it 'decorates book' do
      expect(decorated_model.book).to be_instance_of(BookDecorator)
    end
  end
end