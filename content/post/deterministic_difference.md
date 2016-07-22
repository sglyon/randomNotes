---
title:  'Notes on Deterministic Difference Equations'
author: 'Chase Coleman'
date: "2015-09-05"
tags: ["math"]
---

# Deterministic Difference Equations

## Scalar First-Order Linear Equations

The basic scalar first-order difference equation can be represented by:

`$$x_{t+1} = b x_t + c z_t, \quad t \geq 0$$`

where $x_t, b, c, z_t$ are all real numbers. Since these equations are deterministic then we already know the sequence $\{ z_t \}$ and will assume it is bounded. If $z_t$ is constant for all $t$ then this equation is called *autonomous*. If $c z_t = 0$ for all $t$ then this equation is called homogenous. A particular solution to this difference equation is the constant solution where $x_t = \bar{x}$ for all $t$ and $\bar{x} = \frac{c}{1-b}$ for $b \neq 1$. This solution is known as a *stationary point* or *steady state.* A more general solution to the autonomous difference equation can be given by

`$$x_t = (x_0 - \bar{x}) b^t + \bar{x}$$`

We can describe the behavior of this solution by


</span>    | $x_0$ given                      | $x_0$ unknown
-----------|----------------------------------|-----------------------------------
$abs(b) > 1$  | Exploding unless $x_0 = \bar{x}$ | $x_t = \bar{x}$ $\forall t \geq 0$
$abs(b) < 1$  | Globally asympototically stable  | Indeterminancy

A general solution for the nonautonomous case depends on whether $x_0$ is given or not. If $x_0$ is given then we can solve for $x_t$ through backwards substitution to obtain

`$$x_t = c \sum_{j=0}^{t-1} b^j z_{t - 1 - j} + b^t x_0$$`

If $|b| < 1$ then in the limit it converges to the *generalized steady state* which is

`$$\lim_{t \rightarrow \infty} x_t = \lim_{t \rightarrow infty} c \sum_{j=0}^{t-1} b^j z_{t-1-j}$$`

Now consider the case when $x_0$ is not given, for example, imagine that the process $x_t$ representes an asset's price. In our example the difference equation is simply an asset pricing equation and to solve for the price at $t$ we can substitute forward and get

`$$x_t = \left( \frac{1}{b} \right)^T x_{t+T} - \frac{c}{b} \sum_{j=0}^{T-1} \left(\frac{1}{b} \right)^j z_{t+j}$$`

for any $T \geq 1$. If we take $T \rightarrow \infty$ and assume the *transversality condition* (also known as the *no-bubble condition*) which says

`$$\lim_{T \rightarrow \infty} \left( \frac{1}{b} \right)^T x_{t+T} = 0$$`

then we can obtain the forward looking solution

`$$x_t = - \frac{c}{b} \sum_{j=0}^{\infty} \left( \frac{1}{b} \right)^j z_{t+j}$$`

If $|b| > 1$ then this sum converges.

Now imagine that $|b| > 1$ and we remove the transversality condition then the solution admits many unstable solutions. Define `$x_t^*$` as the solution given by the sum above, then for any `$\{B_t\}$` satisfying `$B_{t+1} = b B_t$` the expression `$x_t = x_t^* + B_t$` is a solution. In this case, we refer to `$x_t^*$` as the *fundamental value* and $B_t$ as a *bubble*.

If $|b| < 1$ then this sum likely doesn't converge. In similar fashion as previously, we could write the solutions as $x_t = \frac{c}{1 - b} + B_t$ and for any $B_t$ that follows the same process (`$B_{t+1} = b B_t$`).

We have seen that two conditions determine what the solutions to our first-order scalar difference equations look like, namely:

1) Whether the initial value is given : This determines whether $x_t$ is *predetermined*.
2) Whether $b$ is greater or less than 1 : This is determines whether the eigenvalue is stable.

## Lag Operators and Scalar Second-Order Linear Difference Equations

We now introduce an operator that is common in the economics literature and is known as the *lag operator*. The lag operator, $L$, operates on a dynamics process $\{x_t \}$ in the following fashion:

* `$L x_t = x_{t-1}$`
* `$L^n x_t = x_{t-n}$`
* `$L^n c = c$` for any constant `$c$`

Additionally, there are some useful formulas that we include for $ |\lambda| < 1$

`$$\frac{1}{1 - \lambda L^n} = \sum_{j=0}^\infty \lambda^j L^{nj}$$`
`$$\frac{1}{(1 - \lambda L^n)^2} = \sum_{j=0}^\infty (j + 1) \lambda^j L^{nj}$$`

and for a matrix $A$ with all of its eigenvalues in the unit circle

