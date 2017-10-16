RSpec.describe Review, type: :model do 
  context 'validations' do
    %i[body score].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end

    it { is_expected.to allow_value("!#$%&'*+/=?^_`{|}~Qw., 1").for(:body) }
  end

  context 'associations' do
    %i[book user].each do |association|
      it { is_expected.to belong_to(association) }
    end
  end

  context 'aasm states' do
    it { is_expected.to have_state(:unprocessed, :approved, :rejected) }
    it { is_expected.to transition_from(:unprocessed).to(:approved).on_event(:approve) }
    it { is_expected.to transition_from(:unprocessed).to(:rejected).on_event(:reject) }

    it do
      subject.state = 'approved'
      is_expected.not_to allow_transition_to(:rejected)
    end

    it do
      subject.state = 'rejected'
      is_expected.not_to allow_transition_to(:approved)
    end
  end

  context 'callbacks' do
    let(:user)   { create(:user) }
    let(:book)   { create(:book) }
    let(:review) { build(:review, user: user, book: book) }

    context 'reviewer accomplished a purchase' do
      it 'sets verified to true' do
        order = create(:order, state: :delivered, user: user)
        item  = create(:order_item, order: order, product: book)

        expect(review).to receive(:verify_reviewer).and_call_original
        review.save
        expect(review.verified).to be(true)
      end
    end

    context 'reviewer do not accomplished a purchase' do
      it 'sets verified to false' do
        expect(review).to receive(:verify_reviewer).and_call_original
        review.save
        expect(review.verified).to be(false)
      end
    end
  end
end
