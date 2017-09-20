RSpec.describe OrderItem, type: :model do
  context 'validations' do
    it 'invalid with quantity bigger than books in stock' do
      item = build(:order_item, quantity: 150)
      expect(item).to be_invalid
    end

    it 'valid with quantity less than books in stock' do
      item = build(:order_item, quantity: 1)
      expect(item).to be_valid
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:book).counter_cache(true) }
    it { is_expected.to belong_to(:order) }
  end
end
