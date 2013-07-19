library(shiny)

# Define UI for application that plots random distributions 
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
                value = .250),
    
    tableOutput("genotypes"),
    tableOutput("alleles"),
    textOutput("error")
    
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("hwePlot")
  )
))