<!-- Customization of default CSS -->
<head>
<style>
body {font-size: 15px;}
</style>
</head>


Setup
-----

The Law of Large Numbers (LNN) states that if $X_1, X_2, \ldots$ are i.i.d. random variables with 
expectation $\mu$ then 
$$\frac{1}{n} S_n = \frac{1}{n} \sum_{k=1}^n X_k \rightarrow \mu$$
for $n \to \infty$. The limit is deterministic, and the convergence is **almost sure** (sometimes referred to as 
the **strong** law of large numbers) as well as in probability. 

For $f : \mathbb{R} \to \mathbb{R}$ it follows from the LLN that if $E |f(X_1)| < \infty$ then 
$$\frac{1}{n} \sum_{k=1}^n f(X_k) \rightarrow E f(X_1)$$
almost surely.

For random variables with finite second moment the convergence in probability follows from 
Chebyschev's inequality. For random variables with finite fourth moment, the almost sure convergence 
follows from Borel-Cantelli's lemma and a technical bound (Exercise 1.11). However, the 
LLN holds under the minimal assumption that the variables have finite first moment. This requires a little more 
ingenuity and some technical arguments to show. 








