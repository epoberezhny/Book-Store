RSpec.describe 'ReviewDecorator' do
  subject(:decorated_model) { ReviewDecorator.new(model) }

  let(:model) { create(:review, created_at: Time.utc(2002, 10, 30)) }

  describe '#formatted_date' do
    it 'returns date in dd/mm/yy format' do
      expect(decorated_model.formatted_date).to eq('30/10/02')
    end
  end
end