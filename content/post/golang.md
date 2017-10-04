# Golang

## Tips and tricks

Sometimes I see things lke this

```go
var _ InterfaceType = MyType
```

The underscore means completely discard the value associated with that var declaration. What this does is provide a compile type check that `MyType` implements all the methods for `InterfaceType`. People use this when developing new types to make sure that the new types implment the desired interfaces.

More info here: https://stackoverflow.com/a/13194635/1742701
