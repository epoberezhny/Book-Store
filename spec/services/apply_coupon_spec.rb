RSpec.describe 'ApplyCoupon', type: :service do
  subject(:service) { ApplyCoupon.new(order, code) }

  let(:code)   { 'code' }
  let(:order)  { build(:order) }
  let(:coupon) { build(:coupon) }

  describe '#call' do
    context 'if coupon does not exist' do
      before do
        expect(Coupon).to receive(:find_by) { nil }
      end

      it 'broadcasts :null' do
        expect { service.call }.to broadcast(:null)
      end

      it 'does not broadcast :expired' do
        expect { service.call }.not_to broadcast(:expired)
      end

      it 'does not broadcast :applied' do
        expect { service.call }.not_to broadcast(:applied)
      end
    end

    context 'if coupon expired' do
      before do
        expect(coupon).to receive(:expired?) { true }
        expect(Coupon).to receive(:find_by)  { coupon }
      end
      
      it 'broadcasts :expired' do
        expect { service.call }.to broadcast(:expired)
      end

      it 'does not broadcast :null' do
        expect { service.call }.not_to broadcast(:null)
      end

      it 'does not broadcast :applied' do
        expect { service.call }.not_to broadcast(:applied)
      end
    end

    context 'if coupon exists and not expired' do
      before do
        expect(coupon).to receive(:expired?) { false }
        expect(Coupon).to receive(:find_by)  { coupon }
        expect(order) .to receive(:update)
      end
      
      it 'broadcasts :applied' do
        expect { service.call }.to broadcast(:applied)
      end

      it 'does not broadcast :null' do
        expect { service.call }.not_to broadcast(:null)
      end

      it 'does not broadcast :expired' do
        expect { service.call }.not_to broadcast(:expired)
      end
    end
  end
end