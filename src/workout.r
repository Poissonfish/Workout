library(data.table)
library(magrittr)
library(lubridate)
library(ggplot2)
setwd('~/git/Workout/data/')
data = fread('data.txt', colClasses = c(Date = 'character', Exercise = 'factor', Replicate = 'numeric', Weight = 'numeric'), blank.lines.skip = TRUE)
data[, Uni := paste0(Date, Exercise)]
data[, ID := factor(rowid(Uni))]
data[, Date := data$Date %>% as.Date]
data[, Month := month(data$Date, label = T)]
data$Body[data$Exercise%in%c('Bench Press', 'Pec Deck')] = 'Upper body'
data$Body[data$Exercise%in%c('Deadlift', 'Squat')] = 'Lower body'
data$Body = data$Body  %>% factor(levels = c('Upper body', 'Lower body'))

pos = position_dodge(width=(.2))
plot = ggplot(data, aes(x = Date, y = Weight, colour = Exercise, size = Replicate, group = ID)) + 
geom_point(alpha=.5, position=pos) +
scale_x_continuous(limit = c(min(data$Date)-2, max(data$Date)+2))+
scale_y_continuous(limit = c(50, 250), breaks= seq(50, 250, 20))+
facet_grid(Body~Month)
ggsave(filename = '../plot.png', plot = plot) 