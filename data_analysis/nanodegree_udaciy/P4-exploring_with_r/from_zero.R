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

### DAY 2
setwd('/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P4-exploring_with_r/EDA_Course_Materials/EDA_Course_Materials/lesson2')

reddit <- read.csv('reddit.csv')

table(reddit$employment.status)

str(reddit)
levels(reddit$age.range)

install.packages('ggplot2', dependencies = T) 
library(ggplot2) 