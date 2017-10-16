RSpec.feature 'Checkout/Addresses' do
  let(:country) { create(:country, name: 'Ukraine') }
  let(:order)   { create(:order_with_items) }
  let(:user)    { create(:user) }

  background do
    allow_any_instance_of(ShoppingCart::CheckoutController).to receive(:current_order) { order }
  end

  context 'use cases' do
    background do
      create(:country, name: 'USA')
      sign_in(user)
      visit 'checkout/address'
    end
    
    scenario 'logged in user can set adresses' do
      fill_in_address(:billing_address)
      fill_in_address(:shipping_address)
      click_on( I18n.t('checkout.save_and_continue') )

      expect(ShoppingCart::ShippingAddress.count).to eq(1)
      expect(ShoppingCart::BillingAddress.count).to eq(1)
      expect(page).to have_current_path('/checkout/delivery')
    end

    scenario 'use billing address', js: true do
      fill_in_address(:billing_address)
      find('#use_billing_address', visible: false).trigger('click')
      click_on( I18n.t('checkout.save_and_continue') )

      expect(ShoppingCart::ShippingAddress.count).to eq(1)
      expect(ShoppingCart::BillingAddress.count).to eq(1)
      expect(ShoppingCart::ShippingAddress.first.attributes)
        .to include ShoppingCart::BillingAddress.first.attributes.except('id', 'created_at', 'updated_at', 'type')
      expect(page).not_to have_css('#shipping_address', visible: true)
      expect(page).to have_current_path('/checkout/delivery')
    end
  end

  context 'autofill' do
    let(:shipping_address) { build(:shipping_address, country: country) }
    let(:billing_address)  { build(:billing_address, country: country) }

    background do
      user.shipping_address = shipping_address
      user.billing_address = billing_address
      sign_in(user)
      visit 'checkout/address'
    end

    scenario 'autofill' do
      [:shipping_address, :billing_address].each do |address|
        within("##{address}") do
          expect(find_field( I18n.t('address.first_name') ).value).to   eq( send(address).first_name   )
          expect(find_field( I18n.t('address.last_name') ).value).to    eq( send(address).last_name    )
          expect(find_field( I18n.t('address.address_line') ).value).to eq( send(address).address_line )
          expect(find_field( I18n.t('address.city') ).value).to         eq( send(address).city         )
          expect(find_field( I18n.t('address.zip') ).value).to          eq( send(address).zip          )
          expect(find_field( I18n.t('address.phone') ).value).to        eq( send(address).phone        )
        end
      end
    end
  end

  def fill_in_address(type)
    within("##{type}") do
      fill_in( I18n.t('address.first_name'),    with: 'Vanya' )
      fill_in( I18n.t('address.last_name'),     with: 'Petya' )
      fill_in( I18n.t('address.address_line'),  with: 'Center')
      fill_in( I18n.t('address.city'),          with: 'Dnepr' )
      fill_in( I18n.t('address.zip'),           with: '21345' )
      fill_in( I18n.t('address.phone'),         with: '+3809811112233')
      select('USA', from: I18n.t('address.country') )
    end
  end
end