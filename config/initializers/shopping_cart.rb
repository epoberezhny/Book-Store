ShoppingCart.config do |c|
  c.customer_devise_scope = :user

  c.counter_cache_for_products_to_order_items = true

  c.authenticate_with do
    next if user_signed_in?
    store_location_for(:user, shopping_cart.checkout_index_path)
    redirect_to main_app.new_user_registration_path(type: :quick)
  end
end