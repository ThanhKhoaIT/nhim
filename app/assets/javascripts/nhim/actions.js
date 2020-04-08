// Functions

function selectedItemType() {
  if ($('ul#main-list li.selected').length === 0) return null;
  if ($('ul#main-list li.selected').length > 1) return 'multiple';
  return $('ul#main-list li.selected').data('itemtype');
}

function selectedItemId() {
  if ($('ul#main-list li.selected').length === 0) return null;
  if ($('ul#main-list li.selected').length > 1) return 'multiple';
  return $('ul#main-list li.selected').data('id');
}

// Events

$(document).delegate('#main-list li[data-link]', 'contextmenu', function(event) {
  event.preventDefault();
  $('#main-list li').removeClass('selected');
  $(this).addClass('selected');
  var left, top;
  left = min(event.clientX, window.innerWidth - 250);
  top = min(event.clientY, window.innerHeight - $('#actions').height() - 30);
  $('#actions').fadeIn('fast').css({ left: left, top: top });
});

$(document).on('scroll', function(event) {
  $('#actions').fadeOut('fast');
});

$(document).delegate('html', 'click', function(event) {
  if (event.target.nodeName === 'LI') return;
  $('#actions').fadeOut('fast');
});

$(document).delegate('a[data-action="rename"]', 'click', function(event) {
  event.preventDefault();
  var selectedType = selectedItemType();
  var selectedId = selectedItemId();
  $.get(window.nhimConfig.rename_object_path, {
    type: selectedItemType,
    id: selectedItemId,
  }, function(html) {
    showHtmlModal(html);
  });
});

$(document).delegate('a[data-action="remove"]', 'click', function(event) {
  event.preventDefault();
  var selectedType = selectedItemType();
  var selectedId = selectedItemId();
  $.ajax({
    url: window.nhimConfig.remove_object_path,
    method: 'delete',
    data: {
      type: selectedItemType,
      id: selectedItemId,
    }
  })
});

