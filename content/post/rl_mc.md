---
title: "Monte Carlo methods"
date: "2016-06-29"
author: "Spencer Lyon"
series: ["Reinforcement Learning"]
series_weight: 2
tags: ["MC", "RL", "algorithms"]
tags_weight: 2
---

This is part 2 in the reinforcement learning for economists notes. For part 1 see [Reinforcement Learning Intro]({{< relref "post/reinforcement_learning.md" >}}). For a list of all entries in the series go [here](/series/reinforcement-learning)

## Monte Carlo methods

As defined in [Reinforcement Learning Intro]({{< relref "post/reinforcement_learning.md" >}}) *GPI* encompasses the core ideas for all the RL algorithms in this book. One family of such algorithms is Monte Carlo (MC) methods. One distinguishing feature of these methods is that they can be implemented in a completely **model-free** way. This means that to apply them we need to know nothing about the dynamics of the model; we simply need to be able to observe sequences of states, actions, and rewards.

### Prediciton methods

**Monte Carlo prediciton** is a method for learning the state-value function for a given policy. The algorithm is given by:

![MC prediciton](/first_visit_mc_prediction.png)

Notice that the MC prediction algorithm does not update any estimates of the value function until _after_ the entire episode is realized. In this sense we would say that the method does not **bootstrap**, meaning it does not use approximations of the value in other states to update the value in a particular state (value iteration is bootstrapping).

### Control methods

**Monte Carlo control** is an iterative algorithm where each iteration contains a Monte Carlo prediction step followed by a policy improvment step. The improvement step is simply done by making the policy greedy with the predicted value function.

Some technical conditions must be satisfied to ensure convergence of this naive algorithm:

* episodes have exploring starts (meaning that they don't attempt to be greedy or optimal at the start)
* There are an infinite number of episodes

These are ok theoretically, but prohibative computationally.

**Monte Carlo ES** is an algorithm that does away with the assumption that you need an infinite number of episodes. It proceeds as

![MC ES](/monte_carlo_es.png)

Notice that we don't need the assumption of an infinite number of episodes because we don't do a full policy evaluation each step.

To do away with the exploring starts assumption we need to define a few more terms.

- A policy $\pi$ is said to be **$\varepsilon$-soft** if $\pi(a|s) > \frac{\varepsilon}{| A(s) |}$ for all $a \in A$ and $s \in S$.
- An **$\varepsilon$-greedy** is a policy where all non-greedy actions are chosen with probability $\frac{\varepsilon}{| A(s) |}$, while the greedy policy is chosen with probability $1 - \varepsilon + \frac{\varepsilon}{| A(s) |}$.
- **On-policy** methods evaluate and improve the policy that is used to make decisions.
- **Off-policy** methods use one policy to make decisions while trying to evaluate and improve another policy.
- A **first-visit** MC method uses only the _return_ (not reward) after the _first_ occurance of a state (or state-action pair) when doing evaluation. An **every-visit** method uses the _return_ after every occurance of a state (or state-action pair) when doing evaluation.

An on-policy first-visit MC control algorithm for $\varepsilon$-soft policies is given below:

![On-policy first-visit MC control](/on_policy_eps_soft_mc_control.png)

### Importance sampling

This section will include more prediction and control methods, but is an important enough concept that it deserves its own section.
