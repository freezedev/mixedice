ownProp = Object.hasOwnProperty

udefine 'mixedice', ->
  mixinList = {}

  mixedice = (target, name, params...) ->
    return unless target?
    
    # When objects are mixed in together
    mixObject = (target, obj) ->
      splitObject = (obj) ->
        keys = Object.keys(obj)
        
        directObj = do ->
          result = {}
          
          for key in keys
            result[key] = obj[key]
          
          result
        
        protoObj = Object.getPrototypeOf(obj)
        
        [directObj, protoObj]
      
      if Array.isArray target
        splitted = splitObject obj
        
        mixObject target[0], splitted[0]
        mixObject target[1], splitted[1]
      else
        for key, value of obj when not ownProp.call target, key
          target[key] = value
      
      null
    
    # Mix function into the object
    mixFunction = (target, func, params) -> func.apply target, params
    
    # Allows to mix a lot of objects, functions and all kinds of crazy stuff
    mixedice(target, n, params) for n in name if Array.isArray name

    # Check what's what and execute functions accordingly
    if typeof name is 'string' and ownProp.call mixinList, name
      if typeof mixinList[name] is 'function'
        mixFunction target, mixinList[name], params
      else
        mixObject target, mixinList[name]
    else
      if typeof name is 'function'
        mixFunction target, name, params
      else
        mixObject target, name

    target

  # Define a mixin to be used a lot of times
  mixedice.define = (name, definition) ->
    return unless name? or definition?
    return if mixinList[name]?

    mixinList[name] = definition

    null
  
  # Remove a mixin
  mixedice.remove = (name) ->
    delete mixinList[name] if name? and mixinList[name]?

    null

  # Check if a mixin exists
  mixedice.exists = (name) -> ownProp.call mixinList, name
  
  mixedice
  
# Our current CommonJS workaround
if udefine.env.commonjs
  udefine.require 'mixedice', (mixedice) -> module.exports = mixedice