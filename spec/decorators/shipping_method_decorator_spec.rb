RSpec.describe 'ShippingMethodDecorator' do
  subject(:decorated_model) { ShippingMethodDecorator.new(model) }

  let(:model) { create(:shipping_method, min_days: 1, max_days: 2, price: 50) }

  describe '#days' do
    it 'returns days range in "x to y" format' do
      expect(decorated_model.days)
        .to eq( I18n.t('range', min: model.min_days, max: model.max_days) )
    end
  end

  describe '#formatted_price' do
    it 'returns formatted price' do
      expect(decorated_model.formatted_price).to eq( model.price.to_s(:currency) )
    end
  end
end