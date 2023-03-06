core <- function(S, Free, M) {
  
  # pre-allocate primacy gradient before launching the simulations
  M <- createGradient(S, Free, M)
  
  # iterating over number of simulations
  for (epoch in 1:S$n_sim) {
    
    # reset response suppression
    M$r <- (M$r * 0.0) + 1
    # retrieval phase
    M <- retrieval(S, Free, M)
    
  }
  
  M$score <- M$score / S$n_sim
  
  return(M)
  
}