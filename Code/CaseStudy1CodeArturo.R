
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
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))


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
apply(AllBeer, 2, function(y) sum(y == ""))

## Add region/division ##
library(datasets)
state.geo=data.frame(state.abb, state.region, state.division)
#levels(state.geo$state.abb) = levels(AllBeer$State)
#trimws(levels(AllBeer$State), which = c("left"))
levels(state.geo$state.abb)=levels(AllBeer$State)
names(state.geo)[1]='State'
state.geo[51, ] = c(' DC','South', 'South Atlantic')

#Final Data#
AllBeerReg<-merge(x=AllBeer, y=state.geo, by.x="State", by.y = "State", all.x = TRUE)
str(AllBeerReg)
str(AllBeer)
str(state.geo)
apply(AllBeerReg, 2, function(y) sum(y == ""))
apply(apply(AllBeerReg, 2, is.na), 2, sum)

# Summary Statistics #

## Breweries per State ##
data.frame(table(BreweriesData$State))

sapply(tapply(AllBeerReg$Brew_ID, AllBeerReg$State, unique), length)
sapply(tapply(AllBeerReg$Style, AllBeerReg$State, unique), length)

apply(table(AllBeerReg[, c("State", "Brew_ID")]), 1, sum)

##Double CHeck
TT=table(AllBeerReg[, c("State", "Brew_ID")])
TTT=TT != 0
apply(TTT, 1, sum)


##First most alcoholic beers and highest IBU beers
AllBeerReg$State[which.max(AllBeerReg$ABV)]
AllBeerReg$State[which.max(AllBeerReg$IBU)]


##Top Ten alcoholic beers and highest IBU beers ##
## use order() to index ##
o1<-AllBeerReg[order(AllBeerReg$ABV, decreasing = TRUE),c("State", "Beer.name","Beer_ID" ,"ABV","IBU","Ounces","Brewery.name", "City")]
o1[1:10,]
o2<-AllBeerReg[order(AllBeerReg$IBU, decreasing = TRUE),c("State", "Beer.name","Beer_ID" ,"ABV","IBU","Ounces","Brewery.name", "City")]
o2[1:10,]


## Summary Statistics of ABV and IBU
summary(AllBeerReg$ABV)
summary(AllBeerReg$IBU)


## Create median tables for boxplots
m=data.frame(aggregate(ABV~State, data=AllBeerReg, median))
n=data.frame(aggregate(IBU~State, data=AllBeerReg, median))

# par(las=2, mar=c(2,2,1,1))
# barplot(m$ABV, names.arg = m$State, cex.names = 0.7, ylim=c(0.00, 0.08))

par(mfrow=(c(2,1)), las=2, mar=c(2,2,1,1))
barplot(m$ABV, names.arg = m$State, cex.names = 0.7)
barplot(n$IBU, names.arg = n$State, cex.names = 0.7)


median_beer<-aggregate(AllBeerReg[, c("ABV", "IBU")], list(AllBeerReg$State), median, na.rm=TRUE)
median_beer[is.na(median_beer)] <- 0
median_beer<-?rename(median_beer, c('Group.1'='State'))
barplot(median_beer$ABV, width=3, names.arg = median_beer$State, las=2)

par(mfrow=c(1,1))
par(mfrow=c(8,7))
for(i in 1:4){
  barplot(m$ABV[1], names.arg = m$State[1], ylim=c(0,0.10))
}

tABV=tapply(AllBeerReg$ABV, AllBeerReg$State, max)
tIBU=tapply(AllBeerReg$IBU, AllBeerReg$State, max, na.rm = TRUE)
tABV
tIBU


# ABV vs IBU #
library(lattice)
library(ggplot2)
plot(ABV~IBU, data=AllBeerReg)
abline(lm(ABV~IBU, data=AllBeerReg))


ggplot(dat=na.omit(AllBeerReg), aes(x=IBU, y=ABV)) + 
  geom_point(shape=16) + 
  geom_smooth(method=lm) + theme_minimal() 
#+
#scale_color_gradient(low = "#00000000", high = "#0091ff")


p=data.frame(aggregate(ABV~State+state.region, data=AllBeerReg, median))
p[,4]="Median"
names(p)[4]="Stat"
ggplot(p, aes(x=Stat, y=ABV)) +
  geom_bar(stat="identity", fill="steelblue") +
  facet_wrap(~State) + coord_cartesian(ylim=c(.020,.100))

par(mfrow=c(4,1))
for(i in 1:4){
  sub=m[p$state.region==unique(p$state.region)[i],]
  barplot(sub$ABV, names.arg = sub$State, ylim=c(0,0.10))
}


# + annotate(geom="text", x=100, y=0.04, label=test)
#   
#   test=expression(bquote(ABU[i] == IBU[i]%*% .(L$coeff[2]) + .(L$coeff[1])))
#   expression(ABU[i] == IBU[i]%*% .(L$coeff[2]) + .(L$coeff[1]))
#   ?annotate(geom="text", x=100, y=0.04, label=test)
# 
#   plot(ABV~IBU, data=AllBeerReg)
#   abline(lm(ABV~IBU, data=AllBeerReg))
#   L=lm(ABV~IBU, data=AllBeerReg)
#   L$coeff
#   text(50,.02, bquote(ABU[i] == IBU[i]%*% .(L$coeff[2]) + .(L$coeff[1])), pos=4 )

