RSpec.describe 'CreateReview', type: :service do
  subject(:service) { CreateReview.new(user, params) }

  let(:params) { double('params') }
  let(:user)   { build(:user) }
  let(:book)   { build(:book) }
  let(:review) { build_stubbed(:review) }

  before do
    class << service
      def authorize!(*); end
    end

    allow(Book).to receive(:find) { book }
    allow(params).to receive_message_chain(:require, :permit)
    allow(params).to receive(:[])
    expect(user).to receive_message_chain(:reviews, :new) { review }
  end

  describe '#call' do
    it 'calls authorize!' do
      allow(review).to receive(:save) { true }
      expect(service).to receive(:authorize!).with(:create, :review)

      service.call
    end

    context 'review valid' do
      it 'broadcasts :valid' do
        expect(review).to receive(:save) { true }
        expect { service.call }.to broadcast(:valid)
      end
    end

    context 'review invalid' do
      it 'broadcasts :invalid' do
        expect(review).to receive(:save) { false }
        expect { service.call }.to broadcast(:invalid)
      end
    end
  end
end