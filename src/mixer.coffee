do (root = @) ->
  
  ownProp = Object.hasOwnProperty

  mixinList = {}
  
  # Expose mixer list if debug
  root.mixinList = mixinList if DEBUG

  root.mixer = (target, name, params...) ->
    mixObject = (target, obj) ->
      for key, value of obj when not ownProp.call target, key
        target[key] = value
      null
      
    mixFunction = (target, func, params) -> func.apply target, params
    
    root.mixer(target, n, params) for n in name if Array.isArray name

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

  root.mixer.define = (name, definition) ->
    return unless name? or definition?
    return if mixinList[name]?

    mixinList[name] = definition

    null
    
  root.mixer.remove = (name) ->
    delete mixinList[name] if name? and mixinList[name]?

    null

  root.mixer.exists = (name) -> ownProp.call mixinList, name
  
  # Provide AMD module as well, global property still needs to be available
  # though
  root.define? 'mixer', -> root.mixer
