# Algorithms

Algorithmic techniques, complexity analysis, searching, sorting, graphs and problem solving.


Absolutely. For a **10+ years experienced software engineer / senior engineer / architect / engineering manager** targeting Tier-1 product companies, I would **not** recommend memorizing hundreds of LeetCode problems.

The goal should be to master a **compact set of algorithmic patterns** that cover most interview problems and demonstrate strong problem-solving, complexity analysis, and engineering judgment.

## Tier-1 Interview — Core Algorithm Checklist

### 1. Arrays & Hashing — Foundation

| #   | Algorithm / Pattern           | Must Know |
| --- | ----------------------------- | --------- |
| 1.1 | HashMap / HashSet lookup      | ⭐⭐⭐       |
| 1.2 | Two Pointers                  | ⭐⭐⭐       |
| 1.3 | Sliding Window                | ⭐⭐⭐       |
| 1.4 | Prefix Sum / Difference Array | ⭐⭐⭐       |
| 1.5 | Kadane's Algorithm            | ⭐⭐        |
| 1.6 | Sorting + scanning            | ⭐⭐⭐       |

**Typical problems:** duplicates, subarrays, longest/shortest window, maximum sum, frequency counting.

---

### 2. Searching & Sorting

| #   | Algorithm / Pattern       | Must Know |
| --- | ------------------------- | --------- |
| 2.1 | Binary Search             | ⭐⭐⭐       |
| 2.2 | Binary Search on Answer   | ⭐⭐⭐       |
| 2.3 | Merge Sort                | ⭐⭐⭐       |
| 2.4 | Quick Sort / Quick Select | ⭐⭐        |
| 2.5 | Heap Sort concept         | ⭐         |
| 2.6 | Top-K using Heap          | ⭐⭐⭐       |

**Senior-level expectation:** Know **why** you choose binary search/heap/sort, not just implementation.

---

### 3. Linked Lists

| #   | Algorithm / Pattern              | Must Know |
| --- | -------------------------------- | --------- |
| 3.1 | Fast & Slow Pointer              | ⭐⭐⭐       |
| 3.2 | Reverse Linked List              | ⭐⭐⭐       |
| 3.3 | Merge Linked Lists               | ⭐⭐⭐       |
| 3.4 | Detect Cycle — Floyd's Algorithm | ⭐⭐⭐       |
| 3.5 | Find Middle / Kth from End       | ⭐⭐        |

These are relatively small topics but are often used to test pointer/reference reasoning.

---

### 4. Stack, Queue & Monotonic Structures

| #   | Algorithm / Pattern        | Must Know |
| --- | -------------------------- | --------- |
| 4.1 | Stack-based parsing        | ⭐⭐⭐       |
| 4.2 | Monotonic Stack            | ⭐⭐⭐       |
| 4.3 | Monotonic Queue            | ⭐⭐        |
| 4.4 | BFS using Queue            | ⭐⭐⭐       |
| 4.5 | Deque-based Sliding Window | ⭐⭐        |

**Important:** Monotonic Stack is disproportionately valuable for Tier-1 interviews.

---

### 5. Trees & Binary Search Trees

| #   | Algorithm / Pattern          | Must Know |
| --- | ---------------------------- | --------- |
| 5.1 | DFS — Pre/In/Post Order      | ⭐⭐⭐       |
| 5.2 | BFS / Level Order            | ⭐⭐⭐       |
| 5.3 | Recursive Tree Traversal     | ⭐⭐⭐       |
| 5.4 | BST Search / Insert / Delete | ⭐⭐⭐       |
| 5.5 | Lowest Common Ancestor       | ⭐⭐⭐       |
| 5.6 | Tree Height / Diameter       | ⭐⭐⭐       |
| 5.7 | Balanced Tree concepts       | ⭐⭐        |

You should be comfortable converting between **recursive DFS and iterative DFS**.

---

### 6. Graph Algorithms

This is one of the **highest-value categories** for experienced candidates.

| #   | Algorithm / Pattern                  | Must Know |
| --- | ------------------------------------ | --------- |
| 6.1 | BFS / DFS                            | ⭐⭐⭐       |
| 6.2 | Connected Components                 | ⭐⭐⭐       |
| 6.3 | Cycle Detection                      | ⭐⭐⭐       |
| 6.4 | Topological Sort                     | ⭐⭐⭐       |
| 6.5 | Union-Find / DSU                     | ⭐⭐⭐       |
| 6.6 | Dijkstra's Algorithm                 | ⭐⭐⭐       |
| 6.7 | Minimum Spanning Tree — Kruskal/Prim | ⭐⭐        |
| 6.8 | Bellman-Ford concept                 | ⭐         |

For a senior candidate, understand **when each graph algorithm is applicable**, particularly the constraints around weighted/unweighted graphs and negative edges.

---

### 7. Dynamic Programming

Don't try to memorize 100 DP problems. Master the **patterns**.

