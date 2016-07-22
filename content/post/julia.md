---
title:  'Julia'
author: 'Spencer Lyon'
date: "2013-02-12"
tags: ["julia", "tips"]
series: ["Hacking"]
---


## Tips and tricks

- Sometimes you want to have a reference to a variable defined within a scoped block when that block finished. To do that declare `local varname` as in this example from the Gadfly source:
```julia
local xs, ys
try
    (xs, ys) = map(toVecOrDist, (aes.x, aes.y))
catch e
    error("Stat.qq requires that x and y be bound to either a Distribution or to arrays of plain numbers.")
end
```

## Calling C code

### Compiling C extensions in OSX

Consider the following C file (call it `pisum.c`):

```C
#include<math.h>

double pisum(long n)
{
    int i;
    double j;
    j=0;
    for (i = 1; i < n; i++)
    {
        j += pow(-1, i + 1) / (2.0*i-1);
    }
    j=4*j;
    return j;
}
```

I would compile this for use in Julia using

```bash
$ gcc -shared -fPIC pisum.c -o pisum
```

Then In julia I can wrap it like this:

```julia
c_pisum(x=80000000) = ccall((:pisum, "pisum"), Float64, (Clong), convert(Clong, x))
```

### Compiling in ubuntu

I need to do these things in ubuntu for same example

```shell
$ gcc -c -Wall -Werror -fpic my_c_file.c
$ gcc -shared -o lib_my_c_lib.so my_c_file.o
```

Then in julia I call it like this

```julia
c_pisum3() = ccall((:foo, "lib_my_c_lib.so"), ...
```

## Why do I like Julia for Economics?

* Fast
    - Economists write down problems with many state variables
    - Solve functional equations on that state space
    - explicit looping iteration over matrices that represent those functions on
* Functional
    - Proper support for concepts for basic functional programming makes code readable and concise
        + `do` notation
        + `map`, `fold`, `reduce`, `pmap`, comprehensions
    - "Leightweight" data types allow us to have very small types (types can be thought of a dict that can additional specify how functions operate on it, even relative to other arguments the function is called with)
    - Multiple dispatch allows us to combine previous two points in unique and powerful ways (type-based API -- not kwarg)
* Flexible
    - Most of Julia's standard library is written in Julia -- and is very fast
    - This means other code written in Julia has potential to perform at the same level as standard library code (if written well)
    - Not true of other popular languages for economists (e.g., R, MATLAB, Python -- they all require you to write some variant of C code that you wrap or hook into)
* Call C code
    - Many great numerical libraries are written in C/Fortran
    - Ability to have zero overhead, zero-wrapper (call directly into shared-object file) access to these libraries gives added flexibility and power
        + Dierckx
    - Projects like PyCall, JavaCall, RCall let you use the tools you  have become dependent on as you make a gradual transition to working within python. Dependent on API
* Parallel
    - Parallel programming building blocks built into the language.
    - Makes writing parallel code much easier.
    - Important for economists that loop over arrays as long as on each iteration one element does not depend on updated values of other elements from that same iteration (common).




Other notes:
- Many users of other languages. Would need to convince them that the benefit of learning julia outweighs the cost of learning a new language and perhaps abandoning a subset of collected tools.
    + Users of Matlab or Python specifically will be able to pick up Julia in almost a copy/paste fashion and just change some syntax. This is not "optimal Julia", but it will function.


Deficiencies:


Jonathan:

- code from scratch, Julia is easier to write performant code
- When you don't write everything from scratch (e.g. numerical optimization) it is often harder to find mature (in terms of users/tests) packages than in other languages. Young (but growing) package ecosystem relative to Python, Matlab, R (partially mitigated by ability to call these languages)
- Weak conventions for documentation. Changing soon with new documentation system.
- Less materials online for learning the language.
- Many OOP people will feel like Julia's types are lacking. They play similar roles, but do so in a different way. Types are more functional. More OOP programmers in this audience (python, Matlab) than functional programmers
- Need materials that show how to leverage Julia's type-system. Easy to get off the ground programming, hard to master (skiing vs snowboarding).
- How to use functional programming in a way that is natural and readable. How to keep track of how computation happens. Easier to trace through procedural style
- CONVENTIONS
- Hard to determine which function is going to be called. Need to use @edit, @which, @less
- How to get involved with the community? issues list, mailing list
