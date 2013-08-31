ownProp = Object.hasOwnProperty

udefine 'mixer', ->
  mixinList = {}

  mixer = (target, name, params...) ->
    mixObject = (target, obj) ->
      for key, value of obj when not ownProp.call target, key
        target[key] = value
      null
      
    mixFunction = (target, func, params) -> func.apply target, params
    
    mixer(target, n, params) for n in name if Array.isArray name

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

    null

  mixer.define = (name, definition) ->
    return unless name? or definition?
    return if mixinList[name]?

    mixinList[name] = definition

    null
    
  mixer.remove = (name) ->
    delete mixinList[name] if name? and mixinList[name]?

    null

  mixer.exists = (name) -> ownProp.call mixinList, name
  
  mixer