feature 'Cart' do
  let(:coupon) { create(:coupon) }
  let(:user)   { create(:user) }

  background do
    items = build_list(:order_item, 3)
    order = create(:order, items: items)
    
    allow_any_instance_of(ApplicationController).to receive(:current_order) { order }

    visit cart_path
  end

  scenario 'user can update cart', js: true do
    click_on('Update Cart')
    expect(page).to have_content('Your cart was successfully updated.')
  end

  scenario 'user can destroy item', js: true do
    first('span', text: '×').click
    expect(page).to have_content('The product was successfully deleted from cart.')
  end

  scenario 'user can apply coupon' do
    fill_in('Your Coupon', with: coupon.code)
    click_on('Apply Coupon')

    expect(page).to have_content('Coupon is applied.')
    expect(page).to have_content('Coupon:')
    expect(page).to have_content(/-\d+.\d+/)
  end

  scenario 'user can checkout' do
    sign_in(user)

    click_on('Checkout')

    expect(page).to have_current_path('/checkout/address')
  end

  scenario 'guest cannot checkout' do
    click_on('Checkout')

    expect(page).to have_current_path('/users/sign_up?type=quick')
  end
end