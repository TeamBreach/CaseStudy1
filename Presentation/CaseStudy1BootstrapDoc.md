# Craft-Cans Case Study
Arturo Casillas & Kevin Dickens  
October 6, 2017  

# Introduction
In recent years the craft brewery movement has exploded across the United States.  New breweries open every month across the nation and they come in many shapes, sizes, and forms from the microbrewery that primarily focuses on brewing beer to bars known as brewpubs who craft their own beer.  The products that these establishments offer vary in many ways from packaging (cans versus bottles), to alcohol content, to style and bitterness.  At the end of the day, they all manufacture beer.  Of particular interest to this study are the relationships of canned craft beer breweries and the common beer characteristics.  Do these characteristics show any relationships spatially or statistically?  This study hopes to answer that basic question and provide a foundation for future research on the topic.

Of particular interest to the researchers requesting the analysis and those involved in the study are the spatial relationships and distributions of the canned craft beer movement.  This study will look at how the breweries are distributed across the country and look at the spatial distributions of other beer characteristics to better understand trends and popularity of various beer styles.  The spatial interpretation of data will inform readers of hot spots of craft brewery activity.

This study will also perform basic statistical analysis to better understand and interpret the both the spatial data and the underlying canned craft beer data as well.  The findings will inform readers on the distributions of the data and allow them to look at the included maps to determine which states lie above or below median values as well as determine underlying relationships between such characteristics as alcohol by volume and international bitterness units.

Fundamentally, this study will seek to answer the following questions:
* How many breweries are in each state?
* What is the median ABV and IBU for each state?
* What is the spatial distribution of the data of interest?
* Are there any statistical or spatial relationships between the variables presented in the data?

## Abstract
This study seeks to evaluate the distribution of beer and certain beer characteristics across the United States and answer questions important to the relationships between those characteristics and the spatial distribution.  The goal is to show the distribution of breweries across the united states, discuss correlation between the primary beer characteristics of ABV and IBU, and begin to explore the spatial relationships between breweries and beer characteristics.

## Scope
The scope of this analytical research is limited to the data originally provided by the requestor.  As such the scope of the data pertains to U.S. domestic craft breweries that produce a canned beer product no later than 2015.  It is unclear if this data contains all craft breweries that create a brewed product, or only a sample.  The scope is further limited to only the 50 States and the District of Columbia.  No U.S. territories are included in the underlying data.  



# Data
## About the Data

### Source

The tables contain a list of 2410 US craft beers and 510 US breweries. The beer data corresponds to craft beers available in cans and lists the beer ID number, the size of the can in ounces, style of beer, percent alcohol per volume (ABV), and international bitterness units (IBU) as well as the beer name and brewery ID. The Breweries data lists breweries by location of state and city along with a unique ID. This data was traced to CraftCans.com and further traced to the Brewers Association (BA). A more expansive data set is available to Brewers Association members. 

To prepare the data for analysis, variable names are altered for clarity and to minimize merging issues. The beers and breweries are linked by a unique numeric ID (Brew_ID), so no assumptions or algorithm was needed to combine the tables. 

-View the original data. Expand below to see details.


```r
str(rawbeers)
```

```
## 'data.frame':	2410 obs. of  7 variables:
##  $ Name      : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 1638 577 1705 1842 1819 268 1160 758 1093 486 ...
##  $ Beer_ID   : int  1436 2265 2264 2263 2262 2261 2260 2259 2258 2131 ...
##  $ ABV       : num  0.05 0.066 0.071 0.09 0.075 0.077 0.045 0.065 0.055 0.086 ...
##  $ IBU       : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Brewery_id: int  409 178 178 178 178 178 178 178 178 178 ...
##  $ Style     : Factor w/ 100 levels "","Abbey Single Ale",..: 19 18 16 12 16 80 18 22 18 12 ...
##  $ Ounces    : num  12 12 12 12 12 12 12 12 12 12 ...
```

```r
str(rawbreweries)
```

