---
title:  'Notes on Kalman Filter'
author: "Chase Coleman"
tags: ["math", "hiddenmarkov", "filtering"]
series: ["Probability & Statistics"]
---

# Kalman Filter

The Kalman filter is a vital tool in any macro-economist's (and more generally any modelers) toolbox. A filtering problem is loosely described by the use of a history of observed information to infer information about the history of some other unobservable variable (state). The Kalman filter is a recursive filter in the sense that if we have a best guess for the state value for the previous period, $t-1$, then the period $t$ observation in conjunction with the best guess for the state value in the previous period is sufficient to provide a best guess for the state value in this period.

The model that we will present in conjunction with the Kalman filter is called a Gaussian linear state space model and is typically described by the following two equations:

$$y_t = C x_t + D \varepsilon_t$$
$$x_t = A x_{t-1} + B \eta_t$$

The matrices $(A, B, C, D)$ are all known and the model noise, $\varepsilon_t$ and $\eta_t$, are both identically and independently distributed as standard normals. The first equation is often referred to as the *measurement equation* because the history of $y^t$ is observable to the agent at period $t$.  The second equation is known as the state evolution equation, and is fundamentally different than the measurement equation because $s^t$ is unobservable. The fact that one equation is observable while the other is not and the Markov properties of the model put this model into a broader class of models known as *hidden Markov models*.

## Derivation

I will now present the derivation of the Kalman filter. As mentioned earlier, we would like to infer information about the states, $x_t$, using information that we observe $y_t$. More specifically, we would like to infer the value of $x_t$ given a history of $y^t$. We begin by having some initial condition on $x_0$ -- This condition can be either a distribution *or* simply a value. We will denote the estimated values of the state using a hat i.e. write $\hat{x}$

The recursive nature of the Kalman filter means that each period we enter the period with a best guess for the value of the state which we will call the predicted state, call it $\hat{x}_{t | t-1}$. This predicted state is found through

$$ E_t[x_t] = E_t \left[ E_{t-1} \left[x_t \right] \right]$$
$$ = E_t \left[ E_{t-1} \left[A x_{t-1} + B \varepsilon_t \right] \right]$$
$$ = E_t \left[ A \hat{x}_{t-1 | t-1} + B \varepsilon_t \right] = A \hat{x}_{t-1 | t-1}$$

where $\hat{x}_{t-1 | t-1}$ is defined as our best estimate of the state conditional on the information up to period $t-1$. Our goal is to establish an unbiased estimator, $\hat{x}_{t | t}$, for the state $x_t$ and to minimize the squared error at every period where we define the error as $e_t := (x_t - \hat{x}_{t|t})$. Others have found (and justified) a solution of the form

$$ \hat{x}_{t | t} = \hat{x}_{t | t-1} + K (y_t - C \hat{x}_{t | t-1})$$

We refer to $(y_t - C \hat{x}_{t | t-1})$ as the innovation or residual because it is the difference between what we would observe with no noise and what we actually observe. Taking the derivative of the square errors with respect to $K_t$ reveals the value of $K_t$ which minimizes the distance between $x$ and $\hat{x}_{t | t}$.

$$K_t = ... $$


# References

Fill these in more adequately later

* Quant-Econ
* D.B.O. Anderson and J.B Moore. Optimal Filtering. Dover Publications, 1979.
*
