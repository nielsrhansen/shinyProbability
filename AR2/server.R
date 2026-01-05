if(!getRversion() >= '3.0.0')
  stop("\n\n Update R to the latest version.\n\n")
if(!require(shiny))
  install.packages("shiny", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(ggplot2))
  install.packages("ggplot2", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(gridExtra))
  install.packages("gridExtra", repos = "http://mirrors.dotsrc.org/cran/")
if(!require(grid))
  install.packages("grid", repos = "http://mirrors.dotsrc.org/cran/")

m <- 50
circleFun <- function(center = c(0, 0), r = 1, npoints = 100){
  tt <- seq(0, 2*pi, length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  rbind(data.frame(x = xx, y = yy), center)
}

shinyServer(function(input, output) {

  simulation <- reactive({
    set.seed((100 + input$seed))
    n <- input$n
    x <- numeric(n)
    x[1] <- x[2] <- 0
    b1 <- input$b1
    b2 <- input$b2
    roots <- polyroot(c(-1, b1, b2))
    if (all(Mod(roots) > 1)) {
      ## Burn in for the stationary case
      ww <- rnorm(m)
      for (i in 3:50) {
        x[3] <- b1 * x[2] + b2 * x[1] + ww[i]
        x[1] <- x[2]
        x[2] <- x[3]
      }
    }
    
    w <- rnorm(n)
    for (i in 3:n) 
      x[i] <- b1 * x[i - 1] + b2 * x[i - 2] + w[i]
    
    cm <- cumsum(x) / seq_along(x)
    sigma <- mean(x^2)
    cc1 <- cumsum(x[-n] * x[-1]) / seq_along(x[-1]) / sigma
    cc2 <- cumsum(x[-c(n-1, n)] * x[-c(1, 2)]) / seq_along(x[-c(1, 2)]) / sigma
    
    list(
      xcm = data.frame(x = x, cm = cm), 
      cc1 = data.frame(cc1), 
      cc2 = data.frame(cc2), 
      roots = data.frame(roots)
      )
  })  
  
  output$plot <- renderPlot({
    data <- simulation()
    b1 <- input$b1
    b2 <- input$b2
    p1 <- ggplot(data$xcm, aes(x = seq_along(x), y = x)) + 
      geom_line() +
      ylab(expression(X[n])) + xlab("n") 
    p2 <- ggplot(data$xcm, aes(x = seq_along(cm), y = cm)) + 
      geom_line() +
      ylab(expression(S[n]/n)) + xlab("n") +
      geom_hline(yintercept = 0) 
    p3 <- ggplot(data$roots, aes(x = Re(roots), y = Im(roots))) + 
      ylab("Im") + xlab("Re") + xlim(c(-2, 2)) + ylim(-2, 2) + 
      geom_polygon(data = circleFun(), aes(x, y), alpha = 0.4, fill = "red") +
      geom_point(size = 4)
    p4 <- ggplot(data$cc1, aes(x = seq_along(cc1), y = cc1)) +
      geom_line(color = I("blue")) +
      ylab(expression(AC[n])) + xlab("n") +
      geom_line(data = data$cc2, aes(x = seq_along(cc2), y = cc2), color = "red")
      if (all(Mod(data$roots$roots) > 1)) {
        rho1 <- b1 / (1 - b2)
        rho2 <- b2 + b1^2 / (1 - b2)
      p4 <- p4 + geom_hline(yintercept = rho1, color = "blue") +
          geom_hline(yintercept = rho2, color = "red")
      }
    grid.arrange(p1, p2, p3, p4, nrow = 2)
  })
})