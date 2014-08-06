shinyUI(pageWithSidebar(
  
  headerPanel("Sums of random variables"),
  
  sidebarPanel(
    radioButtons("an", HTML("a<sub>k</sub>"),
                list("1" = "one", 
                     "1/sqrt(k)" = "oneoversqrn", 
                     "1/k" = "oneovern", 
                     "1/k^2" = "oneovernsq",
                     "2^{-k}" = "exp")),
    br(),
    
    sliderInput("n", "Length of each sequence (n):", value = 50, min = 1, max = 500),
    sliderInput("m", "Number of sequences:", value = 1, min = 1, max = 50),
    
    checkboxInput("connect", "Connect", FALSE),
    checkboxInput("points", "Points", TRUE),
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