```
## 'data.frame':	558 obs. of  4 variables:
##  $ Brew_ID: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Name   : Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 12 266 319 201 136 227 477 59 491 ...
##  $ City   : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 200 122 299 300 62 91 48 152 136 ...
##  $ State  : Factor w/ 51 levels " AK"," AL"," AR",..: 24 18 20 5 5 41 6 23 23 23 ...
```

-Prepare for merging. Expand below to see details.


```r
## Prepare for merging ##

names(rawbeers)[5] = "Brew_ID"  #Rename 'Brewery_id' to ease merging

names(rawbeers)[1] = "Beer_Name" #Rename 'Name' to 'Beer_Name' to avoid confusion with brewery name or state

names(rawbreweries)[2] = "Brewery_Name"  #Rename 'Name' to 'Brewery_Name' avoid confusion and ease merging
```

-Merged to create a single table, details below.


```r
## Merge Data ##

AllBeer <- merge(rawbeers, rawbreweries, by="Brew_ID")

str(AllBeer)
```

```
## 'data.frame':	2410 obs. of  10 variables:
##  $ Brew_ID     : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ Beer_Name   : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 802 1258 2185 1640 1926 1525 458 1218 43 71 ...
##  $ Beer_ID     : int  2692 2691 2690 2689 2688 2687 2686 2685 2684 2683 ...
##  $ ABV         : num  0.045 0.049 0.048 0.06 0.06 0.056 0.08 0.125 0.077 0.042 ...
##  $ IBU         : int  50 26 19 38 25 47 68 80 25 42 ...
##  $ Style       : Factor w/ 100 levels "","Abbey Single Ale",..: 16 77 48 83 22 57 12 46 77 18 ...
##  $ Ounces      : num  16 16 16 16 16 16 16 16 16 16 ...
##  $ Brewery_Name: Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 355 355 355 355 355 12 12 12 12 ...
##  $ City        : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 228 228 228 228 228 200 200 200 200 ...
##  $ State       : Factor w/ 51 levels " AK"," AL"," AR",..: 24 24 24 24 24 24 18 18 18 18 ...
```

```r
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))  #Trim the leadig spaces from state abbreviation
```

-Expand below to see the first 6 rows and perform a spot check for integrity (raw)

```r
#kable(head(AllBeer, 6), row.names = FALSE)
head(AllBeer, 6)
```

```
##   Brew_ID     Beer_Name Beer_ID   ABV IBU
## 1       1  Get Together    2692 0.045  50
## 2       1 Maggie's Leap    2691 0.049  26
## 3       1    Wall's End    2690 0.048  19
## 4       1       Pumpion    2689 0.060  38
## 5       1    Stronghold    2688 0.060  25
## 6       1   Parapet ESB    2687 0.056  47
##                                 Style Ounces       Brewery_Name
## 1                        American IPA     16 NorthGate Brewing 
## 2                  Milk / Sweet Stout     16 NorthGate Brewing 
## 3                   English Brown Ale     16 NorthGate Brewing 
## 4                         Pumpkin Ale     16 NorthGate Brewing 
## 5                     American Porter     16 NorthGate Brewing 
## 6 Extra Special / Strong Bitter (ESB)     16 NorthGate Brewing 
##          City State
## 1 Minneapolis    MN
## 2 Minneapolis    MN
## 3 Minneapolis    MN
## 4 Minneapolis    MN
## 5 Minneapolis    MN
## 6 Minneapolis    MN
```

-Also expand below to see the last 6 rows and perform a spot check for integrity (pander)

```r
panderOptions('table.split.table', 100)
panderOptions('table.continues', '...')
pander(tail(AllBeer, 6), row.names = FALSE)
```


------------------------------------------------------------------------------------------------
 Brew_ID           Beer_Name           Beer_ID    ABV    IBU            Style            Ounces 
