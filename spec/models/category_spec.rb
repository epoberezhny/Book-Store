RSpec.describe Category, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  context 'associations' do
    it { is_expected.to have_many(:books) }
  end

  context 'public instance methods' do
    describe '.to_param' do
      it do
        category = build(:category, name: 'Web development')
        expect(category.to_param).to eq('web_development')
      end
    end
  end
end
