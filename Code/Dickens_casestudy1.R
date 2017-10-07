rawbeers<-read.csv("beers.csv", header=TRUE)
rawbreweries<-read.csv("breweries.csv", header=TRUE)

#Question 1. How many breweries are in each state
count_brew<-data.frame(table(rawbreweries$State))

#Question 2. Merge Beer & Brewery data.  Print the first 6 and the last 6 observations to check merge
library(plyr)
newbeers <- rename(rawbeers,c('Brewery_id'='Brew_ID'))
mergeddrunk<-merge(newbeers,rawbreweries, by='Brew_ID')
mergeddrunk<-rename(mergeddrunk, c('Name.x'='Beer_Name', 'Name.y'='Brewery_Name'))

head(mergeddrunk, 6)
tail(mergeddrunk, 6)

#Question 3. Get NA's in each column
namergeddrunk <-sapply(mergeddrunk, function(y) sum(length(which(is.na(y)))))

#Question 4. Compute median ABV and IBU for each state.  Plot a bar chart.
library("fiftystater")
data("fifty_states")

median_beer<-aggregate(mergeddrunk[, 4:5], list(mergeddrunk$State), median, na.rm=TRUE)
median_beer[is.na(median_beer)] <- 0
median_beer<-rename(median_beer, c('Group.1'='State'))
barplot(median_beer$ABV, width=3, names.arg = median_beer$State, las=2)

#Question 5. Which state has the max alcoholic (ABV) beer?  Which state has the most bitter (IBU) beer?
mergeddrunk$State[which.max(mergeddrunk$ABV)]
mergeddrunk$State[which.max(mergeddrunk$IBU)]

#Question 6. Summary Statistics for the ABV variable
summary(mergeddrunk)
str(mergeddrunk)

#Question 7. Is there a relationship between IBU and ABV?  Draw a scatter plot?
plot(ABV~IBU, data=mergeddrunk)
abline(lm(ABV~IBU, data=mergeddrunk))