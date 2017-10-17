

# Necessary library calls

library(ggplot2)

library(fiftystater)

library(plyr)

library(datasets)

library(maps)

library(mapproj)

#For Markdown presentation

library(knitr)

library(xtable)

library(knitrBootstrap)


#Reading in the raw data on beers and breweries

rawbeers<-read.csv("C:/Users/acasi/Downloads/beers.csv", header=TRUE)

rawbreweries<-read.csv("C:/Users/acasi/Downloads/breweries.csv", header=TRUE)



##### State Name Function #####

StateName<-function(test){
  
  
  
  #Checks to factors, converts them to characters, and then trims any white space before or after the characters
  
  i <- sapply(test, is.factor)
  
  test[i] <- lapply(test[i], as.character)
  
  test$State<-sapply(test$State, trimws, which="both")
  
  
  
  #Replaces each state code with the corresponding state name.  Note that the df must have a column named State that contains the state codes for this code to work.
  
  test$State[test$State =="AL"]<-"alabama"
  
  test$State[test$State =="AK"]<-"alaska"
  
  test$State[test$State =="AZ"]<-"arizona"
  
  test$State[test$State =="AR"]<-"arkansas"
  
  test$State[test$State =="CA"]<-"california"
  
  test$State[test$State =="CO"]<-"colorado"
  
  test$State[test$State =="CT"]<-"connecticut"
  
  test$State[test$State =="DC"]<-"district of columbia"
  
  test$State[test$State =="DE"]<-"deleware"
  
  test$State[test$State =="FL"]<-"florida"
  
  test$State[test$State =="GA"]<-"georgia"
  
  test$State[test$State =="HI"]<-"hawaii"
  
  test$State[test$State =="ID"]<-"idaho"
  
  test$State[test$State =="IL"]<-"illinois"
  
  test$State[test$State =="IN"]<-"indiana"
  
  test$State[test$State =="IA"]<-"iowa"
  
  test$State[test$State =="KS"]<-"kansas"
  
  test$State[test$State =="KY"]<-"kentucky"
  
  test$State[test$State =="LA"]<-"louisiana"
  
  test$State[test$State =="ME"]<-"maine"
  
  test$State[test$State =="MD"]<-"maryland"
  
  test$State[test$State =="MA"]<-"massachusetts"
  
  test$State[test$State =="MI"]<-"michigan"
  
  test$State[test$State =="MN"]<-"minnesota"
  
  test$State[test$State =="MS"]<-"mississippi"
  
  test$State[test$State =="MO"]<-"missouri"
  
  test$State[test$State =="MT"]<-"montana"
  
  test$State[test$State =="NE"]<-"nebraska"
  
  test$State[test$State =="NV"]<-"nevada"
  
  test$State[test$State =="NH"]<-"new hampshire"
  
  test$State[test$State =="NJ"]<-"new jersey"
  
  test$State[test$State =="NM"]<-"new mexico"
  
  test$State[test$State =="NY"]<-"new york"
  
  test$State[test$State =="NC"]<-"north carolina"
  
  test$State[test$State =="ND"]<-"north dakota"
  
  test$State[test$State =="OH"]<-"ohio"
  
  test$State[test$State =="OK"]<-"oklahoma"
  
  test$State[test$State =="OR"]<-"oregon"
  
  test$State[test$State =="PA"]<-"pennsylvania"
  
  test$State[test$State =="RI"]<-"rhode island"
  
  test$State[test$State =="SC"]<-"south carolina"
  
  test$State[test$State =="SD"]<-"south dakota"
  
  test$State[test$State =="TN"]<-"tennessee"
  
  test$State[test$State =="TX"]<-"texas"
  
  test$State[test$State =="UT"]<-"utah"
  
  test$State[test$State =="VT"]<-"vermont"
  
  test$State[test$State =="VA"]<-"virginia"
  
  test$State[test$State =="WA"]<-"washington"
  
  test$State[test$State =="WV"]<-"west virginia"
  
  test$State[test$State =="WI"]<-"wisconsin"
  
  test$State[test$State =="WY"]<-"wyoming"
  
  
  
  #returns the new dataframe with the state names.
  
  return(test)
  
}





