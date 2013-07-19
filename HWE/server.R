library(shiny)
library(ggplot2)
library(reshape)


#generic data for HWE plot

hwe <- data.frame(p=seq(0,1,.01))
hwe$q <- 1-hwe$p
hwe$AA <- hwe$p^2
hwe$Aa <- 2*hwe$p*hwe$q
hwe$aa <- hwe$q^2

#plot basic HWE plot
hwe.m <- melt(hwe,id.vars=c("p","q"))
pl <- ggplot(hwe.m,aes(x=p,y=value,col=variable))
pl <- pl + geom_line() + ylab("Aa frequency")

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  output$hwePlot <- renderPlot({
    
    user.p <- input$AA + 0.5*input$Aa
    
    print(pl + geom_point(x=user.p,y=input$Aa,color="black"))
  })
  
  output$genotypes <- renderTable(data.frame(AA=input$AA,Aa=input$Aa,aa=1-input$AA-input$Aa),digits=3)
  
  output$alleles <- renderTable(data.frame(p=(input$AA+0.5*input$Aa),q=1-(input$AA+0.5*input$Aa)),digits=3)
  
  output$error <- renderText(ifelse(input$AA+input$Aa > 1,"ERROR: genotype frequencies most total 1 or less",""))
  
})