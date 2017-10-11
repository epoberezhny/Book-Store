RSpec.describe Country, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.not_to allow_value('ukra1ine').for(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:shipping_methods) }
  end
end
