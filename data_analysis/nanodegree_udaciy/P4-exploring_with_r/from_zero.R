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
p1 <- qplot(x = friend_count, data = pf)

## using log10
p2 <- qplot(x = friend_count, data = pf) + scale_y_log10()

## using sqrt
p3 <- qplot(x = friend_count, data = pf) + scale_y_sqrt()

grid.arrange(p1,p2,p3,ncol =1)

##############################################################################

### DAY 5

## add a scaling layer

logScale <- qplot(x = log10(friend_count), data = pf)

countScale <- ggplot(aes(x = friend_count), data = pf) +
  geom_histogram() +
  scale_x_log10()

grid.arrange(logScale, countScale, ncol = 2)

## Frequency Polygons (before we had histograms)

qplot( x = friend_count, data = subset(pf, !is.na(gender)),
    binwidth = 10) +
  scale_x_continuous(lim = c(0,1000), breaks = seq(0,1000,50)) +
  facet_wrap(~gender)

qplot( x = friend_count, y = ..count../sum(..count..),
       data = subset(pf, !is.na(gender)),
       xlab = 'Friend Count',
       ylab = 'Proportion of Users with that friend count',
       binwidth = 10, geom = 'freqpoly', color = gender) +
  scale_x_continuous(lim = c(0,1000), breaks = seq(0,1000,50))

aggregate(pf$www_likes, by=list(pf$gender), sum)

qplot(x = www_likes, data = subset(pf, !is.na(gender)),
    geom = 'freqpoly', color = gender) +
    scale_x_continuous() +
    scale_x_log10()

by(pf$www_likes, pf$gender, sum)

## Box Plots
qplot( x = gender, y = friend_count,
       data = subset(pf, !is.na(gender)),
       geom = 'boxplot') +
        coord_cartesian(ylim = c(0,250))

qplot( x = gender, y = friend_count,
       data = subset(pf, !is.na(gender)),
       geom = 'boxplot', ylim = c(0,1000)) +
  scale_y_continuous(limits = c(0,1000))

by(pf$friend_count, pf$gender, summary)

## Getting Logical

summary(pf$mobile_likes)

summary(pf$mobile_likes > 0)

mobile_check_in <- NA
pf$mobile_check_in <- ifelse(pf$mobile_likes > 0, 1, 0)
pf$mobile_check_in <- factor(pf$mobile_check_in)
summary(pf$mobile_check_in)

63947/(35056+63947)

sum(pf$mobile_check_in == 1)/length(pf$mobile_check_in)


##############################################################################

### Practical Exercise

library(ggplot2)
data("diamonds")

?diamonds
summary(diamonds)

is.ordered(diamonds)
as.ordered(diamonds)

## histogram of price
qplot(data = diamonds, x = price)

summary(diamonds$price)

less_than_500 <- (diamonds$price < 500)
summary(less_than_500)

less_than_250 <- (diamonds$price < 250)
summary(less_than_250)

more_than_15000 <- (diamonds$price >= 15000)
summary(more_than_15000)
