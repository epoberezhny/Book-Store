RSpec.describe CreditCard, type: :model do
  context 'validations' do
    %i[name_on_card cvv number month_year].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end
      
    context 'number' do
      it { is_expected.to validate_length_of(:number).is_equal_to(16) }
      it { is_expected.to allow_value('1111222233334444').for(:number) }
      it { is_expected.not_to allow_value('a111222233334444').for(:number) }
      it { is_expected.not_to allow_value('111-222233334444').for(:number) }
    end

    context 'cvv' do
      it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
      it { is_expected.to allow_value('123').for(:cvv) }
      it { is_expected.not_to allow_value('a23').for(:cvv) }
      it { is_expected.not_to allow_value('1-3').for(:cvv) }
    end

    context 'cvv' do
      it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
      it { is_expected.to allow_value('123').for(:cvv) }
      it { is_expected.not_to allow_value('a23').for(:cvv) }
      it { is_expected.not_to allow_value('1-3').for(:cvv) }
    end

    context 'name on card' do
      it { is_expected.to validate_length_of(:name_on_card).is_at_most(50) }
      it { is_expected.to allow_value('Vasya Pupkin').for(:name_on_card) }
      it { is_expected.not_to allow_value('Va-sya').for(:name_on_card) }
      it { is_expected.not_to allow_value('Vasya1').for(:name_on_card) }
    end

    context 'mm/yy' do
      it { is_expected.to allow_value('01/22').for(:month_year) }
      it { is_expected.to allow_value('12/99').for(:month_year) }
      it { is_expected.not_to allow_value('1/22').for(:month_year) }
      it { is_expected.not_to allow_value('13/99').for(:month_year) }
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:order) }
  end
end
