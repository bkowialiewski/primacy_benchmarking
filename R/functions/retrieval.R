retrieval <- function(S, Free, M) {
  
  # iterate over number of items
  for (i in 1:S$n_items) {
    
    # build noise
    noise <- rnorm(S$n_items, 0, Free$sigma)
    
    # add it to activation and apply response suppression
    activation <- (M$gradient[i,] + noise) * M$r
    
    # select most activated item
    selected <- which.max(activation)
    
    # track recalled items
    M$r[selected] <- 0
    
    if (selected == i) {
      M$score[i] <- M$score[i] + 1
    }
    
  }
  
  return(M)
  
}