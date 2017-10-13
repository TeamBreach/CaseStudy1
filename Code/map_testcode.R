library(ggplot2)
library(maps)
library(ggmap)
library(fiftystater)

median_beer<-read.csv("median_beer.csv", header=TRUE)

abv_map<- ggplot(median_beer, aes(map_id=State_Name))+
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

ibu_map<- ggplot(median_beer, aes(map_id=State_Name))+
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


######################test code below

library(plyr)
median_beer2<-median_beer
test<-table(mergeddrunk$Brewery_Name, mergeddrunk$State)
write.csv(test, "testbeer.csv")
count(unique(mergeddrunk$Brewery_Name), by=mergeddrunk$State)

test2<-table(mergeddrunk$Style, mergeddrunk$State)
test2<-data.frame(t(test2))
test2<-rename(test2, c('Var1'='State', 'Var2'='Style'))
