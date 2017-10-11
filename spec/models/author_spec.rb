RSpec.describe Author, type: :model do
  context 'validations' do
    %i[first_name last_name].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name) }
  end

  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end
end