--------- --------------------------- --------- ------- ----- ------------------------- --------
   556           Pilsner Ukiah           98      0.055   NA        German Pilsener         12   

   557     Heinnieweisse Weissebier      52      0.049   NA          Hefeweizen            12   

   557          Snapperhead IPA          51      0.068   NA         American IPA           12   

   557         Moo Thunder Stout         50      0.049   NA      Milk / Sweet Stout        12   

   557         Porkslap Pale Ale         49      0.043   NA    American Pale Ale (APA)     12   

   558     Urban Wilderness Pale Ale     30      0.049   NA       English Pale Ale         12   
------------------------------------------------------------------------------------------------

Table: ...

 
-------------------------------------------------------
         Brewery_Name                City        State 
------------------------------- --------------- -------
     Ukiah Brewing Company           Ukiah        CA   

    Butternuts Beer and Ale      Garrattsville    NY   

    Butternuts Beer and Ale      Garrattsville    NY   

    Butternuts Beer and Ale      Garrattsville    NY   

    Butternuts Beer and Ale      Garrattsville    NY   

 Sleeping Lady Brewing Company     Anchorage      AK   
-------------------------------------------------------

### Data Integrity

The data were examined for missing values and nonsense entries through formal methods in addition to spot checks. In summary, Only Style, ABV and IBU have missing values. Almost 50% of IBU values are missing, which will most certainly affect our conclusions. Only 3% of ABV values and 5 Style entries are missing. 

-Confirm numeric missing values

```r
## Prepare for merging ##

panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(apply(AllBeer, 2, is.na), 2, sum))
```


-------------------------------------------------------------------------------------------
 Brew_ID   Beer_Name   Beer_ID   ABV   IBU    Style   Ounces   Brewery_Name   City   State 
--------- ----------- --------- ----- ------ ------- -------- -------------- ------ -------
    0          0          0      62    1005     0       0           0          0       0   
-------------------------------------------------------------------------------------------

-Confirm character missing values

```r
## Double Check ##
## Look at blank Strings ##

panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(AllBeer, 2, function(y) sum(y == "")))
```


------------------------------------------------------------------------------------------
 Brew_ID   Beer_Name   Beer_ID   ABV   IBU   Style   Ounces   Brewery_Name   City   State 
--------- ----------- --------- ----- ----- ------- -------- -------------- ------ -------
    0          0          0      NA    NA      5       0           0          0       0   
------------------------------------------------------------------------------------------

### Add Region & Division
R contains additional region and division data per state in the package 'datasets'. These data are from a 1977 report from the chamber of commerce. The state classifications for region and division have not changed. Prior to June 1984 however, the Midwest Region was designated as the North Central Region. These data were added to expand analysis options and segmenting the states and cities geographically. 


```r
## Add region/division ##

state.geo=data.frame(state.abb, state.region, state.division)

#rename for ease of merge
#length(levels(state.geo$state.abb))
levels(state.geo$state.abb) = c(levels(state.geo$state.abb),"DC")
names(state.geo)[1]='State'
state.geo[51, ] = c('DC','South', 'South Atlantic')

#align levels for merge
levels(state.geo$State)=levels(AllBeer$State)


#Final Data#
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))
AllBeerReg<-merge(x=AllBeer, y=state.geo, by.x="State", all.x = TRUE)
str(AllBeerReg)
```

```
## 'data.frame':	2410 obs. of  12 variables:
##  $ State         : Factor w/ 51 levels "AK","AL","AR",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Brew_ID       : int  103 103 494 459 103 459 224 271 224 224 ...
##  $ Beer_Name     : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 1137 114 1604 1955 1138 1847 1878 94 1873 1584 ...
##  $ Beer_ID       : int  1667 2436 920 349 1706 348 434 1920 587 1814 ...
##  $ ABV           : num  0.06 0.051 0.052 0.068 0.055 0.058 0.057 0.053 0.048 0.063 ...
##  $ IBU           : int  70 NA 17 NA NA NA 70 18 12 61 ...
##  $ Style         : Factor w/ 100 levels "","Abbey Single Ale",..: 16 5 18 16 41 93 16 3 100 16 ...
##  $ Ounces        : num  12 12 12 12 12 12 12 12 12 12 ...
##  $ Brewery_Name  : Factor w/ 551 levels "10 Barrel Brewing Company",..: 279 279 98 276 279 276 318 16 318 318 ...
##  $ City          : Factor w/ 384 levels "Abingdon","Abita Springs",..: 8 8 8 317 8 317 8 165 8 8 ...
##  $ state.region  : Factor w/ 4 levels "Northeast","South",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ state.division: Factor w/ 9 levels "New England",..: 9 9 9 9 9 9 9 9 9 9 ...
```

