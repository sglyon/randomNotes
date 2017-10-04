# Golang

## Tips and tricks

### "Interface" assert

Sometimes I see things lke this

```go
var _ InterfaceType = MyType
```

The underscore means completely discard the value associated with that var declaration. What this does is provide a compile type check that `MyType` implements all the methods for `InterfaceType`. People use this when developing new types to make sure that the new types implment the desired interfaces.

More info here: https://stackoverflow.com/a/13194635/1742701

### Type assert

This is another pattern I see often

```go
if v, ok := x.(Type); ok {
    // stuff
}
```

What this does is check if `x` is of concrete type `Type`. If it is, then run the code in the block. If it isn't, then move on. 
