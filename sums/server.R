if(!getRversion() >= '3.0.0')
  stop("\n\n Update R to the latest version.\n\n")
if(!require(shiny))
  install.packages("shiny", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(ggplot2))
  install.packages("ggplot2", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(reshape2))
  install.packages("reshape2", repos = "http://mirrors.dotsrc.org/cran/")
theme_set(theme_bw())   ## Black and white theme for ggplot2

shinyServer(function(input, output) {

  sequence <- reactive({
    nn <- seq(1, input$n, 1)
    an <- switch(input$an,
                 one = rep(1, input$n),
                 oneoversqrn = 1/sqrt(nn),
                 oneovern = 1/nn,
                 oneovernsq = 1/nn^2,
                 exp = 2^{-nn})
    sn <- list()
    for (i in 1:input$m) {
      set.seed((100 + input$seed) * i)
      sn[[i]] <- c(2, 2 + cumsum(sample(c(-1, 1), input$n, replace = TRUE) * an))
    }
    nn <- c(0, nn)
    cbind(nn, melt(sn))
  })  
  
  output$plot <- renderPlot({
    p <- ggplot(data = sequence(), aes(x = nn, y = value, color = as.factor(L1))) + 
      scale_color_discrete(guide = "none") + geom_hline(yintercept = 0) +
      ylab(expression(S[n])) + xlab("n")
      if (input$connect) 
        p <- p + geom_line(size = 1)
      if (input$points)
        p <- p + geom_point(size = 2)
    print(p)
  })
})