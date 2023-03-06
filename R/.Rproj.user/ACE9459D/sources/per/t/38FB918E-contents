require('here')

function_files <- list.files(here('functions'))
for (i in 1:length(function_files)) {
  source(here('functions', function_files[i]))
}

main <- function() {
  
  # create structure for fixed parameters
  S <- list(n_sim = 10^5,
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
  
  plot(1:S$n_items, M$score, type = 'b', xlim = c(1, S$n_items), ylim = c(0,1))
  
  write.table(M$score, 'results/score.txt', row.names = FALSE, col.names = FALSE)
  
  
}

main()