```r
apply(AllBeerReg, 2, function(y) sum(y == ""))
```

```
##          State        Brew_ID      Beer_Name        Beer_ID            ABV 
##              0              0              0              0             NA 
##            IBU          Style         Ounces   Brewery_Name           City 
##             NA              5              0              0              0 
##   state.region state.division 
##              0              0
```

```r
apply(apply(AllBeerReg, 2, is.na), 2, sum)
```

```
##          State        Brew_ID      Beer_Name        Beer_ID            ABV 
##              0              0              0              0             62 
##            IBU          Style         Ounces   Brewery_Name           City 
##           1005              0              0              0              0 
##   state.region state.division 
##              0              0
```

#Analysis

###Breweries and Syles

There are 558 unique breweries and 100 different styles. The most popular styles per state are 'American IPA' followed by 'American Pale Ale'. These two styles combined constitute 27.8% of all 2410 beers. Furthermore, eight of the most popular styles also have 'American' in the name. Only Nevada's and New Hampshire's most popular styles do not have 'American' in the name. In addition, California, Colorado, and Michigan house the greaterst number of breweries. 

-The ten most popular canned beer styles are presented below, expand to see. 'Saison' and 'Witbier' are the only non-'American' styles in the top ten at positions nine and ten respectively. 

```r
#10 most popular beer styles
##use table to get frequencies and then sort
pop1=sort(table(AllBeerReg$Style))[100:91]
pop1
```

```
## 
##                   American IPA        American Pale Ale (APA) 
##                            424                            245 
##       American Amber / Red Ale            American Blonde Ale 
##                            133                            108 
## American Double / Imperial IPA        American Pale Wheat Ale 
##                            105                             97 
##             American Brown Ale                American Porter 
##                             70                             68 
##         Saison / Farmhouse Ale                        Witbier 
##                             52                             51
```

-23 of the 100 unique styles are 'American'. However, these 23 styles constitute 62% of all craft cans. Calculations may be confirmed below. However, only 37 out of 2410 beers have 'American' in their title.


```r
## Calculate percent of styles and beers that are American ##

AM<-table(AllBeerReg$Style)  #Get frequency of Beers per style
AMindex<-grepl('America', row.names(AM))  #Check for 'America' in the title
sum(AMindex)/100  #Count percent of Beer styles that are 'American': sum / 100
```

```
## [1] 0.23
```

```r
sum(AM[AMindex])  #Calculate total number of beers that are 'American'
```

```
## [1] 1492
```

```r
sum(AM[AMindex])/2410  #Calculate percent number of beers that are 'American'
```

```
## [1] 0.6190871
```

```r
AN<-table(AllBeerReg$Beer_Name)  #Get frequency of Beer names
ANindex<-grepl('America', row.names(AN))  #Check for 'America' in the title
sum(AN[ANindex])/2410  #Count percent of Beer styles that are 'American': sum / 2410
```

```
## [1] 0.0153527
```

```r
sum(AN[ANindex])  #Calculate total number of beers that are 'American'
```

```
## [1] 37
```


-The total number of breweries per state is shown below. The data does not show Puerto Rico, but it appears that every state and Washington DC have at least one Brewery. 


```r
#Horizontal Table#

StBrews=sapply(tapply(AllBeerReg$Brew_ID, AllBeerReg$State, unique), length)
pander(StBrews)
```


