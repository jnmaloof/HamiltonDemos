## Markov simulator for genetic drift

#Julin Maloof

#July 24, 2013

size <- 32 # number of chromosomes in population

init.alleles <- 16 # number of alleles in starting population

generations <- 20 # number of generations to run the simulation for

m.binom <- matrix(0,nrow=size+1,ncol=size+1,dimnames=list(from=0:size,to=0:size)) #this will hold the binomial transition probabilities

#now we should be able to fill in the matrix by mutliplying the allele probabilities in the current generation by the binomial probabilities

for (f in 0:size) {
  for (t in 0:size) {
    m.binom[f+1,t+1] <- dbinom(x=t,size=size,prob=f/size)
  }}

m.binom

#now for each generation mutliply the transition matrix by the allele probabilties

results <- matrix(0,ncol=size+1,nrow=generations,dimnames=list(generation=1:generations,allele.freq=0:size))

results[1,as.character(init.alleles)] <- 1

for (g in 2:generations) {
 results[g,] <- results[g-1,] %*% m.binom
}

round(results,3)