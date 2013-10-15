(function() {
  (function(name) {
    return udefine.configure(function(root) {
      return udefine.inject.add(name);
    });
  })('mixer');

}).call(this);

(function() {
  var ownProp,
    __slice = [].slice;

  ownProp = Object.hasOwnProperty;

  udefine('mixer', function() {
    var mixer, mixinList;
    mixinList = {};
    mixer = function() {
      var mixFunction, mixObject, n, name, params, target, _i, _len;
      target = arguments[0], name = arguments[1], params = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      if (target == null) {
        return;
      }
      mixObject = function(target, obj) {
        var key, splitObject, splitted, value;
        splitObject = function(obj) {
          var directObj, keys, protoObj;
          keys = Object.keys(obj);
          directObj = (function() {
            var key, result, _i, _len;
            result = {};
            for (_i = 0, _len = keys.length; _i < _len; _i++) {
              key = keys[_i];
              result[key] = obj[key];
            }
            return result;
          })();
          protoObj = Object.getPrototypeOf(obj);
          return [directObj, protoObj];
        };
        if (Array.isArray(target)) {
          splitted = splitObject(obj);
          mixObject(target[0], splitted[0]);
          mixObject(target[1], splitted[1]);
        } else {
          for (key in obj) {
            value = obj[key];
            if (!ownProp.call(target, key)) {
              target[key] = value;
            }
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
          mixer(target, n, params);
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
    mixer.define = function(name, definition) {
      if (!((name != null) || (definition != null))) {
        return;
      }
      if (mixinList[name] != null) {
        return;
      }
      mixinList[name] = definition;
      return null;
    };
    mixer.remove = function(name) {
      if ((name != null) && (mixinList[name] != null)) {
        delete mixinList[name];
      }
      return null;
    };
    mixer.exists = function(name) {
      return ownProp.call(mixinList, name);
    };
    return mixer;
  });

}).call(this);
