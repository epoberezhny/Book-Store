feature 'Checkout login' do
  let(:order) { create(:order_with_items) }
  let(:user)  { create(:user, email: 'aa@bb.cc', password: 'A1somepassword') }

  background do
    allow_any_instance_of(ShoppingCart::CheckoutController).to receive(:current_order) { order }
  end

  scenario 'user redirected to checkout after login'do
    visit(shopping_cart.checkout_index_path)
    
    expect(page).to have_current_path( new_user_registration_path(type: :quick) )

    within('#login') do
      login user.email, user.password
    end

    expect(page).to have_current_path('/checkout/address')
    expect(page).to have_content 'Signed in successfully'
  end

  def login(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end