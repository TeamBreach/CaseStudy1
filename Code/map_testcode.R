library(ggplot2)
library(maps)
library(ggmap)
library(fiftystater)

setwd('C:/Users/kalyn/OneDrive/Git/CaseStudy1')

median_beer<-read.csv("/Data/median_beer.csv", header=TRUE)

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


###################### scrap code

library(plyr)
median_beer2<-median_beer
test<-table(mergeddrunk$Brewery_Name, mergeddrunk$State)
write.csv(test, "testbeer.csv")
count(unique(mergeddrunk$Brewery_Name), by=mergeddrunk$State)

test2<-table(mergeddrunk$Style, mergeddrunk$State)
test2<-data.frame(t(test2))
test2<-rename(test2, c('Var1'='State', 'Var2'='Style'))
try<-aggregate(test2[, 3], list(test2$State), sum, na.rm=TRUE)

####Count Unique Breweries by State####
newbrewery<-mergeddrunk[,8:10]
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))

####Count Beer Style By State#####
cols<-c(4:6, 8, 10)
newstyle<-mergeddrunk[, cols]
newstyle2<-data.frame(table(newstyle$Style, newstyle$State))
newstyle2<-rename(newstyle2, c('Var1'='Style', 'Var2'='State'))
alaska<-subset(newstyle2, "AK" %in% State)

####Return Dataset with Highest Count  for each State as well as Count####

##### State Name Function #####
StateName<-function(df){
  if(df$State=='AL') df$State_Name<-'alabama'
  transform(df, State=='AL', State_Name='alabama')
  df<-transform(df, State=='AK', State_Name='alaska')
  df<-transform(df, State=='AZ', State_Name='arizona')
  df<-transform(df, State=='AR', State_Name='arkansas')
  df<-transform(df, State=='CA', State_Name='california')
  df<-transform(df, State=='CO', State_Name='colorado')
  df<-transform(df, State=='CT', State_Name='connecticut')
  df<-transform(df, State=='DE', State_Name='deleware')
  df<-transform(df, State=='DC', State_Name='district of columbia')
  df<-transform(df, State=='FL', State_Name='florida')
  df<-transform(df, State=='GA', State_Name='georgia')
  df<-transform(df, State=='HI', State_Name='hawaii')
  df<-transform(df, State=='ID', State_Name='idaho')
  df<-transform(df, State=='IL', State_Name='illinois')
  df<-transform(df, State=='IN', State_Name='indiana')
  df<-transform(df, State=='IA', State_Name='iowa')
  df<-transform(df, State=='KS', State_Name='kansas')
  df<-transform(df, State=='KY', State_Name='kentucky')
  df<-transform(df, State=='LA', State_Name='louisiana')
  df<-transform(df, State=='ME', State_Name='maine')
  df<-transform(df, State=='MD', State_Name='maryland')
  df<-transform(df, State=='MA', State_Name='massachusetts')
  df<-transform(df, State=='MI', State_Name='michigan')
  df<-transform(df, State=='MN', State_Name='minnesota')
  df<-transform(df, State=='MS', State_Name='mississippi')
  df<-transform(df, State=='MO', State_Name='missouri')
  df<-transform(df, State=='MT', State_Name='montana')
  df<-transform(df, State=='NE', State_Name='nebraska')
  df<-transform(df, State=='NV', State_Name='nevada')
  df<-transform(df, State=='NH', State_Name='new hampshire')
  df<-transform(df, State=='NJ', State_Name='new jersey')
  df<-transform(df, State=='NM', State_Name='new mexico')
  df<-transform(df, State=='NY', State_Name='new york')
  df<-transform(df, State=='NC', State_Name='north carolina')
  df<-transform(df, State=='ND', State_Name='north dakota')
  df<-transform(df, State=='OH', State_Name='ohio')
  df<-transform(df, State=='OK', State_Name='oklahoma')
  df<-transform(df, State=='OR', State_Name='oregon')
  df<-transform(df, State=='PA', State_Name='pennsylvania')
  df<-transform(df, State=='RI', State_Name='rhode island')
  df<-transform(df, State=='SC', State_Name='south carolina')
  df<-transform(df, State=='SD', State_Name='south dakota')
  df<-transform(df, State=='TN', State_Name='tennessee')
  df<-transform(df, State=='TX', State_Name='texas')
  df<-transform(df, State=='UT', State_Name='utah')
  df<-transform(df, State=='VT', State_Name='vermont')
  df<-transform(df, State=='VA', State_Name='virginia')
  df<-transform(df, State=='WA', State_Name='washington')
  df<-transform(df, State=='WV', State_Name='west virginia')
  df<-transform(df, State=='WI', State_Name='wisconsin')

return(df)
}
  

test<-newbrewery2
test<-rename(test, c('Group.1'='State', 'x'='Freq'))

StateName(test)

test<-transform(test, State_Name= ifelse(State %in% 'AK', 'alaska',
                                         ifelse(State %in% 'AL', 'alabama')))

if(test$State='AL') test$State_Name<-'alabama'