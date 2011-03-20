@ref = (value) ->
  refs = []

  ref = (value) ->
    # null/undefined
    return value unless value

    # not object/array
    return value unless typeof value == 'object'

    for r, i in refs
      # already encountered
      if r == value then return $ref: "#{i + 1}"

    result = $id: "#{refs.push value}"

    if '[object Array]' == Object.prototype.toString.call value
      result.$values = (ref v for v in value)
    else
      for k, v of value
        result[k] = ref v

    result

  ref value

@deref = (value) ->
  refs = {}

  deref = (value) ->
    # null/undefined
    return value unless value

    # not object/array
    return value unless typeof value == 'object'

    if '$ref' of value
      # reference
      return refs[value.$ref]

    if '$id' of value
      # object/array
      if '$values' of value
        # array
        result = refs[value.$id] = []

        for v in value.$values
          result.push deref v

        return result

      # object
      result = refs[value.$id] = {}

      for k, v of value when k != '$id'
        result[k] = deref v

      return result

    # none of the above
    value

  deref value
