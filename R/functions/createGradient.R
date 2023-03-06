createGradient <- function(S, Free, M) {
  
  for (i in 1:S$n_items) {
    
    M$gradient[i,] <- (Free$alpha - (0:(S$n_items-1)) * Free$gamma) * Free$delta^(i-1)
    
  }
  
  return(M)
  
}