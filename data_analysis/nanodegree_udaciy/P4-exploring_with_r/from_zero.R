##############################################################################

### DAY 1

getwd()
##[1] "/nanodegree/project_4"
setwd('/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P4-exploring_with_r')
getwd()
##[1] "/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P4-exploring_with_r"

statesInfo <- read.csv('stateData.csv')

View(statesInfo)

subset(statesInfo, state.region == 1) ## like: where state.region = 1

statesInfo[statesInfo$state.region == 1, ]

##############################################################################

### DAY 2
setwd('/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P4-exploring_with_r/EDA_Course_Materials/EDA_Course_Materials/lesson2')

reddit <- read.csv('reddit.csv')

table(reddit$employment.status)

str(reddit)
levels(reddit$age.range)

install.packages('ggplot2', dependencies = T) 
library(ggplot2) 

age_Range <- reddit$age.range

tst <- c(1:10)

ggplot( data = reddit, x = tst, y = age_Range)

## ver ggplot

head(reddit)

## order data => very important
reddit$age.range <- ordered(reddit$age.range, levels = c('Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65 of Above'))


##############################################################################

### DAY 3

getwd()
setwd("/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P4-exploring_with_r")

install.packages('qplot', dependencies = TRUE) 
install.packages('ggthemes', dependencies = TRUE) 
library(ggthemes) 

library(ggplot2)

list.files()

## reading data
pf <- read.delim('pseudo_facebook.tsv') ## is similar to read.csv('pseudo_facebook.tsv', sep = '\t')
names(pf) ## view column name

qplot(data = pf, x = dob_day, binwidth = 0.5) 
      + (scale_x_continuous(breaks = 1:31)) 
      + facet_wrap(~dob_month, ncol=3)


qplot(data = pf, x = friend_count) 
qplot(data = pf, x = friend_count, xlim = c(0,1000)) 

qplot(data = pf, x = friend_count, binwidth = 25)
      + (scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50)))
      + facet_wrap(~gender)

 
## count by gender
table(pf$gender) 


##############################################################################

### DAY 4

by(pf$friend_count, pf$gender, summary)

## with gplot
ggplot(aes(x = tenure), data = pf) + 
  geom_histogram(binwidth = 30, color = 'black', fill = '#099DD9')

##with qplot
qplot(x = tenure/365, data = pf, binwidth = .25,
      color = I('black'), fill = I('#F79420')) +
      scale_x_continuous(breaks = seq(1, 7, 1), limits = c(0, 7)) +
      xlab('Number of years using Facebook') + 
      ylab('Number of users in sample')

## age histogram
qplot(x = age, data = pf, binwidth = 1,
      color = I('black'), fill = I('#F23512')) +
      xlab('Age of Facebook users') + 
      ylab('Number of users in sample')

## multiples plots in onde graph
install.packages('gridExtra') 
library(gridExtra) 

summary(pf$friend_count)

summary(log10(pf$friend_count +1))

summary(sqrt(pf$friend_count))

## friend_count
qplot(x = friend_count, data = pf, binwidth = 1,
      color = I('black'), fill = I('#F79420'))

## using log10
qplot(x = friend_count, data = pf, binwidth = 1,
      color = I('black'), fill = I('#F79420')) +
      scale_y_log10()

## using sqrt
qplot(x = friend_count, data = pf, binwidth = 1,
      color = I('black'), fill = I('#F79420')) +
      scale_y_sqrt()