genMatrices <- function(S) {
  
  # pre-allocate multi-dimensional vectors
  M <- list(gradient = matrix(0, nrow = S$n_items, ncol = S$n_items),
            r = rep(1, S$n_items),
            score = rep(0, S$n_items))
  
  return(M)
  
}