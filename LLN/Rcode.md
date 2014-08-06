
Required packages and initialization
------------------------------------


```r
require(reshape2)       ## Includes the 'melt' function used below
require(ggplot2)        ## Grammar of graphics package
require(gridExtra)      ## Plot arrangement
theme_set(theme_bw())   ## Black and white theme for ggplot2

n <- 50                 ## Number of random variables per replication
m <- 1                  ## Number of replications
```


The simulation and plotting
---------------------------


```r
sn <- list()
for (i in 1:m) {
  set.seed(100 * i)          ## Change to get a different realization
  sn[[i]] <-  rnorm(n)
##  sn[[i]] <-  rpois(n, 1)  ## Alternative choice of distribution
  }
nn <- seq(1, n, 1)
samp = cbind(nn, melt(sn))
cummean = cbind(nn, melt(lapply(sn, function(x) cumsum(x) / nn)))

p1 <- ggplot(data = samp, aes(x = nn, y = value, color = as.factor(L1))) + 
  scale_color_discrete(guide = FALSE) + ylab(expression(X[n])) + xlab("n") + geom_point()

p2 <- ggplot(data = cummean, aes(x = nn, y = value, color = as.factor(L1))) + 
  scale_color_discrete(guide = FALSE) + ylab(expression(S[n]/n)) + xlab("n") + geom_line()

grid.arrange(p1, p2, nrow = 2)
```

