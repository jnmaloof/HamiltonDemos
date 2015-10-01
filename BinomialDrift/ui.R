## Shiny App to illustrate genetic drift using a binomial model
## Julin Maloof
## July 23, 2013

library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Genetic Drift--Binomial Model"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    numericInput("pops","Number of populations to simulate",value=10,min=1,max=100),
    
    numericInput("size", "Number of individuals in each population",value=100,min=2,max=100000),
    
    numericInput("generations","Number of generations to run simulation for",value=50,min=10,max=1000),
    
    numericInput("freq","Frequency of first allele",value=.5,min=0,max=1)
  ),
  
  # Show a plot of the HWE and the user input population
  mainPanel(
    plotOutput("driftPlot")
  )
))