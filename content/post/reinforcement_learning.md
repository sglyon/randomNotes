---
title: "Reinforcement Learning Intro"
date: "2016-06-29"
author: "Spencer Lyon"
series: ["Reinforcement Learning"]
series_weight: 1
tags: ["DP", "ML", "RL", "algorithms"]
tags_weight: 1
---

This is part 1 in the reinforcement learning for economists notes. For a list of all entries in the series go [here](/series/reinforcement-learning)

These notes mostly follow Sutton, R. S., & Barto, A. G. (2015). Reinforcement Learning: An Introduction (2 Draft, Vol. 9). http://doi.org/10.1109/TNN.1998.712192

The notes themselves might be interpreted as a macro-economist's view of reinforcement learning (RL). I will cast many objects/ideas from the book into the domain-specific framework I am familiar with.

# What is reinforcement learning?

**Reinforcement Learning** is a branch of machine learning that aims to learn by doing.

# Basic strcture

The basic structure of the RL problem is similar to a dynamic programming (DP) problem. Both summarize the environment an agent faces via a state variable $s$ that is a member of the state space $S$. Agents must choose actions from an action space $A(s)$. The dependence on $s$ takes into account any state-dependent constraints that specify which actions are feasible from that given state. A generic element of the space $A$ is called an action and is denoted $a \in A$.

In both RL and DP, algorithms are constructed to choose policies $\pi: S -> \Delta(A)$ and approximate or evaluate the value of such policies. The notaiton $\Delta(A)$ is a simplex or probability distribution over $A$. When we write $\pi(a | s)$ the probability of choosing $a$ in state $s$ under the policy $\pi$. In most economic models policies are degenerate, meaning that they specify a single action with probablity 1 for each state. In this case we may write $a = \pi(s)$ as the policy.

In DP these values are often expresesd as a value function $V: S -> R$. This is known as a **state-value** function.

In RL values are either expressed using $V$, or using a **action-value** function $Q: S \times A -> R$.

Let $\gamma \in [0, 1]$ be a discount factor.

Timing in Sutton and Barto is such that in time $t$ the agent sees state $S_t \in S$, chooses action $A_t \in A(S_t)$, then recieves a **reward** $R_{t+1}$, and finally observes a new state $S_{t+1} \in S$.

A **Return** $G_t \in R$ is the sum of discounted rewards:

<!-- NOTE: for hugo we need to escape the `_` for some reason... -->
$$G_t = \sum\_{k=0}^{\infty} \gamma^k R\_{t+k+1}$$

We can write the value of following a particular policy $\pi$ starting in a state $s$ using state-value functions as:

$$v\_{\pi}(s) \equiv E\_{\pi} \left[G\_t | S\_t = s \right] = E\_{\pi} \left[\sum\_{k=0}^{\infty} \gamma^k R\_{t+k+1} | S\_t = s \right].$$

Likewise we can write the action-value of following policy $\pi$ from state $s$ and action $a$ as


$$q\_{\pi}(s, a) \equiv E\_{\pi} \left[G\_t | S\_t = s A\_t = a\right] = E\_{\pi} \left[\sum\_{k=0}^{\infty} \gamma^k R\_{t+k+1} | S\_t = s, A\_t = a \right].$$

We define the optimal state-value function as $v(s) \equiv \max\_{\pi} v\_{\pi}(s)$ and the optimal action-value function as $q(s, a) \equiv \max\_{\pi} q\_{\pi}(s, a)$. We can obtain $v$ from $q$ as $v = \max\_{a} q(s, a)$. Thus, knowing $q$ gives more information than knowing $v$: $q$ gives the optimal value of taking *any* action from state $s$ and $v$ gives the optimal value of taking the *optimal* value from state $s$.

# Algorithms

The class of RL algorithms can be understood by first defining some terms from DP.

Given a policy $\pi$, **policy evaluation** is the process by which the state-or-action-value function is computed from $\pi$. This typically happens via some sort of backup operation. In DP we use a **full-backup** where "each iteration of iterative policy evaluation backs up the value of every state once to produce the new approximate value function". Economists call this full-backup one iteration on the Bellman equation.

In a control problem, after evaluating a policy we typically seek to improve it. **policy-improvement** is often implemented by selecting a **greedy** policy state by state. That is, a new policy $\pi'$ is obtained from $\pi$ by selecting $\pi'(s) = \text{argmax}\_a q\_{\pi}(s, a)$.

## DP Algorithms

**Generalized policy iteration (GPI)** is a major concept in the Sutton and Barto book. The core idea is alternating between policy evaluation and policy improvement. Policy evaluation drives the estimated value function towards the value of the policy while policy improvement improecs the policy with respect to the estimated value function. These two operations are competing in some sense as each one creates a moving target for the other. If both evaluation and improvement components have stabalized, then the value and policy functions must be optimal. The value function only converges when it is consistent with the current policy and the policy function only converges when it is optimal with respect to the current value function.

**Policy-iteration** is an example of GPI where we alternate on full policy evaluation and full policy improvment. The evaluation step provides the value of the current policy. The improvement step obtains a new policy, taking into account the values associated with the current policy.

**Value-iteration** is another example of GPI where one iteration of the bellman operator is applied as a partial policy evaluation, followed by a full policy improvement.

**Asynchronous DP algorithms** are modifications of policy or value iteration where you do not perform a full backup of the policy or value functions on each iteration (meaning you don't update the policy and value functions for all states in every iteration). Instead, these methods vary in which states they update, using whatever values for other states happen to be available.
