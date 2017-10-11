RSpec.describe User, type: :model do 
  context 'associations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:nullify) }

    %i[shipping_address billing_address].each do |association_name|
      it { is_expected.to have_one(association_name).dependent(:destroy) }
    end
  end

  context 'nested attributes' do
    %i[shipping_address billing_address].each do |association_name|
      it { is_expected.to accept_nested_attributes_for(association_name) }
    end
  end

  context 'validation' do
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.not_to allow_value('qwertyui').for(:password) }
    it { is_expected.not_to allow_value('QWERTYUI').for(:password) }
    it { is_expected.not_to allow_value('12345678').for(:password) }
    it { is_expected.not_to allow_value('Qwertyui').for(:password) }
    it { is_expected.not_to allow_value('1wertyui').for(:password) }
    it { is_expected.to allow_value('Q1ertyui').for(:password) }
  end
end
