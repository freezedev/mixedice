(function() {
  var __slice = [].slice;

  (function(root) {
    var mixerList, ownProp;
    mixerList = {};
    ownProp = Object.hasOwnProperty;
    if (DEBUG) {
      root.mixerList = mixerList;
    }
    root.mixer = function() {
      var key, n, name, params, target, value, _i, _len, _ref;
      target = arguments[0], name = arguments[1], params = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      if (Array.isArray(name)) {
        for (_i = 0, _len = name.length; _i < _len; _i++) {
          n = name[_i];
          root.mixer(target, n, params);
        }
      }
      if (typeof mixinList[name] === 'function') {
        mixinList[name].apply(target, params);
      } else {
        _ref = mixinList[name];
        for (key in _ref) {
          value = _ref[key];
          if (!ownProp.call(target, key)) {
            target[key] = value;
          }
        }
      }
      return null;
    };
    root.mixer.define = function(name, definition) {
      if (!((name != null) || (definition != null))) {
        return;
      }
      if (mixinList[name] != null) {
        return;
      }
      mixinList[name] = definition;
      return null;
    };
    root.mixer.remove = function(name) {
      if ((name != null) && (mixinList[name] != null)) {
        delete mixinList[name];
      }
      return null;
    };
    root.mixer.exists = function(name) {
      return ownProp.call(mixinList, name);
    };
    return typeof root.define === "function" ? root.define('mixer', function() {
      return root.mixer;
    }) : void 0;
  })(this);

}).call(this);
