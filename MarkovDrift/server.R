## Shiny server script for Markov generation drift simulation
#Julin Maloof
#July26, 2013

library(shiny)
library(ggplot2)
library(reshape)

shinyServer(function(input,output,session) {
  
  observe({ #make sure that allele count is not greater than the total number of possible alleles
    print("observe")
    if (input$initAlleles > 2*input$size) {
      print("over")
      updateSliderInput(session,"initAlleles",value=2*input$size)
    }
  })
  
  results <- reactive({
    size <- 2*input$size
    m.binom <- matrix(0,nrow=size+1,ncol=size+1,dimnames=list(from=0:size,to=0:size)) #this will hold the binomial transition probabilities
    
    #now we should be able to fill in the matrix by mutliplying the allele probabilities in the current generation by the binomial probabilities
    
    for (f in 0:size) {
      for (t in 0:size) {
        m.binom[f+1,t+1] <- dbinom(x=t,size=size,prob=f/size)
      }}
    
    #now for each generation mutliply the transition matrix by the allele probabilties
    
    results <- matrix(0,ncol=size+1,nrow=input$generations,dimnames=list(generation=1:input$generations,allele.freq=0:size))
    
    results[1,as.character(input$initAlleles)] <- 1
    
    for (g in 2:input$generations) {
      results[g,] <- results[g-1,] %*% m.binom
    }
    results
  }
  )
  
  output$resultsPlot <- renderPlot({
    print(persp(results(),theta=input$theta,phi=input$phi,xlab="generation",ylab="allele count",zlab="proportion",col="skyblue"))
  },height=600,width=600)
  
  output$barPlot <- renderPlot({
    plotData <- melt(results,id.vars=row.names)
    pl <- ggplot(plotData,aes(x=allele.freq,y=value))
    pl <- pl + ylab("proportion") + xlab("number of alleles")
    pl <- pl + geom_bar(stat="identity") + facet_wrap(~ generation,ncol=5)
    print(pl)
  },height=800,width=800)
    
  
  output$resultsTable <- renderTable({
    round(results(),3)
  })
  
})