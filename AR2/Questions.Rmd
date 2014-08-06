<!-- Customization of default CSS -->
<head>
<style>
body {font-size: 15px;}
</style>
</head>
<br>

The simulation
--------------

The top left is the sample path of the AR(2)-process, and the bottom left
shows that roots of the characteristic polynomial for the given choice of 
parameters. If they are outside of the unit disc, the process is a 
(weakly) stationary process. 

The top right is the running average
$$\frac{1}{n} S_n = \frac{1}{n} \sum_{k=1}^n X_k$$
of the process itself. The empirical second moment is 
$$\hat{\sigma}^2_n =  \frac{1}{n} \sum_{k=1}^n X_k^2,$$ and 
the lag-$k$ empirical autocorrelation is computed as 
$$\text{AC}_n(k) = \frac{1}{\hat{\sigma}^2_n} \frac{1}{n - k} \sum_{j = k + 1}^n X_{j} X_{j-k}.$$

The bottom right figure shows $\text{AC}_n(1)$ (blue) and $\text{AC}_n(2)$ (red).

* For which values of the parameters $b_1$ and $b_2$ is the process (weakly)
stationary?
* Under which conditions does $\text{AC}_n(k)$ converge almost surely, and 
what is the limit?
* How can $\text{AC}_n(1)$ and $\text{AC}_n(2)$ be used to estimate the $b_1$ and 
$b_2$ parameters from observations of an AR(2)-process?





