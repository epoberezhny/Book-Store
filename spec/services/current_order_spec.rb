RSpec.describe 'CurrentOrder', type: :service do
  subject(:service) { CurrentOrder.new(controller) }

  let(:controller)   { double('controller') }
  let(:order)        { build(:order) }
  let(:user)         { build(:user) }

  describe '#call' do
    context 'if user signed out and no cookies' do
      before do
        allow(controller).to receive_message_chain(:cookies, :encrypted) { Hash.new }
        allow(controller).to receive(:user_signed_in?) { false }
      end

      it 'returns new order' do
        order = service.call

        expect(order).to be_instance_of(Order)
        expect(order).to be_new_record
        expect(order.user).to be_nil
      end
    end

    context 'if user signed out and cookies present' do
      before do
        allow(controller).to receive_message_chain(:cookies, :encrypted).and_return(cart_id: 1)
        allow(controller).to receive(:user_signed_in?) { false }
      end

      it 'returns order from cookie' do
        expect(Order).to receive_message_chain(:in_progress, :find_by).with(id: 1) { order }

        expect(service.call).to eq(order)
      end
    end

    context 'if user signed in' do
      before do
        allow(controller).to receive(:current_user)    { user }
        allow(controller).to receive(:user_signed_in?) { true }
      end

      context 'cookie present' do
        let(:order_from_cookie) { double('order') }

        before do
          allow(controller).to receive_message_chain(:cookies, :encrypted).and_return(cart_id: 1)
          allow(user).to receive_message_chain(:orders, :in_progress, :last) { order }
          allow(Order).to receive_message_chain(:in_progress, :find_by) { order_from_cookie }
        end

        it 'merges orders and deletes cookie' do
          expect(order).to receive(:merge!).with(order_from_cookie)
          expect(controller).to receive_message_chain(:cookies, :delete).with(:cart_id)

          service.call
        end
      end

      context 'cookie blank' do
        before do
          allow(controller).to receive_message_chain(:cookies, :encrypted) { Hash.new }
        end

        context 'user has orders in progress' do
          it "returns user's order" do
            expect(user).to receive_message_chain(:orders, :in_progress, :last) { order }

            expect(service.call).to eq(order)
          end
        end

        context 'user does not have orders in progress' do
          before do
            allow(user).to receive_message_chain(:orders, :in_progress, :last) { nil }
          end

          it "returns new user's order" do
            expect(user).to receive_message_chain(:orders, :new) { order }

            expect(service.call).to eq(order)
          end
        end
      end
    end
  end
end