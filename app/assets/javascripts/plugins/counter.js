/* ========================================================================
 * counter.js v1.0.0
 * Inspired by BookStore home work in RG
 * ========================================================================
 * Copyright 2017 Eugene Poberezhny
 * ======================================================================== */

;(function($){
  'use strict';
  
  var selector = '[data-role="counter"]';
  
  function Counter(counterContainer, options) {
    this.counterInput = counterContainer.find('input[type="text"]').first();
    this.options      = $.extend({}, Counter.DEFAULTS, counterContainer.data(), options);
    
    this.init(counterContainer);
  }
  
  Counter.DEFAULTS = {
    increment: 1,
    default:   0,
    min:       null,
    max:       null
  }
  
  Counter.prototype.init = function(counterContainer) {
    this.counterInput.attr('readonly', true).val(this.options.default);
    counterContainer.find('[data-value="prev"]').click( $.proxy(this.prev, this) );
    counterContainer.find('[data-value="next"]').click( $.proxy(this.next, this) );
  }
  
  Counter.prototype.prev = function(event) {
    if (event) event.preventDefault();
    
    var newValue = parseInt( this.counterInput.val() ) - this.options.increment;
    var outOfRange = (this.options.min != null) && (newValue < this.options.min);
    
    if (outOfRange) return;
    this.counterInput.val(newValue);
  }
  
  Counter.prototype.next = function(event) {
    if (event) event.preventDefault();
    
    var newValue = parseInt( this.counterInput.val() ) + this.options.increment;
    var outOfRange = (this.options.max != null) && (newValue > this.options.max);
    
    if (outOfRange) return;
    this.counterInput.val(newValue);
  }
  
  function Plugin(option) {
    return this.each(function() {
      var $this   = $(this);
      var data    = $this.data('ep.counter');
      var options = (typeof option == 'object') && option;

      if (!data) $this.data('ep.counter', (data = new Counter($this, options)));
      if (typeof option == 'string') data[option]();
    });
  }
  
  $.fn.counter = Plugin;
  
  $(selector).counter();
})(jQuery);
