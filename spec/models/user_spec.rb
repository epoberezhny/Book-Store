RSpec.describe User, type: :model do
  # subject(:user) { build(:user) }
  
  context 'associations' do
    %i[reviews orders].each do |association_name|
      it { is_expected.to have_many(association_name) }
    end

    %i[shipping_address billing_address].each do |association_name|
      it { is_expected.to have_one(association_name) }
    end
  end

  context 'nested attributes' do
    %i[shipping_address billing_address].each do |association_name|
      it { is_expected.to accept_nested_attributes_for(association_name) }
    end
  end

  # context 'validation' do
  #   it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
  #   it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
  #   it { is_expected.to validate_length_of(:email).is_at_most(63) }
  # end
end
