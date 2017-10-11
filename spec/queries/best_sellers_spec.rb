RSpec.describe BestSellers do
  describe '#query' do
    it 'returns books with max order_items_count from each category' do
      web_dev = create(:category_with_books, name: 'Web dev')
      mob_dev = create(:category_with_books, name: 'Mobile dev')

      best_from_web = create(:book, order_items_count: 100, category: web_dev)
      best_from_mob = create(:book, order_items_count: 100, category: mob_dev)

      expect(subject.query).to contain_exactly(best_from_web, best_from_mob)
    end
  end
end