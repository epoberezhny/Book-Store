feature 'Header Footer' do
  let(:header) { find('header') }
  let(:footer) { find('footer') }

  context 'guest' do
    background { visit root_path }

    scenario 'header has home, shop, log in, sign up, cart' do
      expect(header).to have_link('Home', href: root_path)
      expect(header).to have_link('Shop')
      expect(header).to have_link('Log in', href: new_user_session_path)
      expect(header).to have_link('Sign up', href: new_user_registration_path)
      expect(header).not_to have_link('My account')
      expect(header).to have_selector('.shop-icon')
    end

    scenario 'footer has home, shop, email, socials' do
      expect(footer).to have_link('Home', href: root_path)
      expect(footer).to have_link('Shop', href: books_path)
      expect(footer).to have_content('support@bookstore.com')
      expect(footer).to have_content('(555)-555-5555')
      expect(footer).not_to have_link('Orders', href: users_orders_path)
      expect(footer).not_to have_link('Settings', href: edit_user_registration_path)
      ['facebook', 'twitter', 'google-plus', 'instagram'].each do |social|
        expect(footer).to have_selector("i.fa.fa-#{social}")
      end
    end
  end

  context 'logged in user' do
    let(:user) { create(:user) }

    background do
      sign_in(user)
      visit root_path
    end

    scenario 'header has home, shop, my account, cart' do
      expect(header).to have_link('Home', href: root_path)
      expect(header).to have_link('Shop')
      expect(header).not_to have_link('Log in', href: new_user_session_path)
      expect(header).not_to have_link('Sign up', href: new_user_registration_path)
      expect(header).to have_link('My account')
    end

    scenario 'footer has home, shop, orders, settings, email, socials' do
      expect(footer).to have_link('Home', href: root_path)
      expect(footer).to have_link('Shop', href: books_path)
      expect(footer).to have_link('Orders', href: users_orders_path)
      expect(footer).to have_link('Settings', href: edit_user_registration_path)
    end
  end
end