function refreshFolder() {
  var refreshUrl = $('ul#main-list').data('refresh');
  $.get(refreshUrl, function(html) {
    $('ul#main-list').replaceWith(html);
  })
}

function changeFolder(folder) {
  window.currentFolder = folder;
  $('#new_parent_id').val(this.currentFolder.id)
  $('#main-list').attr('data-refresh', this.currentFolder.link);
  refreshFolder();
}

function nhimNotify(message) {
  $.notify(message, {
    type: 'nhim',
    timer: 50,
    placement: {
      from: 'bottom',
      align: 'left',
    },
  });
}

function min(numA, numB) {
  return numA < numB ? numA : numB;
}
