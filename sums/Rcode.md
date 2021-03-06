
Required packages and initialization
------------------------------------


```r
require(reshape2)       ## Includes the 'melt' function used below
require(ggplot2)        ## Grammar of graphics package
theme_set(theme_bw())   ## Black and white theme for ggplot2

m <- 1                  ## Number of sequences
n <- 50                 ## Length of each sequence
k <- 1:n       
an <- rep(1, n)         ## Sequence of ones
## an <- 1/k            ## Example of alternative sequence
```


The simulation and plotting
---------------------------


```r
sn <- list()
for (i in 1:m) {
      set.seed(100 * i) ## Change to get a different realization
      sn[[i]] <- c(2, 2 + cumsum(sample(c(-1, 1), n, replace = TRUE) * an))
    }

nn <- c(0, k)
ggplot(data = cbind(nn, melt(sn)), aes(x = nn, y = value, color = as.factor(L1))) + 
      scale_color_discrete(guide = FALSE) + geom_hline(yintercept = 0, size = 1.5) +
      ylab(expression(S[n])) + xlab("n") + geom_point()
```

