RSpec.feature 'Catalog' do
  background do
    seed
  end

  context 'elements' do
    let(:books_on_page) { all('.book') }
    let(:books)         { Book.order(title: :asc).limit(12) }

    background { visit books_path }

    scenario 'has 12 results ordered by title asc' do
      expect(books_on_page.length).to eq(12)
      books_on_page.each_with_index do |book_on_page, index|
        expect(book_on_page.find('.title').text).to eq(books[index].title)
      end
    end

    scenario 'each item has a Photo, Name, Author(s), and Price (€ 00.00)' do
      books_on_page.each do |book_on_page|
        expect(book_on_page.find('.general-thumbnail-img')[:src]).to match('book_default')
        expect(book_on_page.find('.price').text).to match(/\A[ \.€\d]+\z/)
        expect(book_on_page.find('.authors').text).to match(/\A[ ,'A-Za-z]+\z/)
      end
    end
  end

  context 'use cases' do
    scenario 'user can choose category and sorting', js: true do
      visit root_path

      expect(page).not_to have_link('Photo')

      find('header').click_link('Shop')
      click_link('Photo')
      expect(page).to have_current_path('/books/category-photo')

      click_link('Web design')
      expect(page).to have_current_path('/books/category-web_design')

      click_link('Title: A-Z')
      click_link('Newest first')
      expect(page).to have_current_path('/books/category-web_design?sort_by=newest')
    end

    scenario 'user can load more results', js: true do
      visit books_path

      expect(page).to have_link('View more')

      expect(page).to have_css('.book', count: 12)
      click_link('View more')
      expect(page).to have_css('.book', count: 24)
    end
  end

  private

  def seed
    authors = create_list(:author, 3)
    
    %w[Mobile\ development Photo Web\ design Web\ development].each do |category|
      category = create(:category, name: category)
      create_list(:book, 20, category: category, authors: authors.sample(2))
    end
  end
end