shinyUI(pageWithSidebar(
  
  headerPanel("Law of large numbers"),
  
  sidebarPanel(
    radioButtons("dist", "Distribution",
                list("N(0,1)" = "normal", 
                     "Exp(1)" = "exponential", 
                     "t(2)" = "T2", 
                     "Cauchy" = "cauchy",
                     "Pois(1)" = "poisson")),
    br(),
    radioButtons("f", "f(x)",
                 list("x" = "id", 
                      "exp(x)" = "exp", 
                      "1(x <= 1)" = "ind")), 
    br(),
    
    sliderInput("n", "Number of random variables (n):", value = 50, min = 1, max = 200),
    sliderInput("m", "Number of replications:", value = 1, min = 1, max = 10),
    br(),
    actionButton("seed", "Resimulate"),
    includeHTML("Questions.html")
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("R code", includeHTML("Rcode.html"))
    ),
    includeHTML("Setup.html")
  )
))