---------------------------------------------------------------------------------------------------
 AK   AL   AR   AZ   CA   CO   CT   DC   DE   FL   GA   HI   IA   ID   IL   IN   KS   KY   LA   MA 
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
 7    3    2    11   39   47   8    1    2    15   7    4    5    5    18   22   3    4    5    23 
---------------------------------------------------------------------------------------------------

 
---------------------------------------------------------------------------------------------------
 MD   ME   MI   MN   MO   MS   MT   NC   ND   NE   NH   NJ   NM   NV   NY   OH   OK   OR   PA   RI 
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
 7    9    32   12   9    2    9    19   1    5    3    3    4    2    16   15   6    29   25   5  
---------------------------------------------------------------------------------------------------

 
------------------------------------------------------
 SC   SD   TN   TX   UT   VA   VT   WA   WI   WV   WY 
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
 4    1    3    28   4    16   10   23   20   1    4  
------------------------------------------------------

```r
names(rawbreweries)[2] = "Brewery_Name"  
```

-Map of total number of breweries per state. Colorado stands out as having many more breweries than its neighbors. 


```r
#Initializes a new object with State, Brewery Name, and City

newbrewery<-AllBeerReg[,c("Brewery_Name", "City", "State")]
str(newbrewery)
```

```
## 'data.frame':	2410 obs. of  3 variables:
##  $ Brewery_Name: Factor w/ 551 levels "10 Barrel Brewing Company",..: 279 279 98 276 279 276 318 16 318 318 ...
##  $ City        : Factor w/ 384 levels "Abingdon","Abita Springs",..: 8 8 8 317 8 317 8 165 8 8 ...
##  $ State       : Factor w/ 51 levels "AK","AL","AR",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))   #Returns a count of the unique breweries by state

names(newbrewery2) = c("State", "Freq")

#Runs the StateName function to replace abbreviations with state names and then calls tolower to make certain they are lower case

newbrewery2<-StateName(newbrewery2)

newbrewery2$State<-tolower(newbrewery2$State)

str(newbrewery2)
```

```
## 'data.frame':	51 obs. of  2 variables:
##  $ State: chr  "alaska" "alabama" "arkansas" "arizona" ...
##  $ Freq : int  7 3 2 11 39 46 8 1 2 15 ...
```

```r
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
```

![](CaseStudy1BootstrapDoc_files/figure-html/state.Brew.map-1.png)<!-- -->

-Table of most popular beer style per state


```r
TTT=table(AllBeerReg[, c("Style", "State")]) #Get frequency of style and state
TT=apply(TTT, 2, which.max)  #This gets the most brewed style per State

pop2=data.frame("State" =colnames(TTT),
            "Style" = row.names(TTT)[apply(TTT, 2, which.max)])
pop2
```

```
##    State                          Style
## 1     AK                   American IPA
## 2     AL                   American IPA
## 3     AR       American Amber / Red Ale
## 4     AZ                   American IPA
## 5     CA                   American IPA
## 6     CO                   American IPA
## 7     CT       American Amber / Red Ale
## 8     DC            American Blonde Ale
## 9     DE                   American IPA
## 10    FL                   American IPA
## 11    GA             American Brown Ale
## 12    HI     American Amber / Red Lager
## 13    IA            American Blonde Ale
## 14    ID                   American IPA
## 15    IL        American Pale Ale (APA)
## 16    IN                   American IPA
## 17    KS                   American IPA
## 18    KY                   American IPA
## 19    LA            American Blonde Ale
## 20    MA                   American IPA
## 21    MD                   American IPA
## 22    ME                   American IPA
## 23    MI                   American IPA
## 24    MN                   American IPA
## 25    MO                   American IPA
## 26    MS            American Blonde Ale
## 27    MT                   American IPA
## 28    NC                   American IPA
## 29    ND                   American IPA
## 30    NE        American Pale Ale (APA)
## 31    NH             Berliner Weissbier
## 32    NJ                   American IPA
## 33    NM                   American IPA
## 34    NV                    Schwarzbier
## 35    NY                   American IPA
## 36    OH                   American IPA
## 37    OK       American Amber / Red Ale
## 38    OR                   American IPA
## 39    PA                   American IPA
## 40    RI                American Porter
## 41    SC                   American IPA
## 42    SD       American Amber / Red Ale
## 43    TN                   American IPA
## 44    TX        American Pale Ale (APA)
## 45    UT                   American IPA
## 46    VA                   American IPA
## 47    VT American Double / Imperial IPA
## 48    WA                   American IPA
## 49    WI         American Adjunct Lager
## 50    WV             American Black Ale
## 51    WY        American Pale Ale (APA)
```
 
