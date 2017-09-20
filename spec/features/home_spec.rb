feature 'Home' do
  scenario 'has latest, get started, best sellers blocks' do
    create_list(:category_with_books, 4)
    
    visit root_path

    expect(page).to have_link('Get Started!', href: books_path)
    expect(page).to have_selector('#slider .item', count: 3)
    expect(page).to have_selector('.general-thumb-wrap', count: 4)
  end
end