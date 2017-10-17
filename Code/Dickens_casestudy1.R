# Necessary library calls
library(ggplot2)
library(fiftystater)
library(plyer)

#Reading in the raw data on beers and breweries
rawbeers<-read.csv("beers.csv", header=TRUE)
rawbreweries<-read.csv("breweries.csv", header=TRUE)

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

####Count Unique Breweries by State####

#Initializes a new object with State, Brewery Name, and City
newbrewery<-mergeddrunk[,8:10]
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))   #Returns a count of the unique breweries by state
newbrewery2<-rename(newbrewery2, c('Group.1'='State', 'x'='Freq'))    #Renames column names after the aggregate.

#Runs the StateName function to replace abbreviations with state names and then calls tolower to make certain they are lower case
newbrewery2<-StateName(newbrewery2)
newbrewery2$State<-tolower(newbrewery2$State)


# Start of the call to vreate the median IBU by state map
brew_map<- ggplot(newbrewery2, aes(map_id=State))+    #sets the data (newbrewery2) and the primary key (State variable) to link map and data
  geom_map(aes(fill=Freq), map=fifty_states)+         #sets the fill value (Freq) that will determine color and the geographic map data
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+ #Sets the latitude and longitudinal extents
  coord_map()+                        #Sets the base geographic projection (mercator in this case)
  scale_x_continuous(breaks=NULL)+
  scale_y_continuous(breaks=NULL)+
  ggtitle("Number of Breweries By State") + # Sets the title of the map
  scale_fill_gradient(low = "seagreen1", high = "seagreen4", space = "Lab",na.value = "gray70", guide = "colourbar")+     #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.87, .25),legend.direction="horizontal",panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+   #Theme elements such as the border around the map plot, the position of map components like the legend
  borders("state")+     #Adds colored state borders
  fifty_states_inset_boxes()     #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.

#Plots the map for total number of breweries by state
brew_map

#####################################################################
#Question 2. Merge Beer & Brewery data.  Print the first 6 and the last 6 observations to check merge
#####################################################################
newbeers <- rename(rawbeers,c('Brewery_id'='Brew_ID')) #Renames column in raw data so a primary key match can be made
mergeddrunk<-merge(newbeers,rawbreweries, by='Brew_ID')  # merge tables based on the renamed Brew_ID field above
mergeddrunk<-rename(mergeddrunk, c('Name.x'='Beer_Name', 'Name.y'='Brewery_Name')) #renames columns affected by merge

#data checks
head(mergeddrunk, 6)
tail(mergeddrunk, 6)

#####################################################################
##############################Question 3. Get NA's in each column
#####################################################################
namergeddrunk <-sapply(mergeddrunk, function(y) sum(length(which(is.na(y)))))  #Sums the NAs in each column to serach for data that needs cleaning

#####################################################################
#Question 4. Compute median ABV and IBU for each state.  Plot a bar chart.
#####################################################################
median_beer<-aggregate(mergeddrunk[, 4:5], list(mergeddrunk$State), median, na.rm=TRUE)    #Creates a new object which stores the median IBU and ABV per state
median_beer[is.na(median_beer)] <- 0 #Replaces NA values with zeroes
median_beer<-rename(median_beer, c('Group.1'='State'))  #Column rename from after the aggregation
barplot(median_beer$ABV, width=3, names.arg = median_beer$State, las=2)  #barplot of median ABV and IBU per state in one chart

# Calls the StateName function to convert state abbreviations to lowercase state names
median_beer<-StateName(median_beer)

# Start of the call to create the median ABV by state map
abv_map<- ggplot(median_beer, aes(map_id=State_Name))+      #sets the data and the primary key to link map and data
  geom_map(aes(fill=ABV), map=fifty_states)+                #sets the fill value that will determine color and the geographic map data
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+   #Sets the latitude and longitudinal extents
  coord_map()+                                              #Sets the base geographic projection (mercator in this case)
  scale_x_continuous(breaks=NULL)+                          
  scale_y_continuous(breaks=NULL)+                          
  ggtitle("Median Alcohol By Volume (ABV) By State") +      # Sets the title of the map
  scale_fill_gradient(low = "lightgoldenrod1", high = "lightgoldenrod4", space = "Lab",na.value = "grey70", guide = guide_colourbar(barwidth=8.4))+ #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.865, .27),legend.text=element_text(size=8),legend.direction="horizontal", legend.margin=margin(t = 0, unit='cm'), panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+   #Theme elements such as the border around the map plot, the position of map components like the legend
  borders("state")+                                         #Adds colored state borders
  fifty_states_inset_boxes()                                #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.

#Plots the ABV map
abv_map

# Start of the call to create the median IBU by state map
ibu_map<- ggplot(median_beer, aes(map_id=State))+           #sets the data and the primary key to link map and data
  geom_map(aes(fill=IBU), map=fifty_states)+              #sets the fill value that will determine color and the geographic map data
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+ #Sets the latitude and longitudinal extents
  coord_map()+                                            #Sets the base geographic projection (mercator in this case)
  scale_x_continuous(breaks=NULL)+
  scale_y_continuous(breaks=NULL)+
  ggtitle("Median International Bitter Units (IBU) By State") + # Sets the title of the map
  scale_fill_gradient(low = "lightcyan2", high = "lightblue4", space = "Lab",na.value = "gray70", guide = "colourbar")+ #contols legend elements such as color gradiant, colors for NA values, and the size of the legend bar
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position=c(.87, .25),legend.direction="horizontal",panel.background=element_blank(), panel.border=element_rect(colour="Grey50", fill=NA, size=2))+    #Theme elements such as the border around the map plot, the position of map components like the legend
  borders("state")+                #Adds colored state borders
  fifty_states_inset_boxes()        #Creates the insert boxes around Alaska and Hawaii so people don't mistake them for Mexican states or other Central American countries.

#Plots the IBU map
ibu_map


#####################################################################
#Question 5. Which state has the max alcoholic (ABV) beer?  Which state has the most bitter (IBU) beer?
#####################################################################
mergeddrunk$State[which.max(mergeddrunk$ABV)]  #Returns the state name with the highest ABV value
mergeddrunk$State[which.max(mergeddrunk$IBU)]  #Returns the state name with the highest IBU value

#####################################################################
#Question 6. Summary Statistics for the ABV variable
#####################################################################
#Summary statistics for the merged data
summary(mergeddrunk)
str(mergeddrunk)

#####################################################################
#Question 7. Is there a relationship between IBU and ABV?  Draw a scatter plot?
#####################################################################

#Plots the ABV versus IBU to search for a relationship between the two.
plot(ABV~IBU, data=mergeddrunk)
abline(lm(ABV~IBU, data=mergeddrunk))

#####################################################################
#####################################################################
#####################################################################
################Below are additional questions we wanted to ask and find answers for but dropped due to time constraints.
#####################################################################
#####################################################################
#####################################################################
#Question A3:  Most Popular Style By State

#Question A4:  Most Popular Style By City

#Question A5: ABV By Style


#Question A6: IBU By Style