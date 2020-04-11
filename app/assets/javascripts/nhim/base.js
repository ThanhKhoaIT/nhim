Array.prototype.last = function() {
  return this[this.length - 1];
}

$(document).ready(function() {
  window.mainTree = new Tree('#main-tree', {
    target: '#toggle-tree',
    ajax: $('#main-tree').data('ajax'),
  });
  window.mainTree.render();
});
