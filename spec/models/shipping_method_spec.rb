RSpec.describe ShippingMethod, type: :model do
  context 'validations' do
    %i[min_days max_days name price].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    %i[min_days max_days].each do |attr|
      it { is_expected.to validate_numericality_of(attr).only_integer.is_greater_than(0) }
    end

    it 'is invalid if min_days > max_days' do
      method = build(:shipping_method_with_invalid_days)
      expect(method).not_to be_valid
    end

    it 'is valid if min_days < max_days' do
      method = build(:shipping_method)
      expect(method).to be_valid
    end

    context 'price' do
      it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    end

    context 'name' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:country_id) }
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:country) }
  end
end
