(function($) {
  'use strict';

  $('[data-toggle="tooltip"]').tooltip();

  bindClickToCheckbox();
  initShippingPriceChanging();

  function bindClickToCheckbox() {
    var $shippingAddressFields = $('#shipping_address');

    $('#use_billing_address').click(function() {
      $shippingAddressFields.slideToggle();
    });
  }

  function initShippingPriceChanging() {
    var $methods = $('.method');
    var $radios = $methods.find('input[type="radio"]');

    $radios
      .each(function() {
        if (!this.checked) return;
        var price = $(this).data('price');
        changeDeliveryPrice(price);
      })
      .click(function() {
        var price = $(this).data('price');
        changeDeliveryPrice(price);
      });
  }

  function changeDeliveryPrice(price) {
    var $deliveryPrice = $('#delivery');
    var $totalPrice    = $('#total');
    
    price = parseFloat(price);

    var total            = parseFloat( $totalPrice.data('total') ),
        oldDeliveryPrice = $deliveryPrice.text(),
        oldTotalPrice    = $totalPrice.text(),
        newDeliveryPrice = price.toFixed(2),
        newTotalPrice    = (total + price).toFixed(2);

    $deliveryPrice.text( oldDeliveryPrice.replace(/[,\.\d]+/, newDeliveryPrice) );
    $totalPrice.text( oldTotalPrice.replace(/[,\.\d]+/, newTotalPrice) );
  }
})(jQuery)
