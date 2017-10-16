feature 'Cart' do
  let(:coupon) { create(:coupon) }
  let(:user)   { create(:user) }

  background do
    items = build_list(:order_item, 3)
    order = create(:order, items: items)
    
    allow_any_instance_of(ApplicationController).to receive(:current_order) { order }

    visit shopping_cart.cart_path
  end

  scenario 'user can update cart', js: true do
    click_on( I18n.t('cart.update_cart') )
    expect(page).to have_content( I18n.t('shopping_cart.orders.update.valid') )
  end

  scenario 'user can destroy item', js: true do
    first('span', text: '×').click
    expect(page).to have_content( I18n.t('shopping_cart.order_items.destroy.destroyed') )
  end

  scenario 'user can apply coupon' do
    fill_in( I18n.t('simple_form.labels.coupon.code'), with: coupon.code )
    click_on( I18n.t('cart.apply_coupon') )

    expect(page).to have_content( I18n.t('shopping_cart.orders.apply_coupon.applied') )
    expect(page).to have_content( I18n.t('shared.coupon') )
    expect(page).to have_content(/-\d+.\d+/)
  end

  scenario 'user can checkout' do
    sign_in(user)

    click_on( I18n.t('cart.checkout') )

    expect(page).to have_current_path('/checkout/address')
  end

  scenario 'guest cannot checkout' do
    click_on( I18n.t('cart.checkout') )

    expect(page).to have_current_path('/users/sign_up?type=quick')
  end
end