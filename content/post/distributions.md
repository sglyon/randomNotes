---
title: "Probability distributions"
date: "2015-12-28"
author: "Spencer Lyon"
series: ["Probability & Statistics"]
tags: ["math", "tips"]
---

Some probability distributions that are useful (usually to economists) for one reason or another.

### Pareto Distribution

The [Pareto distribution](https://en.wikipedia.org/wiki/Pareto_distribution) has a simple CDF: $G(x) = 1 - \underline{x}^{\gamma}x^{-\gamma}$, where $\underline{x}$ satisfies $G(\underline{x}) = 0$ and $\gamma$ governs the variance.

A useful property of the Pareto distribution is that when it is truncated, the truncated CDF is the same as the original, except that $\underline{x}$ is moved up.
