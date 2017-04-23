# Import libraries
library(data.table)
library(magrittr)
library(lubridate)
library(ggplot2)
setwd('~/git/Workout/data/')

# Define variables
Upper_Exercise = c('Bench Press', 'Pec Deck')
Lower_Exercise = c('Deadlift', 'Squat')

# Import data
data = fread('data.txt', blank.lines.skip = TRUE,
			 colClasses = c(Date = 'character', 
							Exercise = 'factor', 
							Replicate = 'numeric', 
							Weight = 'numeric'))

# Construct the data table
data[, Uni := paste0(Date, Exercise)]
data[, ID := factor(rowid(Uni))]
data[, Date := data$Date %>% as.Date]
data$Body[data$Exercise %in% Upper_Exercise] = 'Upper body'
data$Body[data$Exercise %in% Lower_Exercise] = 'Lower body'
data$Body = data$Body %>% factor(levels = c('Upper body', 'Lower body'))

# Plotting
plot = ggplot(data, aes(x = Date, y = Weight, colour = Exercise, size = Replicate, group = ID)) + 
	geom_hline(yintercept = 135, colour = 'red', alpha = .5) +
	geom_point(alpha = .5, position = position_dodge(width = (.7))) +
	scale_x_date(limits = c(min(data$Date) - 2, max(data$Date) + 2)) +
	scale_y_continuous(name = 'Weight (lb)', limits = c(50, 250), breaks = seq(50, 250, 20)) +
	theme(axis.title.x = element_blank()) + facet_grid(Body ~ .)
ggsave(filename = '../plot.png', plot = plot) 