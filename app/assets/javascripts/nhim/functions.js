function closeModal() {
  $('.modal.show').modal('hide');
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

function showActions(event) {
  var left, top;
  left = min(event.clientX, window.innerWidth - 250);
  top = min(event.clientY, window.innerHeight - $('#actions').height() - 30);
  $('#actions').fadeIn('fast').css({ left: left, top: top });
}

function hideActions() {
  $('#actions').fadeOut('fast');
}

function min(numA, numB) {
  return numA < numB ? numA : numB;
}
