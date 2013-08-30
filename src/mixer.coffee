do (root = @) ->
  mixerList = {}
  
  ownProp = Object.hasOwnProperty
  
  # Expose mixer list if debug
  root.mixerList = mixerList if DEBUG

  root.mixer = (target, name, params...) ->
    root.mixer(target, n, params) for n in name if Array.isArray name

    if typeof mixinList[name] is 'function'
      mixinList[name].apply(target, params)
    else
      for key, value of mixinList[name] when not ownProp.call target, key
        target[key] = value

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
