RSpec.describe 'Checkouter', type: :service do
  subject(:service) { Checkouter.new(order, params, step) }

  let(:params) { double('params') }
  let(:order)  { build(:order) }

  describe '#call' do
    context 'address step' do
      let(:step) { :address }

      it 'calls address_params and broadcasts :ok with order' do
        expect(order).to receive(:assign_attributes)
        expect(service).to receive(:address_params)
        expect { service.call }.to broadcast(:ok, order)
      end
    end

    context 'delivery step' do
      let(:step) { :delivery }

      it 'calls delivery_params and broadcasts :ok with order' do
        expect(order).to receive(:assign_attributes)
        expect(service).to receive(:delivery_params)
        expect { service.call }.to broadcast(:ok, order)
      end
    end

    context 'payment step' do
      let(:step) { :payment }

      it 'calls payment_params and broadcasts :ok with order' do
        expect(order).to receive(:assign_attributes)
        expect(service).to receive(:payment_params)
        expect { service.call }.to broadcast(:ok, order)
      end
    end

    context 'confirm step' do
      let(:step) { :confirm }

      it 'calls delivery_params and broadcasts :ok with order' do
        expect(order).to receive(:confirm)
        expect { service.call }.to broadcast(:ok, order)
      end
    end
  end
end