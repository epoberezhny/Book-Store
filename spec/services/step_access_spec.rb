RSpec.describe 'StepAccess', type: :service do
  subject(:service) { StepAccess.new(order, step) }

  let(:address)  { double('address') }
  let(:delivery) { double('delivery') }
  let(:payment)  { double('payment') }
  let(:order)    { double('order') }

  before do
    allow(order).to receive(:shipping_address) { address }
    allow(order).to receive(:billing_address)  { address }
    allow(order).to receive(:shipping_method)  { delivery }
    allow(order).to receive(:credit_card)      { payment }
    allow(order).to receive(:in_queue?)        { false }
  end

  describe '#call' do
    before do
      allow(order).to receive_message_chain(:items, :exists?) { true }
    end

    context 'empty cart' do
      context 'if not complete step' do
        let(:step) { StepAccess::STEPS.without(:complete).sample }

        it 'broadcasts :empty_cart if items do not exist' do
          allow(order).to receive_message_chain(:items, :exists?) { false }

          expect(service.call).to broadcast(:empty_cart)
        end

        it 'does not broadcast :empty_cart if items exists' do
          allow(order).to receive_message_chain(:items, :exists?) { true }

          expect(service.call).not_to broadcast(:empty_cart)
        end
      end

      context 'if complete step' do
        let(:step) { :complete }

        it 'does not broadcast :empty_cart if items do not exist' do
          allow(order).to receive_message_chain(:items, :exists?) { false }

          expect(service.call).not_to broadcast(:empty_cart)
        end
      end
    end

    context 'step address' do
      let(:step) { :address }

      it 'always broadcasts :allowed' do
        expect(service.call).to broadcast(:allowed)
      end
    end

    context 'step delivery' do
      let(:step) { :delivery }

      it 'broadcasts :allowed' do
        expect(service.call).to broadcast(:allowed)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_address) { nil }

        expect(service.call).to broadcast(:denied)
      end
    end

    context 'step payment' do
      let(:step) { :payment }

      it 'broadcasts :allowed' do
        expect(service.call).to broadcast(:allowed)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_address) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_method) { nil }

        expect(service.call).to broadcast(:denied)
      end
    end

    context 'step confirm' do
      let(:step) { :confirm }

      it 'broadcasts :allowed' do
        expect(service.call).to broadcast(:allowed)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_address) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_method) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:credit_card) { nil }

        expect(service.call).to broadcast(:denied)
      end
    end

    context 'step complete' do
      let(:step) { :complete }

      it 'broadcasts :allowed' do
        allow(order).to receive(:in_queue?) { true }

        expect(service.call).to broadcast(:allowed)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_address) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:shipping_method) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        allow(order).to receive(:credit_card) { nil }

        expect(service.call).to broadcast(:denied)
      end

      it 'broadcasts :denied' do
        expect(service.call).to broadcast(:denied)
      end
    end
  end

  describe '#last_allowed' do
    let(:step) { nil }
    
    context 'if order without addresses' do
      before { allow(order).to receive(:shipping_address) { nil } }

      it { expect(service.last_allowed).to eq(:address) }
    end

    context 'if order without delivery' do
      before { allow(order).to receive(:shipping_method)  { nil } }

      it { expect(service.last_allowed).to eq(:delivery) }
    end

    context 'if order without payment' do
      before { allow(order).to receive(:credit_card)  { nil } }

      it { expect(service.last_allowed).to eq(:payment) }
    end

    context 'if order with addresses, delivery, payment' do
      it { expect(service.last_allowed).to eq(:confirm) }
    end
  end
end