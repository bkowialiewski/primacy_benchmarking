require('here')

function_files <- list.files(here('functions'))
for (i in 1:length(function_files)) {
  source(here('functions', function_files[i]))
}

benchmarking <- function() {
  
  nBench <- 1000
  
  elapsed <- rep(0, nBench)
  
  for (epoch in 1:nBench) {
    
    # required to benchmark the model
    start <- Sys.time()
    
    # create structure for fixed parameters
    S <- list(n_sim = 10^4,
              n_items = 6)
    
    # free parameters
    Free <- list(alpha = 10.0,
                 gamma = 0.9,
                 sigma = 0.5,
                 delta = 0.8)
    
    # pre-allocate matrices
    M <- genMatrices(S)
    
    # core function of the model
    M <- core(S, Free, M)
    
    end <- Sys.time()
    elapsed[epoch] <- end-start
    
    print(epoch)
    
  }
  
  write.table(elapsed * 1000, 'results/output.txt', row.names = FALSE, col.names = FALSE)
  
}

benchmarking()