#####################################################################

#Question 1. How many breweries are in each state

#####################################################################

count_brew<-data.frame(table(rawbreweries$State))  #counts breweries per state



#####################################################################

#Question 2. Merge Beer & Brewery data.  Print the first 6 and the last 6 observations to check merge

#####################################################################


## Prepare for merging ##

names(rawbeers)

names(rawbeers)[5] = "Brew_ID"

names(rawbeers)[1] = "Beer_name"

names(rawbreweries)[2] = "Brewery_Name"


## Merge Data ##
AllBeer <- merge(rawbeers, rawbreweries, by="Brew_ID")
str(AllBeer)


#data checks

head(AllBeer, 6)

tail(AllBeer, 6)




## Add region/division ##

state.geo=data.frame(state.abb, state.region, state.division)

#rename for ease of merge
#length(levels(state.geo$state.abb))
levels(state.geo$state.abb) = c(levels(state.geo$state.abb),"DC")
names(state.geo)[1]='State'
state.geo[51, ] = c('DC','South', 'South Atlantic')

#align levels for merge
levels(state.geo$state.abb)=levels(AllBeer$State)


#Final Data#
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))
AllBeerReg<-merge(x=AllBeer, y=state.geo, by.x="State", all.x = TRUE)
str(AllBeerReg)
apply(AllBeerReg, 2, function(y) sum(y == ""))
apply(apply(AllBeerReg, 2, is.na), 2, sum)

#Breweries by state on final data#

sapply(tapply(AllBeerReg$Brew_ID, AllBeerReg$State, unique), length)


#####################################################################

##############################Question 3. Get NA's in each column

#####################################################################

#3.a.
#Missing values for original/standard merge

naAllBeer <-sapply(AllBeer, function(y) sum(length(which(is.na(y)))))  #Sums the NAs in each column to serach for data that needs cleaning
naAllBeer

## Double Check ##

AllBeer[is.na(AllBeer$ABV), ]  #Spot check missing value fields

nastrings<-apply(AllBeer, 2, function(y) sum(y == ""))   #Check for blanks

nastrings


#3.a.
#Missing values for data with region/division

naAllBeerReg <-sapply(AllBeerReg, function(y) sum(length(which(is.na(y)))))  #Sums the NAs in each column to serach for data that needs cleaning
naAllBeerReg

## Double Check ##
AllBeerReg[is.na(AllBeerReg$ABV), ]   #Spot check missing value fields

nastrings<-apply(AllBeerReg, 2, function(y) sum(y == ""))   #Check for blanks
nastrings


#####################################################################

#Question 1a. How many breweries are in each state - The Map

#####################################################################


## Breweries in total ##

length(unique(AllBeerReg$Brew_ID))

####Count Unique Breweries by State####

sapply(tapply(AllBeerReg$Brew_ID, AllBeerReg$State, unique), length) #horizontal table

sapply(tapply(AllBeerReg$Style, AllBeerReg$State, unique), length) #horizontal table for style

## For Maps ##
#Initializes a new object with State, Brewery Name, and City

newbrewery<-AllBeerReg[,c("Brewery_Name", "City", "State")]
str(newbrewery)

newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))   #Returns a count of the unique breweries by state

names(newbrewery2) = c("State", "Freq") #Renames column names after the aggregate.

#Runs the StateName function to replace abbreviations with state names and then calls tolower to make certain they are lower case

newbrewery2<-StateName(newbrewery2)

newbrewery2$State<-tolower(newbrewery2$State)

str(newbrewery2)


# Start of the call to vreate the median IBU by state map

