$(document).delegate('html', 'click', function(event) {
  if (event.target.nodeName === 'A') return;
  $('.dropdown-actions').fadeOut('fast');
});

$(document).delegate('a[data-toggle="dropdown-actions"]', 'click', function(event) {
  event.preventDefault();
  var selector = $(this).attr('href');
  $(selector).fadeIn('fast');
});

$(document).delegate('.modal-content [data-type="submit"]', 'click', function(event) {
  event.preventDefault();
  $(this).parents('.modal').find('form').submit();
});

$(document).delegate('#main-list li[data-dbclick]', 'click', function(event) {
  event.preventDefault();
  $('#main-list li').removeClass('selected');
  $(this).addClass('selected');
});

$(document).delegate('[data-dbclick]', 'dblclick', function(event) {
  event.preventDefault();
  $.get($(this).data('dbclick') + '.js');
});

$(document).delegate('[data-toggleclass]', 'click', function(event) {
  event.preventDefault();
  $(this).toggleClass($(this).data('toggleclass'));
});

$(document).delegate('a[data-js]', 'click', function(event) {
  event.preventDefault();
  $.get($(this).attr('href') + '.js');
});

$(document).delegate('html', 'contextmenu', function(event) {
  event.preventDefault();
});
