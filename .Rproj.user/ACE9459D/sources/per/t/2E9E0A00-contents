rm(list = ls())

require('here')
require('ggplot2')

# list of languages
languages <- c('Rust', 'Julia', 'MATLAB', 'R')
fname <- 'results/score.txt'
n_items <- 6

# get data from folders here
data <- data.frame(x = NULL, language = NULL, values = NULL)
for (i in 1:length(languages)) {
  
  scores <- unlist(read.delim(here(languages[i], fname), sep = '', header = FALSE))
  data <- rbind(data, data.frame(x = 1:n_items, language = languages[i], scores = scores))
  
}

# redefine the levels - important when plotting using ggplot2
levels(data$language) <- languages

# do the actual plotting
g <- ggplot(data, aes(x = x, y = scores))
g <- g + geom_point(aes(colour = language), size = 2.5)
g <- g + geom_line(aes(colour = language), size = 1.5)
# g <- g + scale_x_discrete(limits = languages)
g <- g + scale_y_continuous(limits = c(0, 1.0))
g <- g + scale_x_continuous(limits = c(1,n_items), breaks = seq(1,n_items,1))
g <- g + ylab('p(correct)')
g <- g + xlab('Serial position')
g

fname <- here('plot', 'scores.svg')
ggsave(fname, g, width = 4, height = 3.5)
