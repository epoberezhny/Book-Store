RSpec.describe 'Paginate' do
  describe '#query' do
    it 'returns paginated relation' do
      relation = double('relation')
      expect(relation)
        .to receive_message_chain(:page, :per, :without_count)
          .with(1).with(5).with(no_args)

      Paginate.new(relation, 1, 5).query
    end
  end
end