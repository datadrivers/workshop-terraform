---
title: Dependencies
permalink: /dependencies/
nav_order: 5
---

Terraform builds a dependency graph from the Terraform configurations, and walks this graph to generate plans, refresh state, and more.

To walk the graph, a standard depth-first traversal is done. Graph walking is done in parallel: a node is walked as soon as all of its dependencies are walked.

Setting -parallelism is considered an advanced operation and should not be necessary for normal usage of Terraform. It may be helpful in certain special use cases or to help debug Terraform issues.
