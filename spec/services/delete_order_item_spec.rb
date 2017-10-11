RSpec.describe 'DeleteOrderItem', type: :service do
  subject(:service) { DeleteOrderItem.new(order, params) }

  let(:params) { Hash.new(1) }
  let(:order)  { build(:order) }

  describe '#call' do
    it 'deletes item from order and saves order' do
      expect(order).to receive(:save)
      expect(order)
        .to receive_message_chain(:items, :find, :destroy)
          .with(no_args).with(1).with(no_args)

      service.call
    end
  end
end