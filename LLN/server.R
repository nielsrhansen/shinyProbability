if(!getRversion() >= '3.0.0')
  stop("\n\n Update R to the latest version.\n\n")
if(!require(shiny))
  install.packages("shiny", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(ggplot2))
  install.packages("ggplot2", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(reshape2))
  install.packages("reshape2", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(gridExtra))
  install.packages("gridExtra", repos = "http://mirrors.dotsrc.org/cran/")

theme_set(theme_bw())   ## Black and white theme for ggplot2

shinyServer(function(input, output) {

  sequence <- reactive({
    n <- input$n
    sn <- list()
    for (i in 1:input$m) {
      set.seed((100 + input$seed) * i)
      sn[[i]] <- switch(input$dist,
                     normal = rnorm(n),
                     exponential = rexp(n),
                     T2 = rt(n, 2),
                     cauchy = rt(n, 1),
                     poisson = rpois(n, 1))
      sn[[i]] <- switch(input$f,
                        id = sn[[i]],
                        exp = exp(sn[[i]]),
                        ind = as.numeric(sn[[i]] > 1))
    }
    nn <- seq(1, n, 1)
    list(samp = cbind(nn, melt(sn)), 
         mean = cbind(nn, melt(lapply(sn, function(x) cumsum(x) / nn))),
         tmean = switch(
           input$f,
           id = switch(input$dist,
                  normal = 0,
                  exponential = 1,
                  T2 = 0,
                  cauchy = NA,
                  poisson = 1),
           exp = switch(input$dist,
                        normal = exp(1/2),
                        exponential = NA,
                        T2 = NA,
                        cauchy = NA,
                        poisson = exp(exp(1) - 1)),
           ind = switch(input$dist,
                        normal = pnorm(1, lower.tail = FALSE),
                        exponential = pexp(1, lower.tail = FALSE),
                        T2 = pt(1, 2, lower.tail = FALSE),
                        cauchy = pt(1, 1, lower.tail = FALSE),
                        poisson = ppois(1, 1, lower.tail = FALSE))
         )
    )
  })  
  
  output$plot <- renderPlot({
    data <- sequence()
    line <- geom_hline(yintercept = data$tmean)
    if(is.na(data$tmean)) 
      line <- c()
    p1 <- ggplot(data = data$samp, aes(x = nn, y = value, color = as.factor(L1))) + 
      scale_color_discrete(guide = "none") +
      ylab(expression(f(X[n]))) + xlab("n") + geom_point()
    p2 <- ggplot(data = data$mean, aes(x = nn, y = value, color = as.factor(L1))) + 
      scale_color_discrete(guide = "none") +
      ylab(expression(S[n]/n)) + xlab("n") +
      geom_line() + line
    grid.arrange(p1, p2, nrow = 2)
  })
})