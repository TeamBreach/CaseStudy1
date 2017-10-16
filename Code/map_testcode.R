library(ggplot2)
library(maps)
library(ggmap)
library(fiftystater)

setwd('C:/Users/kalyn/OneDrive/Git/CaseStudy1')

#median_beer<-read.csv("/Data/median_beer.csv", header=TRUE)
median_beer<-StateName(median_beer)

abv_map<- ggplot(median_beer, aes(map_id=State))+
    geom_map(aes(fill=ABV), map=fifty_states)+
    expand_limits(x=fifty_states$long, y=fifty_states$lat)+
    coord_map()+
    scale_x_continuous(breaks=NULL)+
    scale_y_continuous(breaks=NULL)+
    labs(x="",y="")+
    ggtitle("Median Alcohol By Volume (ABV) By State") +
    scale_fill_gradient(low = "lightgoldenrod1", high = "lightgoldenrod4", space = "Lab",na.value = "grey70", guide = "colourbar")+
   theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position="bottom",panel.background=element_blank())+
    borders("state")+
    fifty_states_inset_boxes()

abv_map

ibu_map<- ggplot(median_beer, aes(map_id=State))+
    geom_map(aes(fill=IBU), map=fifty_states)+
    expand_limits(x=fifty_states$long, y=fifty_states$lat)+
    coord_map()+
    scale_x_continuous(breaks=NULL)+
    scale_y_continuous(breaks=NULL)+
    labs(x="",y="")+
    ggtitle("Median International Bitter Units (IBU) By State") + 
    scale_fill_gradient(low = "lightcyan2", high = "lightblue4", space = "Lab",na.value = "gray70", guide = "colourbar")+
    theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position="bottom",panel.background=element_blank())+
    borders("state")+
    fifty_states_inset_boxes()


ibu_map


####Count Unique Breweries by State####
newbrewery<-mergeddrunk[,8:10]
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))
newbrewery2<-rename(newbrewery2, c('Group.1'='State', 'x'='Freq'))

newbrewery2<-StateName(newbrewery2)
newbrewery2$State<-tolower(newbrewery2$State)

brew_map<- ggplot(newbrewery2, aes(map_id=State))+
  geom_map(aes(fill=Freq), map=fifty_states)+
  expand_limits(x=fifty_states$long, y=fifty_states$lat)+
  coord_map()+
  scale_x_continuous(breaks=NULL)+
  scale_y_continuous(breaks=NULL)+
  labs(x="",y="")+
  ggtitle("Median International Bitter Units (IBU) By State") + 
  scale_fill_gradient(low = "lightcyan2", high = "lightblue4", space = "Lab",na.value = "gray70", guide = "colourbar")+
  theme(plot.title = element_text(lineheight=.8, face="bold"),legend.position="bottom",panel.background=element_blank())+
  borders("state")+
  fifty_states_inset_boxes()

brew_map

##### State Name Function #####
StateName<-function(test){

  i <- sapply(test, is.factor)
  test[i] <- lapply(test[i], as.character)
  test$State<-sapply(test$State, trimws, which="both")
  
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

return(test)
}

####Count Beer Style By State#####
cols<-c(4:6, 8, 10)
newstyle<-mergeddrunk[, cols]
newstyle2<-data.frame(table(newstyle$Style, newstyle$State))
newstyle2<-rename(newstyle2, c('Var1'='Style', 'Var2'='State'))
alaska<-subset(newstyle2, "AK" %in% State)

####Return Dataset with Highest Count  for each State as well as Count####