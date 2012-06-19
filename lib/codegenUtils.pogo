_ = require 'underscore'

exports.write to buffer with delimiter (array, delimiter, buffer, scope) =
  writer = nil
  if (scope :: Function)
      writer = scope
  else
      writer (item) =
          item.generate java script (buffer, scope)
  
  first = true

  _ (array).each @(item)
      if (!first)
          buffer.write (delimiter)

      first = false
      writer (item)

actual characters = [
    [r/\\/g, '\\']
    [new (RegExp "\b", 'g'), '\b']
    [r/\f/g, '\f']
    [r/\n/g, '\n']
    [r/\0/g, '\0']
    [r/\r/g, '\r']
    [r/\t/g, '\t']
    [r/\v/g, '\v']
    [r/'/g, '\''']
    [r/"/g, '\"']
]

exports.format java script string (s) =
    for each @(mapping) in (actual characters)
        s = s.replace (mapping.0, mapping.1)

    "'" + s + "'"

exports.concat name (name segments, options) =
    name = ''
  
    for (n = 0, n < name segments.length, n = n + 1)
        segment = name segments.(n)
        name = name + name segment rendered in java script (segment, n == 0)

    if ((options && options.has own property ('escape')) && options.escape)
        escape reserved word (name)
    else
        name

name segment rendered in java script (name segment, is first) =
    if (r/[_$a-zA-Z0-9]+/.test (name segment))
        if (is first)
            name segment
        else
            capitalise (name segment)
    else
        operator rendered in java script (name segment)

operator rendered in java script (operator) =
    java script name = ''
    for (n = 0, n < operator.length, n = n + 1)
        java script name = java script name + '$' + operator.char code at (n).to string (16)

    java script name

capitalise (s) =
    s.0.to upper case () + s.substring (1)

reserved words = {
  class
  function
}

escape reserved word (word) =
    if (reserved words.has own property (word))
        '$' + word
    else
        word

exports.args and optional args (cg, args, optional args) =
  a = args.slice ()

  if (optional args && (optional args.length > 0))
    a.push (cg.hash (optional args))

  a