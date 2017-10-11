RSpec.describe Address, type: :model do
  context 'validations' do
    %i[first_name last_name address_line city zip country_id phone].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

  end

  context 'associations' do
    it { is_expected.to have_db_column(:type) }
    it { is_expected.to belong_to(:country) }
    it { is_expected.to belong_to(:addressable) }
  end
end
