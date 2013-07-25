# Shiny ui script for Markov simulation of genetic drift

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Markov simulation of genetic drift"),
  
  sidebarPanel(
    sliderInput("size","Number of individuals in population",value=10,min=1,max=100),
    
    sliderInput("initAlleles","Number of A alleles in first generation",value=5,min=0,max=200),
    
    sliderInput("generations","Generations to simulate",value=5,min=2,max=50),
    
    sliderInput("theta","left-right viewing angle",value=80,min=0,max=360),
    
    sliderInput("phi","top-bottom viewing angle",value=10,min=-90,max=90)
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("resultsPlot",height="100%")),
      tabPanel("Table", tableOutput("resultsTable"))
    )  )
))
