---
title:  'Notes on MCMC Methods'
author: "Chase Coleman"
tags: ["math", "montecarlo", "markov"]
series: ["Probability & Statistics"]
---

# Basic Idea

The key idea behind the MCMC algorithms is that under certain conditions, Markov chains have a stationary distribution. If we can build a Markov chain whose stationary distribution is the distribution that we would like to sample from then it is relatively easy to get draws from this distribution by simulating lots of points and then randomly drawing from them.

# Metropolis-Hastings

Both the Metropolis and Gibbs algorithms are special cases of the Metropolis-Hastings algorithm. It has ...

# Metropolis

As previously mentioned, the Metropolis algorithm is a special case of Metropolis-Hastings -- In particular, it is the case in which we have a symmetric proposal density (People often use random walks)

# Gibbs

Gibbs sampling uses closed form expressions for conditionals such that we accept each draw.

# Coupling From the Past

Imagine we have a Markovian process $\{ X_t \}$ whose stationary distribution we would like to draw from. One natural way to draw from this process is to start at some $x_0$ and simulate the process forward until it "converges" in some sense to the stationary distribution -- Remember under certain conditions (such as irreducibility etc...) Markov processes are guaranteed to converge to their stationary distribution as $t \rightarrow \infty$. While intuitive, this approach has several short comings:

    1. You are never drawing from the *exact* stationary distribution
    2. It is hard to determine rates of convergence, so the number of periods you choose for "convergence" is somewhat arbitrary and is done using guess work.

In order to deal with this, we can take advantage of a very simple idea. Let's start a process at period $-\infty$ and simulate it forward until period 0. At period 0, it should have converged to the stationary distribution. In continuous state spaces it is more difficult, so I will explain it for discrete spaces. Imagine we have $N$ states in our Markov chain then at period $-T$, it has to have arrived at one of the $N$ states. Start $N$ processes (one at each state) at period $-T$ and simulate them forward until period 0 (with the same set of shocks!). If all of these processes have converged to a single state then we know that our original process would have also converged to that state and thus the process is now in its stationary distribution (because we have "simulated" the process for an infinite number of periods). If it hasn't converged then try again with a larger $T$ -- These processes are guaranteed to "coalesce" in finite number of states.

# References

John Stachurski's coupling from the past papers
