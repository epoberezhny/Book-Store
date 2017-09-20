module CheckoutHelper
  def address_placeholder(type)
    current_order.send("#{type}_address") ||
      current_user.send("#{type}_address").tap { |adr| adr.id = nil if adr } ||
      current_order.send("build_#{type}_address")
  end

  def credit_card_placeholder
    current_order.credit_card || current_order.build_credit_card
  end
end
