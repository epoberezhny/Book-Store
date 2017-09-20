RSpec.describe Material, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.not_to allow_value('material1', 'ma,terial', 'ma-terial').for(:name) }
    it { is_expected.to allow_value('paper', 'glossy paper').for(:name) }
  end

  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end
end
