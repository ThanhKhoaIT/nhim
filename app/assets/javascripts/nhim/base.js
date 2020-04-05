$(document).delegate('html', 'click', function(event) {
  if (event.target.nodeName != 'A') {
    event.preventDefault();
    $('.dropdown-actions').fadeOut('fast');
  }
});

$(document).delegate('html', 'click', function(event) {
  if (event.target.nodeName != 'LI') {
    event.preventDefault();
    hideActions();
  }
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

$(document).delegate('#main-list li[data-link]', 'click', function(event) {
  event.preventDefault();
  $('#main-list li').removeClass('selected');
  $(this).addClass('selected');
});

$(document).delegate('#main-list li[data-link]', 'dblclick', function(event) {
  event.preventDefault();
  window.location.pathname = $(this).data('link');
});

$(document).delegate('html', 'contextmenu', function(event) {
  event.preventDefault();
});

$(document).on('scroll', function(event) {
  hideActions();
});

$(document).delegate('#main-list li[data-link]', 'contextmenu', function(event) {
  event.preventDefault();
  $('#main-list li').removeClass('selected');
  $(this).addClass('selected');
  showActions(event);
});
