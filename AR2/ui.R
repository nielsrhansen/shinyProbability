shinyUI(pageWithSidebar(
  
  headerPanel("The AR(2)-process"),
  
  sidebarPanel(
    
    sliderInput("n", "Length of process:", value = 50, min = 20, max = 500, step = 10),
    sliderInput("b1", "b1:", value = 0.3, min = -2, max = 2, step = 0.1),
    sliderInput("b2", "b2:", value = -0.3, min = -1, max = 1, step = 0.1),
    
    br(),
    actionButton("seed", "Resimulate"),
    includeHTML("Questions.html")
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot"))
      #tabPanel("R code", includeHTML("Rcode.html"))
    ),
    includeHTML("Setup.html")
  )
))