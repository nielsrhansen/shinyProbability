shinyUI(pageWithSidebar(
  
  headerPanel("The central limit theorem"),
  
  sidebarPanel(
    radioButtons("dist", "Distribution",
                list("N(0,1)" = "normal", 
                     "Exp(1)" = "exponential", 
                     "t(3)" = "T3", 
                     "t(2)" = "T2",
                     "Pois(1)" = "poisson")),
    br(),
    
    sliderInput("n", "Number of random variables (n):", value = 50, min = 1, max = 500),
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