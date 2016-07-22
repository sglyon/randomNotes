---
title: "Continuous Time"
date: "2015-01-12"
author: "Spencer Lyon"
series: ["Economics"]
tags: ["math", "continuous time"]
---

# Continuous Time Macro

## Solving an HJB

The HJB usually takes the form

$$\rho V_t (N_t) = \max_{C, a} \left\{ u(C) + \mathcal{A} V_t(N_t)\right\},$$

where $\mathcal{A} V_t(N_t)$ is the drift of $dV_T(N_t)$, $\rho$ is the discount rate, $u(C)$ is the flow payoff of $C$. To solve this equation follow these steps:

1. Take FOC wrt controls (here $C, a$)
2. Stare at it for a while and make a guess of the functional form of the solution to the PDE. In this case if $u(C) = \ln(C)$ we would have chosen $V(N) = v_0 + v_1 \ln(N)$. You really learn how to do this by practice.
3. Plug the assumed functional form into the HJB (take necessary derivatives and replace all instances of $V(N)$)
4. Plug in FOC from step 1
5. Use method of undetermined coefficients to extract coefficients in assumed functional form. If you are unable to do this, try one more time because you might have made a dumb algebra mistake. After that start over at step 2 with a new guess

*Note:* If you aren't able to provide an explicit functional form, but rather have a more general guess like $V(x, y) = f(x) + y g(x)$, then you should alter your approach slightly. Starting from step 5 you will need to do the following:

5. You should be able to use the method of undetermined coefficients to come up with ODEs for each of the generic functions in your guess (in this case $f$, and $g$).
6. Solve these ODEs however you know how
7. If you can't, you probably made a bad guess for the form of the solution, so start over at step 2.

## Ito processes

### GBM

A geometric Brownian motion solves the following SDE

$$dS_t = \mu S_t dt + \sigma S_t dW_t.$$

The solution is

$$S_t = S_0 \exp \left( \left(\mu - \frac{\sigma^2}{2} \right)t + \sigma W_t \right).$$

We often write GMB as

$$\frac{dS_t}{S_t} = \mu dt + \sigma dW_t$$

or even in terms of $d \log S_t$. By Ito's lemma we have that

$$d \log S_t = \frac{d S_t}{S_t} - \frac{1}{2} \sigma^2 dt.$$

Solving for $\frac{d S_t}{S_t}$ and matching coefficients we see that we must have

* drift of $d \log S_t = \mu - \frac{1}{2} \sigma^2$
* Volatility of $d \log S_t = \sigma$.
