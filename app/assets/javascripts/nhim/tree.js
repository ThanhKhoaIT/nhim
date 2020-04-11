function Tree(selector, options) {
  var _options = options;
  var _defaultOptions = {
    data: [],
    target: '#tree-root',
  };
  this.nodes = [];
  this.showIds = [];
  this.isShow = false;
  this.container = document.querySelector(selector);
  this.options = Object.assign(_defaultOptions, _options);
  this.rootTarget = document.querySelector(this.options.target);
  this.loadEvents();
}

Tree.prototype.render = function() {
  if (this.options.ajax) {
     this._remoteRender();
  } else if (this.options.data) {
    this._dataRender();
  }
  return this;
}

Tree.prototype.loadEvents = function() {
  var _tree = this;
  _tree.rootTarget.addEventListener('click', function(event) {
    event.preventDefault();
    _tree.rootList.classList.toggle('show');
    _tree.rootTarget.classList.toggle('show');
    _tree.isShow = _tree.rootList.classList.contains('show');
  });
}

Tree.prototype._getNode = function(filter_id) {
  var _tree = this;
  var _items = []
  this.data.forEach(function(item) {
    if (item.parent_id === filter_id) {
      _items.push({
        info: item,
        subItems: _tree._getNode(item.id),
      });
    }
  });
  return _items;
}

Tree.prototype._renderHTML = function() {
  var _tree = this;
  _tree.rootList = document.createElement('UL');
  _tree.nodes.forEach(function(item) {
    _tree._renderItem(_tree.rootList, item);
  });

  _tree.container.innerHTML = "";
  _tree.container.classList.add('root-tree');
  _tree.container.append(_tree.rootList);
  if (_tree.isShow) {
    _tree.rootList.classList.add('show');
    _tree.rootTarget.classList.add('show');
  }
  return _tree;
}

Tree.prototype._renderItem = function(context, item) {
  var _tree = this;
  var _itemElement = document.createElement('LI');
  var _itemName = _tree._renderItemName(item);
  if (item.subItems && item.subItems.length) {
    var _subList = document.createElement('UL');
    _itemElement.append(_tree._renderItemArrow(item));
    _itemElement.append(_itemName);
    _itemElement.append(_subList);
    item.subItems.forEach(function(subItem) {
      _tree._renderItem(_subList, subItem);
    });
  } else {
    _itemElement.append(_itemName);
  }
  context.append(_itemElement);
}

Tree.prototype._renderItemName = function(item) {
  var _link = document.createElement('A');
  _link.innerHTML = item.info.name;
  _link.setAttribute('href', item.info.link);
  _link.setAttribute('data-js', item.info.link);
  _link.setAttribute('class', 'name');
  return _link;
}

Tree.prototype._renderItemArrow = function(item) {
  var _tree = this;
  var _arrow = document.createElement('A');
  _arrow.setAttribute('href', '#');
  _arrow.setAttribute('class', 'arrow');
  _arrow.addEventListener('click', function(event) {
    if (_arrow.classList.contains('show')) {
      var index = _tree.showIds.indexOf(item.info.id);
      if (index !== -1) _tree.showIds.splice(index, 1);
      _arrow.classList.remove('show');
    } else {
      _arrow.classList.add('show');
      _tree.showIds.push(item.info.id);
    }
  });
  if (_tree.showIds.indexOf(item.info.id) >= 0) _arrow.classList.add('show');
  return _arrow;
}

Tree.prototype._remoteRender = function() {
  var _tree = this;
  if (_tree.options.ajax) {
    $.get(_tree.options.ajax, function(json) {
      _tree.data = json;
      _tree.nodes = _tree._getNode(null);
      _tree._renderHTML();
    })
  }
}

Tree.prototype._dataRender = function() {
  this.data = this.options.data;
  this.nodes = this._getNode(null);
  this._renderHTML();
}