brew_map<- ggplot(newbrewery2, aes(map_id=State))+    #sets the data (newbrewery2) and the primary key (State variable) to link map and data
  
  geom_map(aes(fill=Freq), map=fifty_states)+         #sets the fill value (Freq) that will determine color and the geographic map data
  
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+ #Sets the latitude and longitudinal extents
  
  coord_map() +                        #Sets the base geographic projection (mercator in this case)
  
  scale_x_continuous(breaks=NULL)+
  
  scale_y_continuous(breaks=NULL)+
  
  labs(x = "", y = "") +
  
  ggtitle("Number of Breweries By State") + # Sets the title of the map
  
  scale_fill_gradient(low = "seagreen1", high = "seagreen4", space = "Lab",na.value = "gray70", guide=guide_colourbar(title.position="top", barwidth=10, title="Number of Breweries",  title.hjust=0.5))+     #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.87, .25),legend.direction="horizontal",panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+   #Theme elements such as the border around the map plot, the position of map components like the legend
  
  borders("state")+     #Adds colored state borders
  
  fifty_states_inset_boxes()     #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.



#Plots the map for total number of breweries by state

brew_map




#####################################################################

#Question 4. Compute median ABV and IBU for each state.  Plot a bar chart.

#####################################################################

str(AllBeerReg[,5:6])

median_beer<-aggregate(AllBeerReg[,c("ABV","IBU")], list(AllBeerReg$State), median, na.rm=TRUE)    #Creates a new object which stores the median IBU and ABV per state
names(median_beer)[1]="State"


#barplot of median ABV and IBU per state in one graphic

par(mfrow=(c(2,1)), las=2, mar=c(2,2,1,1))

barplot(median_beer$ABV, names.arg = median_beer$State, cex.names = 0.7, cex.axis = 0.9, main="Median ABV by State", ylab="Alcohol By Volume (ABV)", las=2, col=c("lightgoldenrod2")) #ABV Bar Plot

barplot(median_beer$IBU, names.arg = median_beer$State, cex.names = 0.7, cex.axis = 0.9, main="Median IBU by State", ylab="International Bitterness Units (IBU)", las=2, col=c("lightblue3")) #IBU Bar Plot


# Calls the StateName function to convert state abbreviations to lowercase state names
median_beer2<-median_beer

median_beer2<-StateName(median_beer2)


# Start of the call to create the median ABV by state map

abv_map<- ggplot(median_beer2, aes(map_id=State))+      #sets the data and the primary key to link map and data
  
  geom_map(aes(fill=ABV), map=fifty_states)+                #sets the fill value that will determine color and the geographic map data
  
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+   #Sets the latitude and longitudinal extents
  
  coord_map()+                                              #Sets the base geographic projection (mercator in this case)
  
  scale_x_continuous(breaks=NULL)+                          
  
  scale_y_continuous(breaks=NULL)+                          
  
  labs(x = "", y = "") +
  
  ggtitle("Median Alcohol By Volume (ABV) By State") +      # Sets the title of the map
  
  scale_fill_gradient(low = "lightgoldenrod1", high = "lightgoldenrod4", space = "Lab",na.value = "grey70", guide = guide_colourbar(title.position="top", barwidth=10, title.hjust=0.5))+ #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.875, .27),legend.text=element_text(size=8),legend.direction="horizontal", legend.margin=margin(t = 0, unit='cm'), panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+   #Theme elements such as the border around the map plot, the position of map components like the legend
  
  borders("state")+                                         #Adds colored state borders
  
  fifty_states_inset_boxes()                                #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.



#Plots the ABV map

abv_map



# Start of the call to create the median IBU by state map

ibu_map<- ggplot(median_beer2, aes(map_id=State))+           #sets the data and the primary key to link map and data
  
  geom_map(aes(fill=IBU), map=fifty_states)+              #sets the fill value that will determine color and the geographic map data
  
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+ #Sets the latitude and longitudinal extents
  
  coord_map()+                                            #Sets the base geographic projection (mercator in this case)
  
  scale_x_continuous(breaks=NULL)+
  
  scale_y_continuous(breaks=NULL)+
  
  labs(x = "", y = "") +
  
  ggtitle("Median International Bitter Units (IBU) By State") + # Sets the title of the map
  
  scale_fill_gradient(low = "lightcyan2", high = "lightblue4", space = "Lab",na.value = "gray70", guide = guide_colourbar(title.position="top", barwidth=10, title.hjust=0.5))+ #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.87, .25),legend.direction="horizontal",panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+    #Theme elements such as the border around the map plot, the position of map components like the legend
  
  borders("state")+                #Adds colored state borders
  
  fifty_states_inset_boxes()        #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.



