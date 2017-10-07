RSpec.describe 'OrderDecorator' do
  subject(:decorated_model) { OrderDecorator.new(model) }

  let(:model) { create(:order_with_credit_card) }

  before do
    model.items.reload
    model.save
  end

  describe '#formatted_total' do
    it 'returns formatted total price' do
      expect(decorated_model.formatted_total).to eq( model.total.to_s(:currency) )
    end
  end

  describe '#formatted_items_subtotal' do
    it 'returns formatted items_subtotal price' do
      expect(decorated_model.formatted_items_subtotal)
        .to eq( model.items_subtotal.to_s(:currency) )
    end
  end

  describe '#formatted_delivery_price' do
    it 'returns formatted delivery price' do
      expect(decorated_model.formatted_delivery_price)
        .to eq( model.delivery_price.to_s(:currency) )
    end
  end

  describe '#formatted_coupon_discount' do
    before { model.coupon = build(:coupon) }

    it 'returns formatted coupon discount' do
      expect(decorated_model.formatted_coupon_discount)
        .to eq "-#{ model.coupon_discount.to_s(:currency) }"
    end
  end

  describe '#number' do
    before { model.id = 123 }

    it 'returns number' do
      expect(decorated_model.number).to eq('R00000123')
    end
  end

  describe '#formatted_completed_at' do
    before { model.completed_at = Time.utc(2017, 1, 2) }

    it 'returns formatted completed_at' do
      expect(decorated_model.formatted_completed_at).to eq('2017-01-02')
    end
  end

  context 'decorates association' do
    it 'decorates items' do
      model.items.reload      
      expect(decorated_model.items.first).to be_instance_of(OrderItemDecorator)
    end

    it 'decorates shipping_method' do
      expect(decorated_model.shipping_method).to be_instance_of(ShippingMethodDecorator)
    end

    it 'decorates credit_card' do
      expect(decorated_model.credit_card).to be_instance_of(CreditCardDecorator)
    end
  end
end