### ABV and IBU Summary

Alcohol per volume and international bitterness units.

ABV does not have much variation. 'Lee Hill Series Vol. 5 Belgian Style Quadrupel Ale' out of Colorado is the most alcoholic beer. Six out of the ten most alcoholic beers are 'Imperial' beers while two out of the five most alcoholic beers come from 'Upslope Brewing Company' out of Boulder Colorado. Similarly, four of the ten most alcoholic beers come from California.

-Summary Statistics for ABV below

```r
summary(AllBeerReg$ABV)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00100 0.05000 0.05600 0.05977 0.06700 0.12800      62
```

-List of 10 most alcoholic beers

```r
o1<-AllBeerReg[order(AllBeerReg$ABV, decreasing = TRUE), c("Beer_ID", "State", "Beer_Name", "ABV","IBU", "Brewery_Name", "City", "Style")]
kable(o1[1:10,], row.names = FALSE)
```



 Beer_ID  State   Beer_Name                                                 ABV   IBU  Brewery_Name                 City            Style                            
--------  ------  -----------------------------------------------------  ------  ----  ---------------------------  --------------  ---------------------------------
    2565  CO      Lee Hill Series Vol. 5 - Belgian Style Quadrupel Ale    0.128    NA  Upslope Brewing Company      Boulder         Quadrupel (Quad)                 
    2685  KY      London Balling                                          0.125    80  Against the Grain Brewery    Louisville      English Barleywine               
    2621  IN      Csar                                                    0.120    90  Tin Man Brewing Company      Evansville      Russian Imperial Stout           
    2564  CO      Lee Hill Series Vol. 4 - Manhattan Style Rye Ale        0.104    NA  Upslope Brewing Company      Boulder         Rye Beer                         
    2574  NY      4Beans                                                  0.100    52  Sixpoint Craft Ales          Brooklyn        Baltic Porter                    
    1036  CA      Lower De Boom                                           0.099    92  21st Amendment Brewery       San Francisco   American Barleywine              
    1674  CA      Chaotic Double IPA                                      0.099    93  Manzanita Brewing Company    Santee          American Double / Imperial IPA   
     904  CA      Ex Umbris Rye Imperial Stout                            0.099    85  Hess Brewing Company         San Diego       American Double / Imperial Stout 
    1561  CA      Double Trunk                                            0.099   101  The Dudes' Brewing Company   Torrance        American Double / Imperial IPA   
       6  CO      GUBNA Imperial IPA                                      0.099   100  Oskar Blues Brewery          Longmont        American Double / Imperial IPA   

```r
#o1[1:10,]
```


The IBU distribution is very right skewed. The most bitter bear 'Bitter Bitch Imperial IPA' out of Oregon is the most bitter beer. Nine out of the 10 most bitter beers are IPAs and eight our of the 10 most bitter beers are Imperial IPAs. Also, there is no overlap between the 10 most bitter and 10 most alcoholic canned beers. However, all ten of the most bitter beers are above the median ABV of 5.6% and only one is below the mean ABV of 5.977%. Similarly, all ten of the most alcoolic beers core above the mean and median IBU. 

-Summary statistics for IBU

```r
summary(AllBeerReg$IBU)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    4.00   21.00   35.00   42.71   64.00  138.00    1005
```

-The 10 most bitter beers

