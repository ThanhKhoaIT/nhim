// Functions

function selectedItemType() {
  if (selectedItem === null) return null;
  return selectedItem.data('itemtype');
}

function selectedItemId() {
  if (selectedItem === null) return null;
  return selectedItem.data('id');
}

function requestObjectData() {
  return {
    type: selectedItemType(),
    id: selectedItemId(),
  }
}

function showContextmenu(event) {
  var left, top;
  left = min(event.clientX, window.innerWidth - 250);
  top = min(event.clientY, window.innerHeight - $('#actions').height() - 30);
  $('#actions').fadeIn('fast').css({ left: left, top: top });

  var currentMode = $('#main-list').data('mode');

  $('#actions ul').hide();
  $('#actions ul[data-mode="' + currentMode + '"]').show();

  if (selectedItem.data('starred')) {
    $('#actions ul li a[data-action="star"] .name').html('Remove from Starred');
  } else {
    $('#actions ul li a[data-action="star"] .name').html('Add to Starred');
  }
}

function hideContextmenu() {
  $('#actions').fadeOut('fast');
}

// Events

$(document).delegate('#main-list li[data-itemtype]', 'contextmenu', function(event) {
  event.preventDefault();
  window.selectedItem = null;
  $('#main-list li').removeClass('selected');
  $(this).addClass('selected');
  window.selectedItem = $(this);
  showContextmenu(event);
});

$(document).on('scroll', hideContextmenu).delegate('html', 'click', function(event) {
  if (event.target.nodeName === 'LI') return;
  hideContextmenu();
});

$(document).delegate('a[data-action="rename"]', 'click', function(event) {
  event.preventDefault();
  $.get(window.nhimConfig.rename_object_path, requestObjectData(), function(html) {
    showHtmlModal(html);
  });
});

$(document).delegate('a[data-action="remove"]', 'click', function(event) {
  event.preventDefault();
  var isConfirm = window.confirm('Are you sure?');
  if (isConfirm) {
    $.ajax({
      url: window.nhimConfig.remove_object_path,
      method: 'delete',
      data: requestObjectData(),
    });
  }
});

$(document).delegate('a[data-action="star"]', 'click', function(event) {
  event.preventDefault();
  if (selectedItem.data('starred') === true) {
    $.ajax({
      url: window.nhimConfig.remove_star_object_path,
      method: 'delete',
      data: requestObjectData(),
    });
  } else {
    $.ajax({
      url: window.nhimConfig.star_object_path,
      method: 'post',
      data: requestObjectData(),
    });
  }
});

$(document).delegate('a[data-action="restore"]', 'click', function(event) {
  event.preventDefault();
  $.ajax({
    url: window.nhimConfig.restore_object_path,
    method: 'patch',
    data: requestObjectData(),
  });
});
