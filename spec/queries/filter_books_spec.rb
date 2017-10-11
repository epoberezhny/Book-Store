RSpec.describe 'FilterBooks' do
  let(:web_dev) { create(:category, name: 'Web dev') }
  let(:mob_dev) { create(:category, name: 'Mob dev') }

  let(:web_dev_books) { create_list(:book, 10, category: web_dev) }
  let(:mob_dev_books) { create_list(:book, 10, category: mob_dev) }

  describe '#query' do
    context 'with blank category' do
      it 'returns all books' do
        query_object = FilterBooks.new('')
        ary_of_books = web_dev_books + mob_dev_books

        expect(query_object.query).to match_array(ary_of_books)
      end
    end

    context 'with existed category' do
      it 'returns books in selected category' do
        query_object = FilterBooks.new(web_dev.to_param)
        ary_of_books = web_dev_books

        expect(query_object.query).to match_array(ary_of_books)
      end
    end
  end
end