```r
o2<-AllBeerReg[order(AllBeerReg$IBU, decreasing = TRUE),c("Beer_ID", "State", "Beer_Name", "ABV","IBU", "Brewery_Name", "City", "Style")]
kable(o2[1:10,], row.names = FALSE)
```



 Beer_ID  State   Beer_Name                            ABV   IBU  Brewery_Name                         City              Style                          
--------  ------  --------------------------------  ------  ----  -----------------------------------  ----------------  -------------------------------
     980  OR      Bitter Bitch Imperial IPA          0.082   138  Astoria Brewing Company              Astoria           American Double / Imperial IPA 
    1676  VA      Troopers Alley IPA                 0.059   135  Wolf Hills Brewing Company           Abingdon          American IPA                   
    2067  MA      Dead-Eye DIPA                      0.090   130  Cape Ann Brewing Company             Gloucester        American Double / Imperial IPA 
    2440  OH      Bay of Bengal Double IPA (2014)    0.089   126  Christian Moerlein Brewing Company   Cincinnati        American Double / Imperial IPA 
      15  MN      Abrasive Ale                       0.097   120  Surly Brewing Company                Brooklyn Center   American Double / Imperial IPA 
    1111  VT      Heady Topper                       0.080   120  The Alchemist                        Waterbury         American Double / Imperial IPA 
     379  VT      Heady Topper                       0.080   120  The Alchemist                        Waterbury         American Double / Imperial IPA 
    2123  TX      More Cowbell                       0.090   118  Buffalo Bayou Brewing Company        Houston           American Double / Imperial IPA 
    1492  CA      Blazing World                      0.065   115  Modern Times Beer                    San Diego         American Amber / Red Ale       
     851  DC      On the Wings of Armageddon         0.092   115  DC Brau Brewing Company              Washington        American Double / Imperial IPA 

```r
#o2[1:10,]
```


ABV and IBU are probably related, but it is not obvious at first glance.

-Barplot of median ABV and IBU per state

```r
median_beer<-aggregate(AllBeerReg[,c("ABV","IBU")], list(AllBeerReg$State), median, na.rm=TRUE)    #Creates a new object which stores the median IBU and ABV per state
names(median_beer)[1]="State"


#barplot of median ABV and IBU per state in one graphic

par(mfrow=(c(2,1)), las=2, mar=c(2,2,1,1))

barplot(median_beer$ABV, names.arg = median_beer$State, cex.names = 0.7, cex.axis = 0.9, main="Median ABV by State", ylab="Alcohol By Volume (ABV)", las=2, col=c("lightgoldenrod2")) #ABV Bar Plot

barplot(median_beer$IBU, names.arg = median_beer$State, cex.names = 0.7, cex.axis = 0.9, main="Median IBU by State", ylab="International Bitterness Units (IBU)", las=2, col=c("lightblue3")) #IBU Bar Plot
```

![](CaseStudy1BootstrapDoc_files/figure-html/med.ABV.IBU-1.png)<!-- -->


-Map of median ABV per state below. Utah is the only state that stands out as having a particularly low median ABV at only 4.0%. In contrast, KY and Washington DC have the highest median ABV at 6.25%.


```r
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
```

![](CaseStudy1BootstrapDoc_files/figure-html/map.ABV-1.png)<!-- -->

-Map of median IBU per state. The state with the lowest median IBV score is Wisconsin with only a 19 median IBV. The highest is Maine with a Median of 61. 

```r
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
```

![](CaseStudy1BootstrapDoc_files/figure-html/map.IBU-1.png)<!-- -->


Upon further inspection, ABV and IBU do appear to be related, which is reasonable. The association is strong but not very powerful, in the sense that a large increases of IBU values are associated with a small increases in ABV despite being a likely association to occur. More precisely, positing a linear relationship suggests a 10 point increase in IBU is only associated with a 0.35% statistically significant increase in ABV. However, almost 40% of IBU values are missing. This could bias the results as less popular or accessible craft brews may be more likely to be niche products with a higher variance in IBU and ABV. 


