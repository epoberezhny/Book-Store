(function($) {
  'use strict';

  var $description = $('.desc');

  $('#read-more').click(function(event) {
    event.preventDefault();
    $description.toggle();
  });
})(jQuery)