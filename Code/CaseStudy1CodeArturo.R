
## Load Data ##
getwd()
#setwd("C:/Users/acasi/Downloads")
BeersData <- read.csv("C:/Users/acasi/Downloads/Beers.csv")
BreweriesData <- read.csv("C:/Users/acasi/Downloads/Breweries.csv")

str(BeersData)
str(BreweriesData)

## Prepare for merging ##
names(BeersData)
names(BeersData)[5] = "Brew_ID"
names(BeersData)[1] = "Beer.name"
names(BreweriesData)[2] = "Brewery.name"


## Merge Data ##
AllBeer <- merge(BeersData, BreweriesData, by="Brew_ID")
str(AllBeer)

## Print first and last ##
head(AllBeer, 6)
tail(AllBeer, 6)

## Check for missing values ##
apply(apply(AllBeer, 2, is.na), 2, sum)

t=sapply(AllBeer, function(y) sum(length(which(is.na(y)))))
summary(t)


## Double Check ##
AllBeer[is.na(AllBeer$ABV), ]
## Look at balnk Strings ##
sum(AllBeer$Style == "")
sum(AllBeer$Brew_ID == "")
sum(AllBeer$Beer.name == "")
sum(AllBeer$Beer_ID == "")
sum(AllBeer$Ounces == "")
sum(AllBeer$Brewery.name == "")
sum(AllBeer$City == "")
sum(AllBeer$State == "")
sum(AllBeer$ABV == "", na.rm = TRUE)
sum(AllBeer$IBU == "", na.rm = TRUE)
apply(apply(AllBeer, c(1, 2), length), 2, min)
apply(AllBeer, 2, function(y) sum(y == ""))

# Summary Statistics #
AllBeer$State[which.max(AllBeer$ABV)]
AllBeer$State[which.max(AllBeer$IBU)]

o1<-AllBeer[order(AllBeer$ABV, decreasing = TRUE),]
o2<-AllBeer[order(AllBeer$IBU, decreasing = TRUE),]
o1[1:5,]
o2[1:5,]

summary(AllBeer$ABV)
str(AllBeer$ABV)

#sapply(AllBeer[,c(4,5,7)], mean, na.rm=TRUE)
#sapply(AllBeer[,c(4,5,7)], median, na.rm=TRUE)
#test[1]

#library(psych)
#describeBy(AllBeer, group = "State")

##
m=data.frame(aggregate(ABV~State, data=AllBeer, median))
n=data.frame(aggregate(IBU~State, data=AllBeer, median))
str(n)

par(mfcol=(c(1,2)), las=1)
barplot(m$ABV, names.arg = m$State, horiz = TRUE)
barplot(n$IBU, names.arg = n$State, horiz = TRUE)


median_beer<-aggregate(AllBeer[, 4:5], list(AllBeer$State), median, na.rm=TRUE)
median_beer[is.na(median_beer)] <- 0
median_beer<-?rename(median_beer, c('Group.1'='State'))
barplot(median_beer$ABV, width=3, names.arg = median_beer$State, las=2)

tABV=tapply(AllBeer$ABV, AllBeer$State, max)
tIBU=tapply(AllBeer$IBU, AllBeer$State, max, na.rm = TRUE)
tABV
tIBU


# ABV vs IBU #
library(lattice)
library(ggplot2)
plot(ABV~IBU, data=AllBeer)
abline(lm(ABV~IBU, data=AllBeer))


ggplot(dat=na.omit(AllBeer), aes(x=IBU, y=ABV)) + 
  geom_point(shape=16) + 
  geom_smooth(method=lm) + theme_minimal() 
#+
#scale_color_gradient(low = "#00000000", high = "#0091ff")


## Extra Data / Info
#library(xlsx)
#library(rJava)
#stategeo<-read.xlsx("state-geocodes-v2016.xls", sheetIndex=1, sheetName="CODES14", startRow=6, header=TRUE)
#allgeo<-read.xlsx("all-geocodes-v2016.xlsx", sheetIndex=1, sheetName=NULL, startRow=5, header=TRUE)

stategeo<-read.csv("C:/Users/acasi/Downloads/state-geocodes-v2016.csv", header=TRUE)
allgeo<-read.csv("C:/Users/acasi/Downloads/all-geocodes-v2016.csv", header=TRUE)

tail(stategeo)
tail(allgeo)

str(AllBeer$State)
sum(AllBeer$State == 24)

states=stategeo[stategeo$State..FIPS. != 0, -3]
names(states)[3] = "State.Name"
#Name=State
divisions=stategeo[stategeo$State..FIPS. == 0 & stategeo$Division != 0, c(2,4)]
names(division)[2] = "Division.Name"
#Name=divisions
regions=stategeo[stategeo$State..FIPS. == 0 & stategeo$Division == 0, c(1,4)]
names(regions)[2] = "Region.Name"
#Name=regions

length(states[,1])

library(datasets)
test=data.frame(state.abb, state.name, state.region, state.division)

state.region
state.abb
state.division

length(sort(unique(AllBeer$State)))

state.dat=merge(x= merge(x=states, y=regions, by.x="Region"), y = divisions, by.x = "Division")
