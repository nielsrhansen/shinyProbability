if(!getRversion() >= '3.0.0')
  stop("\n\n Update R to the latest version.\n\n")
if(!require(shiny))
  install.packages("shiny", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(ggplot2))
  install.packages("ggplot2", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(gridExtra))
  install.packages("gridExtra", repos = "http://mirrors.dotsrc.org/cran/")
m <- 500   ## Number of replications
x <- seq(-3.5, 3.5, 0.01)
theme_set(theme_bw())   ## Black and white theme for ggplot2

shinyServer(function(input, output) {

  sequence <- reactive({
    n <- input$n
    sn <- numeric(m)
    tmean = switch(input$dist,
                   normal = 0,
                   exponential = 1,
                   T3 = 0,
                   T2 = 0,
                   poisson = 1)
    for (i in 1:m) {
      set.seed((100 + input$seed) * i)
      tmp <- switch(input$dist,
                     normal = rnorm(n),
                     exponential = rexp(n),
                     T3 = rt(n, 3) / sqrt(3),
                     T2 = rt(n, 2) / 3,
                     poisson = rpois(n, 1))
      sn[i] <- sum(tmp - tmean) / sqrt(n)
    }
    sort(sn)
  })  
  
  output$plot <- renderPlot({
    samp <- sequence()
    p1 <- ggplot(mapping = aes(samp, seq(1/m, 1, 1/m))) + 
      geom_step() + 
      geom_line(aes(x = x, y = pnorm(x)), color = "red") +
      ylab("Probability") + xlab("x") + ggtitle("Distribution functions")
    p2 <- ggplot(mapping = aes(ppoints(m), pnorm(samp))) +
      geom_point() + 
      geom_abline(intercept = 0, slope = 1) +
      ylab("Sample percentiles") + xlab("Theoretical percentiles") + ggtitle("Probability-Probability plot")  
    p3 <- ggplot(mapping = aes(samp, after_stat(density))) + 
      geom_histogram(binwidth = 0.3, fill = I(gray(0.7))) + 
      geom_line(aes(x = x, y = dnorm(x)), color = "red", linewidth = 1.5) +
      ylab("Density") + xlab("x") + ggtitle("Histogram and density")
    p4 <- ggplot() + 
      stat_qq(aes(sample = samp)) + 
      geom_abline(intercept = 0, slope = 1) +
      ggtitle("Quantile-Quantile plot")
    grid.arrange(p1, p2, p3, p4, nrow = 2)
  })
})