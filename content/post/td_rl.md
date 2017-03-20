---
title: "Temporal-Difference methods"
date: "2016-06-29"
author: "Spencer Lyon"
series: ["Reinforcement Learning"]
series_weight: 3
tags: ["TD", "RL", "algorithms"]
tags_weight: 2
---

This is part 3 in the reinforcement learning for economists notes. For part 1 see [Reinforcement Learning Intro]({{< relref "post/reinforcement_learning.md" >}}). For a list of all entries in the series go [here](/series/reinforcement-learning)

## Temporal Difference methods

We continue our study of applying **GPI** to the RL problem by looking now at **temporal difference (TD)** methods.

### One step TD (TD(0))

<!-- TODO: clean this exposition up -- it's not well written -->

Let's begin our exploration of TD methods by considering the problem of evaluating or predicting the state-value function $V(s)$. The simplest TD algorithm will update $V(s)$ according to the following rule:

$$V(s) \leftarrow V(s) + \alpha \left[G - V(S) \right],$$

where $G$ is the return from state $s$. The term in the brackets is the difference between the actual reward in state $s$ ($G$) and the current estimate of that reward ($V(s)$) and is called the temporal difference.
