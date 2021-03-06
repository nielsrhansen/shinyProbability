
Required packages and initialization
------------------------------------


```r
require(ggplot2)        ## Grammar of graphics package
require(gridExtra)      ## Plot arrangement
theme_set(theme_bw())   ## Black and white theme for ggplot2

n <- 50                  ## Number of random variables per replication
m <- 500                ## Number of replications
```


The simulation and plotting
---------------------------


```r
samp <- numeric(m)
for (i in 1:m) {
  set.seed(100 * i)          ## Change to get a different realization
  tmp <-  rpois(n, 1)    
  tmean <- 1
  ## tmp <- rt(n, 3) / sqrt(3)      ## Alternative choice of distribution
  ## tmean <- 0
  samp[i] <- sum(tmp - tmean) / sqrt(n)
  }
samp <- sort(samp)

p1 <- qplot(samp, seq(1/m, 1, 1/m), geom = "step") + 
  geom_line(aes(x = x, y = pnorm(x)), color = "red") +
  ylab("Probability") + xlab("x") + ggtitle("Distribution functions")

p2 <- qplot(ppoints(m), pnorm(samp)) + geom_abline(intercept = 0, slope = 1) +
  ylab("Sample percentiles") + xlab("Theoretical percentiles") + ggtitle("Probability-Probability plot")  

p3 <- qplot(samp, ..density.., geom = "histogram", binwidth = 0.3, fill = I(gray(0.7))) + 
  geom_line(aes(x = x, y = dnorm(x)), color = "red", size = 1.5) +
  ylab("Density") + xlab("x") + ggtitle("Histogram and density")

p4 <- qplot(sample = samp, stat = "qq") + geom_abline(intercept = 0, slope = 1) +
  ggtitle("Quantile-Quantile plot")

grid.arrange(p1, p2, p3, p4, nrow = 2)
```