```r
ggplot(dat=AllBeerReg, aes(x=IBU, y=ABV)) + 
  geom_point(shape=16) + 
  geom_smooth(method=lm) + theme_minimal() 
```

```
## Warning: Removed 1005 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 1005 rows containing missing values (geom_point).
```

![](CaseStudy1BootstrapDoc_files/figure-html/ABV.v.IBU-1.png)<!-- -->


-ABV to IBU regression summary below. 

```r
   L=lm(ABV~IBU, data=AllBeerReg)
   summary(L)
```

```
## 
## Call:
## lm(formula = ABV ~ IBU, data = AllBeerReg)
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -0.033288 -0.005946 -0.001595  0.004022  0.052006 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 4.493e-02  5.177e-04   86.79   <2e-16 ***
## IBU         3.508e-04  1.036e-05   33.86   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.01007 on 1403 degrees of freedom
##   (1005 observations deleted due to missingness)
## Multiple R-squared:  0.4497,	Adjusted R-squared:  0.4493 
## F-statistic:  1147 on 1 and 1403 DF,  p-value: < 2.2e-16
```

```r
  # L$coeff
  #bquote(ABU[i] == IBU[i]%*% .(signif(L$coeff[2], 3)) + .(signif(L$coeff[1], 3)))
```

# Summary and Conclusions

## Conclusions

Breweries appear to be distributed among the coast, likely related to population. However, Colorado brews more beers than any other state, especially considering its population relative to other states like Texas and California. Alcohol by volume, abbreviated as ABV, appears to be relatively consistent among the styles and among states. Beers brewed out of Utah are the only ones whose median ABV deviate substantially from the rest of the states. International bitterness units, abbreviated IBU, varies much more among states and among styles. However, much of the data is missing which could account for the additional variance we are seeing. The most bitter beers are American Double IPAs. It appears that 'American' beer styles, like American IPA and APA, are very popular and make up a disproportionate share of all craft canned beers that are brewed. In fact, American IPA and American APA alone make up 27.8% of all canned beers that were surveyed. However, only 37 of the 2410 beers in the sample actually have 'American' in the title making it likely that these styles are brewed out of popularity and not as a marketing tactic. 

<!---With additional information, such as how many of these styles are sold under the name 'American' outside of the United States and how many of these American styles have European counterparts, --->


## Additional Questions
During analysis of the data the researchers discussed many additional questions.  These questions ultimately did not see resolution in this study due to time or data constraints but could prove fruitful areas of research in the immediate future, particularly for those seeking to open a brewery in the near term or analyzing the common traits or popularity of various beer styles.  Questions include:

* What is the most popular beer style by Region/City?
* Which, if any, American styles are popular outside of the United States?
* What separates an American beer style from its nonAmerican counterpart?
* What are the median ABV/IBU by Beer Style?
* Is there any relationship to ABV or IBU and the size of the beer (ounces)?
* Why is there a correlation between ABV and IBU?  What causes it?
* What is the best place to open a canned craft beer brewery?
* What is the worst place to open a canned craft beer brewery?
* This data focused on canned beer, what about bottled beer or aggregate of all craft beer?

In turn these questions would likely open up additional avenues of research as long as discoverable data exists to support that research.

### What's Next?
Leverage the current data to perform more analysis of distribution of various beer styles by state or region.  Use of the city variable did not come up in this research but could create an added component to show true hotspots if added to the plot for the number of breweries.

Since the IBU data contained many blank fields, that data could be researched further to fill in wholes to ensure the data represented in this study truly reflects the actual median and maximum values.  Additional data on actual volumes and sales of canned craft brew could show a better understanding of which styles are popular in various states and regions.  Additionally, deeper statistical analysis could be performed with market analysis to better aid the industry as a whole and answer questions about optimal locations for new breweries and demand.

>>>>>>> 29076ff94b4c37d5399fee3e90a43fefcc99d51e

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
