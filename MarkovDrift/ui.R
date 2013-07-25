# Shiny ui script for Markov simulation of genetic drift

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Markov simulation of genetic drift"),
  
  sidebarPanel(
    sliderInput("size","Number of individuals in population",value=10,min=1,max=1000),
    
    sliderInput("init.alleles","Number of A alleles in first generation",value=5,min=0,max=2000),
    
    sliderInput("generations","Generations to simulate",value=5,min=2,max=100)
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("resultsPlot")),
      tabPanel("Table", tableOutput("resultsTable"))
    )  )
))
