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
names(BeersData)[1] = "Beer_name"
names(BreweriesData)[2] = "Brewery_name"

## Merge Data ##
AllBeer <- merge(BeersData, BreweriesData, by="Brew_ID")
str(AllBeer)

## Check for missing values ##
###Numeric
apply(apply(AllBeer, 2, is.na), 2, sum)
###Character
apply(AllBeer, 2, function(y) sum(y == ""))


## Add region/division ##
library(datasets)
state.geo=data.frame(state.abb, state.region, state.division)

#rename for ease of merge
#length(levels(state.geo$state.abb))
levels(state.geo$state.abb) = c(levels(state.geo$state.abb),"DC")
names(state.geo)[1]='State'
state.geo[51, ] = c('DC','South', 'South Atlantic')

#align levels for merge
levels(state.geo$State)=levels(AllBeer$State)


#sort(unique(AllBeerReg$State))
#sort(unique(AllBeer$State))

#Final Data#
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))
AllBeerReg<-merge(x=AllBeer, y=state.geo, by.x="State", all.x = TRUE)
str(AllBeerReg)

x=AllBeerReg[is.na(AllBeerReg$state.region),]
x
x=AllBeerReg[AllBeerReg$state.region == "",]
x

# For Plotting
library(lattice)
library(ggplot2)
library(ggmap)

# For analysis
library("fiftystater")

# For Beamer/RMD
library(knitr)
#library(rticles)
library(xtable)