| #   | DP Pattern                     | Must Know |
| --- | ------------------------------ | --------- |
| 7.1 | 1D DP                          | ⭐⭐⭐       |
| 7.2 | 2D / Grid DP                   | ⭐⭐⭐       |
| 7.3 | Knapsack                       | ⭐⭐⭐       |
| 7.4 | Subsequence DP                 | ⭐⭐⭐       |
| 7.5 | Longest Common Subsequence     | ⭐⭐⭐       |
| 7.6 | Longest Increasing Subsequence | ⭐⭐⭐       |
| 7.7 | State-machine DP               | ⭐⭐        |
| 7.8 | DP + Memoization vs Tabulation | ⭐⭐⭐       |

**Most important skill:** Given a new problem, identify:

> **State → Transition → Base Case → Computation Order**

---

### 8. Greedy Algorithms

| #   | Algorithm / Pattern              | Must Know |
| --- | -------------------------------- | --------- |
| 8.1 | Interval Scheduling              | ⭐⭐⭐       |
| 8.2 | Merge Intervals                  | ⭐⭐⭐       |
| 8.3 | Activity Selection               | ⭐⭐⭐       |
| 8.4 | Greedy + Sorting                 | ⭐⭐⭐       |
| 8.5 | Greedy + Heap                    | ⭐⭐        |
| 8.6 | Exchange Argument / Greedy Proof | ⭐⭐        |

The important part at senior level is being able to **justify why the greedy choice works**.

---

### 9. Backtracking & Recursion

| #   | Algorithm / Pattern           | Must Know |
| --- | ----------------------------- | --------- |
| 9.1 | Permutations                  | ⭐⭐⭐       |
| 9.2 | Combinations                  | ⭐⭐⭐       |
| 9.3 | Subsets                       | ⭐⭐⭐       |
| 9.4 | N-Queens                      | ⭐⭐        |
| 9.5 | Constraint-based Backtracking | ⭐⭐⭐       |
| 9.6 | Pruning / Branch Reduction    | ⭐⭐⭐       |

---

### 10. Advanced Data Structures

You don't need implementation-level mastery of all of these, but should understand their use cases.

| #    | Structure / Algorithm                    | Must Know |
| ---- | ---------------------------------------- | --------- |
| 10.1 | Heap / Priority Queue                    | ⭐⭐⭐       |
| 10.2 | Trie                                     | ⭐⭐⭐       |
| 10.3 | Union-Find                               | ⭐⭐⭐       |
| 10.4 | LRU Cache — HashMap + Doubly Linked List | ⭐⭐⭐       |
| 10.5 | Segment Tree                             | ⭐⭐        |
| 10.6 | Fenwick Tree                             | ⭐         |
| 10.7 | Interval Tree concept                    | ⭐         |

---

## 11. String Algorithms

| #    | Algorithm / Pattern   | Must Know |
| ---- | --------------------- | --------- |
| 11.1 | Frequency / Hashing   | ⭐⭐⭐       |
| 11.2 | Sliding Window        | ⭐⭐⭐       |
| 11.3 | String matching       | ⭐⭐        |
| 11.4 | KMP                   | ⭐⭐        |
| 11.5 | Trie-based search     | ⭐⭐⭐       |
| 11.6 | Palindrome techniques | ⭐⭐        |

For most interviews, **KMP is less important than knowing when string hashing, Trie, or sliding window solves the problem more simply.**

---

# The "Must Master" 25

If you want an even shorter list, I'd make these your **Tier-1 interview core**:

1. **HashMap / HashSet**
2. **Two Pointers**
3. **Sliding Window**
4. **Prefix Sum**
5. **Binary Search**
6. **Binary Search on Answer**
7. **Merge Sort**
8. **Quick Select**
9. **Fast & Slow Pointer**
10. **Monotonic Stack**
11. **Heap / Priority Queue**
12. **DFS**
13. **BFS**
14. **BST**
15. **Lowest Common Ancestor**
16. **Tree Diameter**
17. **Topological Sort**
18. **Union-Find**
19. **Dijkstra**
20. **Merge Intervals**
21. **Greedy + Sorting**
22. **Backtracking**
23. **Dynamic Programming**
24. **Trie**
25. **LRU Cache**

### For a decade+ experience candidate, add one more layer

The interview isn't usually won by knowing algorithm **#26**.

It's won by being able to take an unfamiliar problem and quickly articulate:

**Problem → Constraints → Pattern → Data Structure → Algorithm → Complexity → Edge Cases → Trade-offs**

For example:

> "N is 10 million, values are streaming, we need top 100, and memory is constrained."

A strong senior candidate should immediately reason toward something like:

**Streaming → bounded memory → Min Heap of size K → O(N log K) → O(K) memory**

rather than trying to recall a specific LeetCode problem.

### Suggested priority

**Tier 1 — absolutely master:**
Arrays/Hashing → Binary Search → Sliding Window → Trees → Graphs → Heap → DP → Greedy

**Tier 2 — strong familiarity:**
Backtracking → Trie → Monotonic structures → Union-Find → LRU

**Tier 3 — know conceptually:**
KMP → Segment Tree → Fenwick Tree → Bellman-Ford → advanced string algorithms

For a **10+ year C#/.NET candidate**, I'd also separate this into a **30–40 problem "interview workout"**, where each problem is deliberately chosen to teach one or more of these patterns rather than simply collecting LeetCode questions.
