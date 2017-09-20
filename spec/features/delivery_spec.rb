RSpec.feature 'Checkout/Delivery' do
  let(:order)   { create(:order_with_addresses, user: user) }
  let(:user)    { create(:user) }

  background do
    allow_any_instance_of(CheckoutController).to receive(:current_order) { order }
    create_list(:shipping_method, 3, country: order.shipping_address.country)
    sign_in(user)
    visit 'checkout/delivery'
  end
    
  scenario 'logged in user can choose shipping method', js: true do
    expect(find('#delivery').text).to eq('5.00 €')
    expect(find('#total').text).to eq('5.00 €')

    find('span', text: 'Method2').trigger('click')

    expect(find('#delivery').text).to eq('10.00 €')
    expect(find('#total').text).to eq('10.00 €')

    click_on('Save and Continue')

    expect(Order.first.shipping_method).not_to be_blank
    expect(page).to have_current_path('/checkout/payment')
  end
end