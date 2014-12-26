Adds helper methods to the native javascript Number class


Number#**in_Between** (min, max)

Returns true if @ is between min and max for example

```coffee
(10).in_Between(5,15)  # returns true
(10).in_Between(10,15) # returns false
(10).in_Between(50,50) # returns false
```

    Number::in_Between = (min,max )->
        (min < @ < max)


Number#**invoke_After** (callback)

Invokes the **callback** function after @ miliseconds

    Number::invoke_After = (callback)->
        if callback instanceof Function
            setTimeout callback, @


Number#**log** ()

Logs @ to the console

    Number::log =
      -> console.log @.toString()


Number#**random_String** ()

Returns a random string of size @ made of ascii chars

    Number::random_String = ->
        "".add_Random_String(@ + 0)


Number#**random_Letters** ()

Returns a random string of size @ made of only letters

    Number::random_Letters = ->

        "".add_Random_Letters(@ + 0)


Number#**str** ()

Short version of ```toString```

    Number::str =
      -> @.toString()


---
back to [index](index.html)