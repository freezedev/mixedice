(function() {
  var __slice = [].slice;

  (function(root) {
    var DEBUG, mixinList, ownProp;
    ownProp = Object.hasOwnProperty;
    mixinList = {};
    DEBUG = false;
    if (DEBUG) {
      root.mixinList = mixinList;
    }
    root.mixer = function() {
      var mixFunction, mixObject, n, name, params, target, _i, _len;
      target = arguments[0], name = arguments[1], params = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      mixObject = function(target, obj) {
        var key, value;
        for (key in obj) {
          value = obj[key];
          if (!ownProp.call(target, key)) {
            target[key] = value;
          }
        }
        return null;
      };
      mixFunction = function(target, func, params) {
        return func.apply(target, params);
      };
      if (Array.isArray(name)) {
        for (_i = 0, _len = name.length; _i < _len; _i++) {
          n = name[_i];
          root.mixer(target, n, params);
        }
      }
      if (typeof name === 'string' && ownProp.call(mixinList, name)) {
        if (typeof mixinList[name] === 'function') {
          mixFunction(target, mixinList[name], params);
        } else {
          mixObject(target, mixinList[name]);
        }
      } else {
        if (typeof name === 'function') {
          mixFunction(target, name, params);
        } else {
          mixObject(target, name);
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
