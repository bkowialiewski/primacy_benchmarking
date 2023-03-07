rm(list = ls())

require('here')
require('ggplot2')

# list of languages
fname <- 'empirical_data/score.txt'
n_items <- 6

# get data from folders here
scores <- unlist(read.delim(fname, sep = '', header = FALSE))
data <- data.frame(x = 1:n_items, values = scores)

# do the actual plotting
g <- ggplot(data, aes(x = x, y = scores))
g <- g + geom_point(size = 2.5)
g <- g + geom_line(size = 1.5)
# g <- g + scale_x_discrete(limits = languages)
g <- g + scale_y_continuous(limits = c(0, 1.0))
g <- g + scale_x_continuous(limits = c(1,n_items), breaks = seq(1,n_items,1))
g <- g + ylab('p(correct)')
g <- g + xlab('Serial position')
g

fname <- here('plot', 'scores_empirical.svg')
ggsave(fname, g, width = 3, height = 3.5)
