do (root = @, name = 'mixer') ->
  root.udefine.globals[name] = root[name]

  root.udefine.inject[name] = {name, root}