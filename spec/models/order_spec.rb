RSpec.describe Order, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:shipping_method) }
    it { is_expected.to belong_to(:coupon) }
    
    it { is_expected.to have_many(:items).class_name('OrderItem').dependent(:destroy) }

    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
  end

  context 'nested attributes' do
    %i[billing_address shipping_address credit_card items].each do |association_name|
      it { is_expected.to accept_nested_attributes_for(association_name) }
    end
  end

  context 'callbacks' do
    describe 'clear_shipping_method' do
      it 'deletes shipping method if shipping country was changed' do
        order = create(:order_with_shipping_method)

        expect(order.shipping_method).not_to be_nil

        order.shipping_address.country = create(:country)
        order.save

        expect(order.shipping_method).to be_nil
      end
    end

    describe 'clear_shipping_method' do
      it 'total calculation' do
        coupon = create(:coupon)
        order = create(:order_with_shipping_method, coupon: coupon)

        expected_subtotal = order.items.reduce(0) { |sum, item| sum + item.quantity * item.book.price }
        expected_total = expected_subtotal * (1 - coupon.multiplier) + order.shipping_method.price
        
        expect(order.items_subtotal).to eq(expected_subtotal)
        expect(order.total).to eq(expected_total)
      end
    end
  end

  context 'public_methods' do
    describe '#add_item' do
      it 'adds new item with really new item' do
        item  = build(:order_item)
        order = create(:order)

        expect(order.items.count).to eq(0)

        order.add_item(item)

        expect(item).to be_persisted
        expect(order.items.count).to eq(1)
      end

      it 'adds quantity to old item with not new item' do
        book   = create(:book)
        item_1 = build(:order_item, book: book, quantity: 2)
        item_2 = build(:order_item, book: book, quantity: 3)
        order  = create(:order, items: [item_1])
        
        expect(order.items.count).to eq(1)
        expect(order.items.first.quantity).to eq(2)

        order.add_item(item_2)

        expect(item_2).not_to be_persisted
        expect(order.items.count).to eq(1)
        expect(order.items.first.quantity).to eq(5)
      end
    end

    describe '#merge!' do
      it 'merges two orders' do
        books = create_list(:book, 3)

        item_1 = build(:order_item, book: books.first,  quantity: 1)
        item_2 = build(:order_item, book: books.second, quantity: 2)

        item_3 = build(:order_item, book: books.second, quantity: 3)
        item_4 = build(:order_item, book: books.third,  quantity: 4)

        order       = create(:order, items: [item_1, item_2])
        other_order = create(:order, items: [item_3, item_4])

        expect(order).to receive(:save).and_call_original
        expect(OrderItem.count).to eq(4)

        order.merge!(other_order)

        expect(other_order).to be_destroyed
        expect(OrderItem.count).to eq(3)
        expect(order.items.count).to eq(3)
        expect(order.items.where(book: books.first).first.quantity).to  eq(1)
        expect(order.items.where(book: books.second).first.quantity).to eq(5)
        expect(order.items.where(book: books.third).first.quantity).to  eq(4)
      end

      it 'saves coupon from other order' do
        coupon = create(:coupon)

        order       = create(:order)
        other_order = create(:order, coupon: coupon)

        expect(order).to receive(:save).and_call_original

        order.merge!(other_order)

        expect(order.coupon).to eq(coupon)
      end
    end
  end
end
