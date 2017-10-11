RSpec.describe Coupon, type: :model do
  let(:coupon) { build(:coupon) }

  context 'validations' do
    %i[code discount expire].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    context 'code' do
      it { is_expected.to validate_uniqueness_of(:code) }
      it { is_expected.to validate_length_of(:code).is_at_most(20) }
      it { is_expected.to allow_value('a1fh6m784d').for(:code) }
      it { is_expected.not_to allow_value('32r23-asd').for(:code) }
    end

    context 'discount' do
      it do
        is_expected
          .to validate_numericality_of(:discount)
          .only_integer
          .is_greater_than(0)
          .is_less_than(100)
      end
    end
  end

  context 'public instance methods' do
    describe '.expired?' do
      context 'if not expired' do
        it { expect(coupon.expired?).to be false }
      end

      context 'if expired' do
        let(:coupon) { build(:expired_coupon) }

        it { expect(coupon.expired?).to be true }
      end
    end

    describe '.multiplier' do
      it { expect(coupon.multiplier).to eq(0.25) }
    end
  end
end
