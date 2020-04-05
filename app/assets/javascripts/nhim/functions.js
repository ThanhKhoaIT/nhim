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
