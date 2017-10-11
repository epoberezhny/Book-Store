RSpec.describe 'AddOrderItem', type: :service do
  subject(:service) { AddOrderItem.new(order, params) }

  let(:params) { double('params') }
  let(:order)  { build(:order) }

  before do
    allow(params).to receive_message_chain(:require, :permit)
    allow(order).to receive(:add_item).with(instance_of(OrderItem))
  end

  describe '#call' do
    context 'order is new record' do
      it 'saves order before adding item' do
        allow(order).to receive(:new_record?) { true }
        expect(order).to receive(:save).twice
        service.call
      end
    end

    context 'order is new record' do
      it 'does not save order before adding item' do
        allow(order).to receive(:new_record?) { false }
        expect(order).to receive(:save).once
        service.call
      end
    end

    context 'ok' do
      it 'broadcats :ok with order' do
        allow(order).to receive(:save).and_return(true)
        expect(order).to receive(:add_item).with(instance_of(OrderItem))

        expect { service.call }.to broadcast(:ok, order)
      end
    end

    context 'error' do
      it 'broadcats :ok with order' do
        allow(order).to receive(:save).and_return(false)
        expect(order).to receive(:add_item).with(instance_of(OrderItem))
        
        expect { service.call }.to broadcast(:error)
      end
    end
  end
end