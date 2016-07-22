---
title: "Haskell Basics"
date: "2015-01-29"
author: "Spencer Lyon"
draft: true
series: ["Hacking"]
---

# Haskell

## Important typeclasses in Haskell


The following were taken directly from the haskell source

```haskell
class  Functor f  where
    fmap        :: (a -> b) -> f a -> f b

    -- | Replace all locations in the input with the same value.
    -- The default definition is @'fmap' . 'const'@, but this may be
    -- overridden with a more efficient version.
    (<$)        :: a -> f b -> f a
    (<$)        =  fmap . const


class Functor f => Applicative f where
    -- | Lift a value.
    pure :: a -> f a

    -- | Sequential application.
    (<*>) :: f (a -> b) -> f a -> f b

    -- | Sequence actions, discarding the value of the first argument.
    (*>) :: f a -> f b -> f b
    (*>) = liftA2 (const id)

    -- | Sequence actions, discarding the value of the second argument.
    (<*) :: f a -> f b -> f a
    (<*) = liftA2 const

class Functor f => Applicative f where
    -- | Lift a value.
    pure :: a -> f a

    -- | Sequential application.
    (<*>) :: f (a -> b) -> f a -> f b

    -- | Sequence actions, discarding the value of the first argument.
    (*>) :: f a -> f b -> f b
    (*>) = liftA2 (const id)

    -- | Sequence actions, discarding the value of the second argument.
    (<*) :: f a -> f b -> f a
    (<*) = liftA2 const

class Monoid a where
        mempty  :: a
        -- ^ Identity of 'mappend'
        mappend :: a -> a -> a
        -- ^ An associative operation
        mconcat :: [a] -> a

        -- ^ Fold a list using the monoid.
        -- For most types, the default definition for 'mconcat' will be
        -- used, but the function is included in the class definition so
        -- that an optimized version can be provided for specific types.

        mconcat = foldr mappend mempty

class  Monad m  where
    -- | Inject a value into the monadic type.
    return      :: a -> m a

    -- | Sequentially compose two actions, passing any value produced
    -- by the first as an argument to the second.
    (>>=)       :: forall a b. m a -> (a -> m b) -> m b
    -- | Sequentially compose two actions, discarding any value produced
    -- by the first, like sequencing operators (such as the semicolon)
    -- in imperative languages.
    (>>)        :: forall a b. m a -> m b -> m b
        -- Explicit for-alls so that we know what order to
        -- give type arguments when desugaring

    -- | Fail with a message.  This operation is not part of the
    -- mathematical definition of a monad, but is invoked on pattern-match
    -- failure in a @do@ expression.
    fail        :: String -> m a

    {-# INLINE (>>) #-}
    m >> k      = m >>= \_ -> k
    fail s      = error s
```


In LYAH we saw the type of `(>>=)` written as `(>>=) :: m a -> (a -> m b) -> m b` and the type of `(>>)` written as `(>>) :: m a -> m b -> m b`. The forall must just mean that it works for any `a`  and `b`. I thought that was implicit when we didn't put type constraints on them, but maybe not.


### Failing monads

We can pattern match inside do expressions

```haskell
justH :: Maybe Char
justH = do
    (x:xs) <- Just "hello"
    return x
```


If we didn't match any patterns, the Monad's fail function would be
called.

The default implementation is to throw an error, as we can see from
above: `fail s = error s`.

However, because `Maybe`'s are often used to deal with computations
that might fail, the implementation of `fail` for the `Maybe` instance
is `fail _ = Nothing`. Then stuff like this will simply give us a
`Nothing` instead of crashing

```haskell
wopwop :: Maybe Char
wopwop = do
    (x:xs) <- Just ""
    return x
```
