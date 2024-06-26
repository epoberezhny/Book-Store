RSpec.feature 'Book' do
  background do
    @book = create(:book_with_authors)
  end

  context 'use cases' do
    scenario 'user can view book', js: true do
      visit books_path

      find('.book').hover
      find('i.fa.fa-eye').click

      expect(page).to have_current_path(book_path(id: @book.id), only_path: true)
    end

    scenario 'user can choose quantity', js: true do
      visit book_path(id: @book.id)

      expect(page).to have_field('order_item[quantity]', with: 1, readonly: true)

      expect { find('.fa-plus').click }
        .to change { find_field('order_item[quantity]', readonly: true).value.to_i }.by(1)
      
      expect { find('.fa-minus').click }
        .to change { find_field('order_item[quantity]', readonly: true).value.to_i }.by(-1)
    end

    scenario 'user can add to cart', js: true do
      visit book_path(id: @book.id)

      click_on('Add to Cart')

      expect(Order.count).to eq(1)
      expect(OrderItem.count).to eq(1)
      expect(page).to have_content('The product was successfully added to cart.')
    end

    context 'write a review' do
      let(:user) { create(:user) }

      scenario 'logged in user can write a review', js: true do
        sign_in(user)
        visit book_path(id: @book.id)

        within('#new_review') do
          fill_in('Title', with: 'Title')
          fill_in('Review', with: 'The best book ever!!!1111')
          choose('review_score_3', allow_label_click: true)
          click_on('Post')
        end

        expect(page).to have_content('Reviews (0)')
        expect(Review.count).to eq(1)
        expect(Review.first.attributes)
          .to include({ 'state' => 'unprocessed', 'score' => 3 })
      end

      scenario 'guest cannot write a review' do
        visit book_path(id: @book.id)
        
        expect(page).not_to have_css('#new_review')
      end
    end
  end
end