`$$(I - A L^n)^{-1} = \sum_{j=0}^\infty A^j L^{nj}$$`

Consider a second-order linear difference equation

`$$x_{t+2} = a x_{t+1} + b x_{t} + c z_{t}$$`

where `$x_0 \in \mathbb{R}$` is given, $a, b, c$ are real-valued constants, and `$\{ z_t \}$` is a given sequence of bounded real-valued numbers. We could express this equation in terms of the lag-operator by

`$$(L^{-2} - a L^{-1} - b) x_t = c z_t$$`

with characteristic equation

`$$\lambda^2 - a \lambda - b = 0$$`

This characteristic equation has two roots `$\lambda_1$` and `$\lambda_2$`. We could factor the difference equation into

`$$(L^{-1} - \lambda_1) (L^{-1} - \lambda_2) x_t = c z_t$$`

Then without loss of generality consider 3 possible cases: Either `$\lambda_1, \lambda_2 \in \mathbb{R}$` with `$\lambda_1 \neq \lambda_2$`, `$\lambda_1, \lambda_2 \in \mathbb{R}$` with `$\lambda_1 = \lambda_2$`, or `$\lambda_1, \lambda_2 \in \mathbb{C}$`. I will only think about the first case here: We can break this case into several sub-cases.

* `$ | \lambda_1 | > | \lambda_2 | > 1$` : Then the solution explodes as time proceeds -- We call the steady state the *source* (it is constant there and to either side it blows up).
* `$ | \lambda_1 | < | \lambda_2 | < 1$` : Then for any initial value, the solution converges to the steady state -- We call the steady state the *sink* (everything sinks towards this point).
* `$| \lambda_1 | < 1 < | \lambda_2 |$` The solution for this case is known as the *saddle path solution*. Then by sending `$(L^{-1} - \lambda_2)$` to the RHS we can write `$$(L^{-1} - \lambda_1) x_t = - \frac{c}{\lambda_2} \frac{z_t}{(1 - \lambda_2^{-1} L^{-1})}$$` which reduces to `$$x_{t+1} = \lambda_1 x_t -\frac{c}{\lambda_2} \sum_{j=0}^\infty \left( \frac{1}{\lambda_2} \right)^{j} z_{t + j}$$.`

## First-Order Linear Systems

We now consider first-order linear systems. We can write many higher order lineary systems down as a first-order linear system, so this will be the form that we consider

`$$A x_{t+1} = B x_{t} + C z_t$$`

Additionally, we will assume what is known as regularity -- That $\text{det}(A \alpha - B) \neq 0$ identically in $\alpha$. What this does is restrict ourselves to processes with solutions for generic exogenous sequences (Imagine that in the scalar case $a = b = 0$ then we wouldn't have a solution for generic processes for $c z_t$ because we would have the equation $0 = c z_t$). Additionally, depending on what we are working with we sometimes assume that there exists $T > 0$ such that $z_t = \bar{z}$ for all $t > T$ -- This assumption makes it possible for our system to have a steady state.

We define a steady state by a point $\bar{x}$ such that if $x_t = \bar{x}$ then $x_s = \bar{x}$ for all $s > t$. If $(A - B)$ is invertible (and we include our assumption on the constant values of $\bar{z}$) then our unique steady state is defined by $\bar{x} = (A - B)^{-1} C \bar{z}$.

A sequence `$\{ x_t \}$` is *stable* if there exists $M > 0$ such that `$|| x_t ||_{\text{max}} < M$` for all $t$; where the operation `$||x_{t}||_{\text{max}} = \max_j | X_j |$` for any $x \in \mathbb{R}^n$.

A point $\bar{x}$ is *asymptotically stable* for the sequence `$\{ x_t \}$` if `$\lim_{t \rightarrow \infty} x_t = \bar{x}$` for some `$x_0$`. The *basin* (or *attraction*) of an asymptotically stable steady state $\bar{x}$ is the set of all points `$x_0$` such that `$\lim_{t \rightarrow \infty} = \bar{x}$`.

A point $\bar{x}$ is *globally (asymptotically) stable* for the sequence `$\{ x_t \}$ if $\lim_{t \rightarrow \infty} x_t = \bar{x}$` for any value `$x_0$`.

We will assume that `$\{ z_t \}$` is a stable sequence.

### Nonsingular systems

Let $A$ be nonsingular then we can write our first-order linear system as

`$$x_{t+1} = A^{-1} B x_t + A^{-1} C z_t$$`

## References

* Jianjun Miao. "Economic dynamics in discrete time." MIT Press. 2014.
* Lars Ljunqvist and Thomas Sargent. "Recursive Macroeconomic Theory." MIT Press. 2013
