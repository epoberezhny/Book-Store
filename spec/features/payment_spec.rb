RSpec.feature 'Checkout/Payment' do
  let(:order)   { create(:order_with_shipping_method, user: user) }
  let(:user)    { create(:user) }

  background do
    allow_any_instance_of(ShoppingCart::CheckoutController).to receive(:current_order) { order }
    sign_in(user)
    visit 'checkout/payment'
  end
    
  scenario 'logged in user can set payment' do
    fill_in('Number', with: '1111222233334444')
    fill_in('Name on Card', with: 'Vasya Vasya')
    fill_in('MM / YY', with: '11/22')
    fill_in('CVV', with: '123')

    click_on('Save and Continue')

    expect(ShoppingCart::CreditCard.count).to eq(1)
    expect(ShoppingCart::Order.first.credit_card).not_to be_blank
    expect(page).to have_current_path('/checkout/confirm')
  end
end