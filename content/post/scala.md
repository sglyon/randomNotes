---
title: "Scala Notes"
date: "2015-01-29"
author: "Spencer Lyon"
series: ["Hacking"]
---


# Scala

## Notes from "Functional Programming in Scala"

The `Option` class in
[Option.scala](https://github.com/spencerlyon2/fpinscala/blob/master/exercises/src/main/scala/fpinscala/errorhandling/Option.scala)
and the `RNG` class in
[State.scala](https://github.com/spencerlyon2/fpinscala/blob/master/exercises/src/main/scala/fpinscala/state/State.scala)
have examples of using `flatMap` to implement `map2`. The pattern is common, but
a bit weird. Stare at it for a while if you want to figure out how powerful
`flatMap` is.
