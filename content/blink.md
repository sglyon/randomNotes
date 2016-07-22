# Evaluation path

Suppose we have done the following:

```julia
using Blink
w = Window()
```

Now suppose that we want to do this:

```julia
js(w, JSString("Math.abs(-10)"))
```

How does this get sent to javascript, executed, and returned to Julia? The flow looks something like this:

- `js(w::Window,...)` (defined in window.jl) will check if `w.content` is `active`. If so, it will call `js(w.content,...)`. Otherwise nothing really happens (TODO, what's this `dot` business doing)
- Unless you really know what you are doing (in which case you probably don't need to be reading this) `content` will be a `Page`.
- `js(::Page,...)` (defined without `::Page` is in rpc.jl) will construct `cmd`, a dict containing `:type => :eval` `:code => "Math.abs(-10)"` and will then deal with callbacks...
    - Callback handing is a little tricky, but here's an overview.
    - If the javascript call is supposed to return something, the `callback` keyword argument to the `js` function will be `true` (the default -- note the underscore version `js_` hands off to `js` with `;callback=false`).
        - In this case we use Julia's task scheduling mechanisms to create a `Condition` and call `notify` and `wait` in the right way so that we are able to wait for the execution to finish and a result to be ready. Once it is ready, we send the return value back over the wire (via json payload... see below) and it is unwrapped into a Julia value.
    - If we don't need a return value, we will set `callback` to `false` and just return the `Page` object after sending the code to be evaluated.
- Once callback handling is in place, we convert `cmd` to JSON and send it over TCP to the socket open for the window. This happens in `msg` defined in `content.jl`
- The message is then received on the javascript side by the code near the top of `blink.js`...
    - `sock.onmessage` will listen on that socket for any messages being passed.
    - That function extracts the `type` field of the `msg` (remmeber we set `:type => "eval"` in `cmd` above?) and hands off to a function contained in the `handlers` object.
    - In our case we go to `handlers.eval`, where `cmd.code` is executed and the other end of the callback is handled.
    - If we did set `callback=true`, we end up returning a json object containing the result of the javascript call.
    - Otherwise we get null
- The final part of the sequence is when the JSON payload containing the return is then sent back to Julia where `JSON.parse` is used to convert back to a Julia datatype if possible (happens in `ws_handler` in server.jl).

phew, we made it. We skipped some details behind how the Julia task system is used to wait for callbacks, but for _users_ of this package that should be ok.
