// Press ESC key to close modal

$(document).bind('keydown', function(e){
  var charCode = e.which || e.keyCode;
  if(charCode === 27) closeModal();
});

// Auto focus input in modal

$(document).delegate('#add-folder-modal', 'shown.bs.modal', function() {
  $('#new_folder_name').focus().select();;
});

$(document).delegate('.rename-object-modal', 'shown.bs.modal', function() {
  $('#new_name').focus().select();;
});

// Functions

function closeModal() {
  $('.modal.show').modal('hide');
}

function showHtmlModal(html) {
  var randomId = Math.random().toString(36).substring(3);
  $('<div/>').attr({id: randomId}).html(html).appendTo('body');
  $("#" + randomId + " .modal").modal('show');
}

