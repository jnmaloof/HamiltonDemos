# Server side of shiny app to plot binomial genetic drift simulations

library(shiny)

shinyServer(func=function(input,output){
  
  output$driftPlot <- renderPlot({
      size = input$size*2 #assume individuals are diploid but there are 2n chromosomes
      results <- matrix(nrow=input$generations+1,ncol=input$pops) #create matrix to hold results
      results[1,] <- input$freq               #populate first row with initial frequencies
      for (g in 2:(input$generations+1)) {    #loop through the generations
        results[g,] <- rbinom(input$pops,size,prob=results[g-1,])/size #calculate the next generations frequencies
      }
      print( matplot(results,type="l",lwd=2,main=paste("n = ",size,", generations = ",input$generations),ylab = " frequency", ylim = c(0,1)))
})
})