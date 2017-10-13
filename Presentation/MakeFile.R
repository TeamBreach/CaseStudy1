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

## Add region/division ##
library(datasets)
state.geo=data.frame(state.abb, state.region, state.division)
levels(state.geo$state.abb)=c(levels(state.geo$state.abb), "DC")
names(state.geo)[1]='State'
state.geo[51, ] = c('DC','South', 'South Atlantic')

#Final Data#
AllBeerReg<-merge(x=AllBeer, y=state.geo, by.x="State")
str(AllBeerReg)

# For Plotting
library(lattice)
library(ggplot2)
library(ggmap)

# For analysis
library("fiftystater")
