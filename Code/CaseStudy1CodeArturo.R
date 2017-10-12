
## Load Data ##
getwd()
setwd("C:/Users/acasi/Downloads")
BeersData <- read.csv("Beers.csv")
BreweriesData <- read.csv("Breweries.csv")

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

# Summary Statistics #
AllBeer$State[which.max(AllBeer$ABV)]
AllBeer$State[which.max(AllBeer$IBU)]

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
library(xlsx)
library(rJava)
stategeo<-read.xlsx("state-geocodes-v2016.xls", sheetIndex=1, sheetName="CODES14", startRow=6, header=TRUE)
allgeo<-read.xlsx("all-geocodes-v2016.xlsx", sheetIndex=1, sheetName=NULL, startRow=5, header=TRUE)

stategeo<-read.csv("state-geocodes-v2016.csv", header=TRUE)
allgeo<-read.csv("all-geocodes-v2016.csv", header=TRUE)

tail(stategeo)
tail(allgeo)

