library(data.table)
library(magrittr)
library(lubridate)
library(ggplot2)
setwd('~/git/Workout/data/')
data = fread('data', colClasses = c(Date = 'character', Type = 'factor', Rep = 'numeric', Weight = 'numeric'), blank.lines.skip = TRUE)
data$Date = data$Date %>% as_date
data$Month = month(data$Date, label = T)
data$Body[data$Type%in%c('Bench Press', 'Pec Deck')] = 'Upper body'
data$Body[data$Type%in%c('Deadlift', 'Squat')] = 'Lower body'
data$Body = data$Body  %>% factor(levels = c('Upper body', 'Lower body'))

plot = ggplot(data, aes(x = Date, y = Weight, colour = Type, size = Rep)) + 
geom_point(alpha=.5, position=position_dodge(width=(5))) +
scale_y_continuous(limit = c(50, 250), breaks= seq(50, 250, 20))+
facet_grid(Body~Month)
ggsave(filename = '../plot.png', plot = plot)