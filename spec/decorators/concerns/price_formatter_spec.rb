
class Stub
  def price
  end
end

RSpec.describe 'PriceFormatter' do
  subject(:extended_class) { klass.extend(PriceFormatter) }

  let(:klass) { Stub }
  let(:value) { double('price') }

  before do
    allow_any_instance_of(klass).to receive(:price) { value }
  end

  describe '::format_price' do
    it 'is defined' do
      expect(extended_class).to respond_to(:format_price)
    end

    it 'defines method formatted_price' do
      extended_class.format_price(:price)
      expect(extended_class.new).to respond_to(:formatted_price)
    end

    context 'defined method' do
      it 'call to_s on result of klass#price' do
        expect(value).to receive(:to_s).with(:currency)
        extended_class.format_price(:price)
        extended_class.new.formatted_price
      end
    end
  end
end