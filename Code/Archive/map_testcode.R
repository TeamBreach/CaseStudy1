# Necessary library calls
library(ggplot2)
library(fiftystater)
library(plyer)


setwd('C:/Users/kalyn/OneDrive/Git/CaseStudy1')

# Calls the StateName function to convert state abbreviations to lowercase state names
median_beer<-StateName(median_beer)

# Start of the call to vreate the median ABV by state map
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

# Start of the call to vreate the median IBU by state map
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

####Count Unique Breweries by State####

#Initializes a new object with State, Brewery Name, and City
newbrewery<-mergeddrunk[,8:10]
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))   #Returns a count of the unique breweries by state
newbrewery2<-rename(newbrewery2, c('Group.1'='State', 'x'='Freq'))    #Renames column names after the aggregate.

#Runs the StateName function to replace abbreviations with state names and then calls tolower to make certain they are lower case
newbrewery2<-StateName(newbrewery2)
newbrewery2$State<-tolower(newbrewery2$State)


# Start of the call to create the median IBU by state map
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

######### Below this comment thar be dragons!  Test code for future development, ho!
####Count Beer Style By State#####
cols<-c(4:6, 8, 10)
newstyle<-mergeddrunk[, cols]
newstyle2<-data.frame(table(newstyle$Style, newstyle$State))
newstyle2<-rename(newstyle2, c('Var1'='Style', 'Var2'='State'))
alaska<-subset(newstyle2, "AK" %in% State)

####Return Dataset with Highest Count  for each State as well as Count####
