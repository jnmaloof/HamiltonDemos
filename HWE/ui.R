library(shiny)

# Define UI for application that plots HWE and genotype frequencies
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("HWE"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("AA", 
                "Genotype frequency of AA", 
                min = 0,
                max = 1, 
                value = .5),
    
    sliderInput("Aa", 
                "Genotype frequency of Aa", 
                min = 0,
                max = 1, 
                value = .2500),
    
    sliderInput("aa", 
                "Genotype frequency of aa", 
                min = 0,
                max = 1, 
                value = .2500),
    
    tableOutput("genotypes"),
    tableOutput("alleles"),
    textOutput("error")
    
  ),
  
  # Show a plot of the HWE and the user input population
  mainPanel(
    plotOutput("hwePlot")
  )
))