#Plots the IBU map

ibu_map





#####################################################################

#Question 5. Which state has the max alcoholic (ABV) beer?  Which state has the most bitter (IBU) beer?

#####################################################################

AllBeerReg$State[which.max(AllBeerReg$ABV)]  #Returns the state name with the highest ABV value

AllBeerReg$State[which.max(AllBeerReg$IBU)]  #Returns the state name with the highest IBU value

##Top Ten alcoholic beers and highest IBU beers ##
## use order() to index ##

o1<-AllBeerReg[order(AllBeerReg$ABV, decreasing = TRUE),c("State", "Beer_Name","ABV","IBU","Ounces","Brewery_Name", "City")]
o1[1:10,]

o2<-AllBeerReg[order(AllBeerReg$IBU, decreasing = TRUE),c("State", "Beer_Name","ABV","IBU","Ounces","Brewery_Name", "City")]
o2[1:10,]

#####################################################################

#Question 6. Summary Statistics for the ABV variable

#####################################################################

#Summary statistics for the merged data

summary(AllBeerReg)

str(AllBeerReg)

## Summary Statistics of ABV and IBU

summary(AllBeerReg$ABV)

summary(AllBeerReg$IBU)


#####################################################################

#Question 7. Is there a relationship between IBU and ABV?  Draw a scatter plot?

#####################################################################



#Plots the ABV versus IBU to search for a relationship between the two.

plot(ABV~IBU, data=AllBeerReg)

abline(lm(ABV~IBU, data=AllBeerReg))


## ggplot ABV vs IBU
ggplot(dat=na.omit(AllBeerReg), aes(x=IBU, y=ABV)) + 
  geom_point(shape=16) + 
  geom_smooth(method=lm) + theme_minimal() 

 summary(lm(ABV~IBU, data=AllBeerReg))



#####################################################################

#####################################################################

#####################################################################

################Below are additional questions we wanted to ask and find answers for but dropped due to time constraints.

#####################################################################

#####################################################################

#####################################################################

#Question A3:  Most Popular Brewed Style By State

#10 most popular beer styles
##use table to get frequencies and then sort
pop1=sort(table(AllBeerReg$Style))[100:90]
pop1

#str(table(AllBeerReg$State, AllBeerReg$Style ))
#str(table(AllBeerReg$Style, AllBeerReg$State ))


#This gets the most brewed style per State
TTT=table(AllBeerReg[, c("Style", "State")])
TT=apply(TTT, 2, which.max)
# TTT=table(AllBeerReg[, c("State", "Style")] )
# TT=apply(T, 1, which.max)
# str(TTT)
# row.names(TTT)


pop2=data.frame("State" =colnames(TTT),
            "Style" = row.names(TTT)[apply(TTT, 2, which.max)])
pop2




#Question A4:  Most Popular Brewed Style By City

#10 most brew-happy cities
##use table to get frequencies and then sort
length(unique(AllBeerReg$City))
sort(table(AllBeerReg$City))[384:374]


#Same code as before but for cities
TTT=table(AllBeerReg[, c("Style", "City")])
TT=apply(T, 2, which.max)
# TTT=table(AllBeerReg[, c("State", "Style")] )
# TT=apply(T, 1, which.max)
# str(TTT)
# row.names(TTT)


pop3=data.frame("City" =colnames(TTT),
                "Style" = row.names(TTT)[apply(TTT, 2, which.max)])
pop3


#Question A5: ABV By Style





#Question A6: IBU By Style
