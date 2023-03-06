rm(list = ls())

require('here')
require('ggplot2')

# list of languages
languages <- c('Rust', 'Julia', 'MATLAB', 'R')
fname <- 'results/output.txt'

# number of observations / languages
n <- 1000

# get data from folders here
data <- data.frame(language = NULL, values = NULL)
for (i in 1:length(languages)) {
  
  values <- unlist(read.delim(here(languages[i], fname), sep = '', header = FALSE))
  data <- rbind(data, data.frame(language = languages[i], values = values))
  
}

# get summary statistics
agg <- aggregate(values~language, data, mean)
se <- aggregate(values~language, data, sd)$values/sqrt(n)

# confidence interval is ~standard deviation times 1.96
agg$CI <- se * 1.96

# agg$values <- agg$values / agg$values[agg$language == "Rust"]

# redefine the levels - important when plotting using ggplot2
levels(agg$language) <- languages

# do the actual plotting
g <- ggplot(agg, aes(x = language, y = values))
g <- g + geom_point(aes(colour = language), size = 2.5)
g <- g + geom_errorbar(aes(ymin = values - CI, ymax = values + CI, colour = language), width = 0.2)
g <- g + scale_x_discrete(limits = languages)
g <- g + scale_y_continuous(limits = c(0, max(agg$CI + agg$values)))
g <- g + ylab('Running time (in milliseconds)')
g <- g + xlab('Programming languages')
g <- g + theme(legend.position = "none")
g

fname <- here('plot', 'comparison.svg')
ggsave(fname, g, width = 4, height = 3.5)
