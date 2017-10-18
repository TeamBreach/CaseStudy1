# Craft-Cans Case Study
Arturo Casillas & Kevin Dickens  
October 6, 2017  

# Abstract
This study seeks to evaluate the distribution of beer and certain beer characteristics across the United States and answer questions important to the relationships between those characteristics and the spatial distribution.  The goal is to show the distribution of breweries across the united states, discuss correlation between the primary beer characteristics of ABV and IBU, and begin to explore the spatial relationships between breweries and beer characteristics.

# Introduction
In recent years the craft brewery movement has exploded across the United States.  New breweries open every month across the nation and they come in many shapes, sizes, and forms from the microbrewery that primarily focuses on brewing beer to bars known as brewpubs who craft their own beer.  The products that these establishments offer vary in many ways from packaging (cans versus bottles), to alcohol content, to style and bitterness.  At the end of the day, they all manufacture beer.  Of particular interest to this study are the relationships of canned craft beer breweries and the common beer characteristics.  Do these characteristics show any relationships spatially or statistically?  This study hopes to answer that basic question and provide a foundation for future research on the topic.

Of particular interest to the researchers requesting the analysis and those involved in the study are the spatial relationships and distributions of the canned craft beer movement.  This study will look at how the breweries are distributed across the country and look at the spatial distributions of other beer characteristics to better understand trends and popularity of various beer styles.  The spatial interpretation of data will inform readers of hot spots of craft brewery activity.

This study will also perform basic statistical analysis to better understand and interpret the both the spatial data and the underlying canned craft beer data as well.  The findings will inform readers on the distributions of the data and allow them to look at the included maps to determine which states lie above or below median values as well as determine underlying relationships between such characteristics as alcohol by volume and international bitterness units.

Fundamentally, this study will seek to answer the following questions:

* How many breweries are in each state?
* What is the median ABV and IBU for each state?
* What is the spatial distribution of the data of interest?
* Are there any statistical or spatial relationships between the variables presented in the data?

## Scope
The scope of this analytical research is limited to the data originally provided by the requestor.  As such the scope of the data pertains to U.S. domestic craft breweries that produce a canned beer product no later than 2015.  It is unclear if this data contains all craft breweries that create a brewed product, or only a sample.  The scope is further limited to only the 50 States and the District of Columbia.  No U.S. territories are included in the underlying data.  



# Data
This section will describe the original data and discuss methods used to convert the raw data into a tidy dataset ready for analysis.  These steps are crucial for replication of the analysis as the raw data contained several anomalies which could prevent replication of the analysis presented later.

## About the Data
For more information on the raw data, see the codebook [here.](https://github.com/TeamBreach/CaseStudy1/blob/master/Codebook.md)

### Source

The original data came in two files: Beer.csv & Breweries.csv. The tables contain a list of 2410 US craft beers and 510 US breweries. The beer data corresponds to craft beers available in cans and lists the beer ID number, the size of the can in ounces, style of beer, percent alcohol per volume (ABV), and international bitterness units (IBU) as well as the beer name and brewery ID. The Breweries data lists breweries by location of state and city along with a unique ID. This data was traced to CraftCans.com and further traced to the Brewers Association (BA). A more expansive data set is available to Brewers Association members. 

To prepare the data for analysis, variable names are altered for clarity and to minimize merging issues. The beers and breweries are linked by a unique numeric ID (Brew_ID), so no assumptions or algorithm was needed to combine the tables. 

-View the structure of the original data. Expand below to see details.


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

-Prepare the data for merging, such as rename columns. Expand below to see details.


```r
## Prepare for merging ##

rawbeers <- rename(rawbeers,c('Brewery_id'='Brew_ID')) #Renames column in raw data so a primary key match can be made
rawbeers <- rename(rawbeers,c('Name'='Beer_Name')) #Renames column in raw to avoid conflicts with merges later
rawbreweries <- rename(rawbreweries,c('Name'='Brewery_Name')) #Renames column in raw to avoid conflicts with merges later
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

-Perform a spot check for integrity, view the first six rows

```r
#kable(head(AllBeer, 6), row.names = FALSE)
panderOptions('table.split.table', 100)
panderOptions('table.continues', '...')
pander(head(AllBeer, 6), row.names = FALSE)
```


------------------------------------------------------------------------------------------
 Brew_ID     Beer_Name     Beer_ID    ABV    IBU               Style               Ounces 
--------- --------------- --------- ------- ----- ------------------------------- --------
    1      Get Together     2692     0.045   50            American IPA              16   

    1      Maggie's Leap    2691     0.049   26         Milk / Sweet Stout           16   

    1       Wall's End      2690     0.048   19          English Brown Ale           16   

    1         Pumpion       2689     0.06    38             Pumpkin Ale              16   

    1       Stronghold      2688     0.06    25           American Porter            16   

    1       Parapet ESB     2687     0.056   47    Extra Special / Strong Bitter     16   
                                                               (ESB)                      
------------------------------------------------------------------------------------------

Table: ...

 
-----------------------------------------
   Brewery_Name         City       State 
------------------- ------------- -------
 NorthGate Brewing   Minneapolis    MN   

 NorthGate Brewing   Minneapolis    MN   

 NorthGate Brewing   Minneapolis    MN   

 NorthGate Brewing   Minneapolis    MN   

 NorthGate Brewing   Minneapolis    MN   

 NorthGate Brewing   Minneapolis    MN   
-----------------------------------------

-Perform a spot check for integrity, view the lasts six rows

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

  -Table of numeric missing values

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

  -Table of character missing values

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

#View Final Data#
str(AllBeerReg); head(AllBeerReg, 6); tail(AllBeerReg, 6)
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

```
##   State Brew_ID                  Beer_Name Beer_ID   ABV IBU
## 1    AK     103            King Street IPA    1667 0.060  70
## 2    AK     103                  Amber Ale    2436 0.051  NA
## 3    AK     494             Polar Pale Ale     920 0.052  17
## 4    AK     459          Sunken Island IPA     349 0.068  NA
## 5    AK     103        King Street Pilsner    1706 0.055  NA
## 6    AK     459 Skilak Scottish Ale (2011)     348 0.058  NA
##                      Style Ounces                 Brewery_Name      City
## 1             American IPA     12  King Street Brewing Company Anchorage
## 2 American Amber / Red Ale     12  King Street Brewing Company Anchorage
## 3  American Pale Ale (APA)     12 Broken Tooth Brewing Company Anchorage
## 4             American IPA     12  Kenai River Brewing Company  Soldotna
## 5           Czech Pilsener     12  King Street Brewing Company Anchorage
## 6             Scottish Ale     12  Kenai River Brewing Company  Soldotna
##   state.region state.division
## 1         West        Pacific
## 2         West        Pacific
## 3         West        Pacific
## 4         West        Pacific
## 5         West        Pacific
## 6         West        Pacific
```

```
##      State Brew_ID                        Beer_Name Beer_ID   ABV IBU
## 2405    WY     458    Saddle Bronc Brown Ale (2013)    1198 0.048  16
## 2406    WY     192                   Pakoâ<U+0080><U+0099>s EyePA     393 0.068  60
## 2407    WY     192               Snow King Pale Ale    1606 0.060  55
## 2408    WY     458             Wagon Box Wheat Beer    1197 0.059  15
## 2409    WY     458            Indian Paintbrush IPA    1199 0.070  75
## 2410    WY     458 Bomber Mountain Amber Ale (2013)    1200 0.046  20
##                         Style Ounces                    Brewery_Name
## 2405        English Brown Ale     12 The Black Tooth Brewing Company
## 2406             American IPA     12     Snake River Brewing Company
## 2407  American Pale Ale (APA)     12     Snake River Brewing Company
## 2408  American Pale Wheat Ale     12 The Black Tooth Brewing Company
## 2409             American IPA     12 The Black Tooth Brewing Company
## 2410 American Amber / Red Ale     12 The Black Tooth Brewing Company
##          City state.region state.division
## 2405 Sheridan        South South Atlantic
## 2406  Jackson        South South Atlantic
## 2407  Jackson        South South Atlantic
## 2408 Sheridan        South South Atlantic
## 2409 Sheridan        South South Atlantic
## 2410 Sheridan        South South Atlantic
```

```r
#Recheck for missing values
apply(apply(AllBeer, 2, is.na), 2, sum); apply(AllBeerReg, 2, function(y) sum(y == ""))
```

```
##      Brew_ID    Beer_Name      Beer_ID          ABV          IBU 
##            0            0            0           62         1005 
##        Style       Ounces Brewery_Name         City        State 
##            0            0            0            0            0
```

```
##          State        Brew_ID      Beer_Name        Beer_ID            ABV 
##              0              0              0              0             NA 
##            IBU          Style         Ounces   Brewery_Name           City 
##             NA              5              0              0              0 
##   state.region state.division 
##              0              0
```

<!---
-Confirm numeric missing values in updated data

```r
panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(apply(AllBeer, 2, is.na), 2, sum))
```


-------------------------------------------------------------------------------------------
 Brew_ID   Beer_Name   Beer_ID   ABV   IBU    Style   Ounces   Brewery_Name   City   State 
--------- ----------- --------- ----- ------ ------- -------- -------------- ------ -------
    0          0          0      62    1005     0       0           0          0       0   
-------------------------------------------------------------------------------------------

-Confirm character missing values in updated data

```r
panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(AllBeerReg, 2, function(y) sum(y == "")))
```


------------------------------------------------------------------------------------------
 State   Brew_ID   Beer_Name   Beer_ID   ABV   IBU   Style   Ounces   Brewery_Name   City 
------- --------- ----------- --------- ----- ----- ------- -------- -------------- ------
   0        0          0          0      NA    NA      5       0           0          0   
------------------------------------------------------------------------------------------

 
-------------------------------
 state.region   state.division 
-------------- ----------------
      0               0        
-------------------------------
--->

# Analysis

### Breweries and Syles

There are 558 unique breweries and 100 different styles. The most popular style is 'American IPA' followed by 'American Pale Ale'. These two styles combined constitute 27.8% of all 2410 beers. Furthermore, eight of the most popular styles also have 'American' in the name. Only Nevada's and New Hampshire's most popular styles do not have 'American' in the name, being 'Saison' and 'Witbier' respectively. In addition, California, Colorado, and Michigan house the greatest number of breweries. 

  -The ten most popular canned beer styles are presented below, expand to see.  

```r
#10 most popular beer styles
##use table to get frequencies and then sort
 length(unique(AllBeerReg$Style))->s
 s-9 -> f
pop1=sort(table(AllBeerReg$Style))[s:f]
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

-23 of the 100 unique styles are 'American'. However, these 23 styles constitute 62% of all craft cans. Calculations may be confirmed below. Only 37 out of 2410 beers have 'America' in their name.


```r
## Calculate percent of styles that are American ##

AM<-table(AllBeerReg$Style)  #Get frequency of Beers per style
AMindex<-grepl('America', row.names(AM))  #Check for 'America' in the title

## Calculate percent of unique styles, total number of beers that are 'American', and percent number of beers that are 'American'
sum(AMindex)/length(unique(AllBeerReg$Style)); sum(AM[AMindex]); sum(AM[AMindex])/length(AllBeerReg$Beer_ID)
```

```
## [1] 0.23
```

```
## [1] 1492
```

```
## [1] 0.6190871
```

```r
## Calculate percent of beers that are have America in the name ##
AN<-table(AllBeerReg$Beer_Name)  #Get frequency of Beer names
ANindex<-grepl('America', row.names(AN))  #Check for 'America' in the title

## Calculate percent of Beers that are 'American', total number of beers that are 'American'
sum(AN[ANindex])/length(AllBeerReg$Beer_ID)  ; sum(AN[ANindex])  
```

```
## [1] 0.0153527
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

-For a list of the most popular beer style per state, expand below


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

Alcohol by volume (ABV) does not have much variation. 'Lee Hill Series Vol. 5 Belgian Style Quadrupel Ale' out of Colorado is the most alcoholic beer. Six out of the ten most alcoholic beers are 'Imperial' beers while two out of the five most alcoholic beers come from 'Upslope Brewing Company' out of Boulder Colorado. Similarly, four of the ten most alcoholic beers come from California.

-Summary Statistics for ABV below

```r
## Summary Statistics of ABV ##
#summary(AllBeerReg$ABV)
panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(summary(AllBeerReg$ABV))
```


-------------------------------------------------------------
 Min.    1st Qu.   Median    Mean     3rd Qu.   Max.    NA's 
------- --------- -------- --------- --------- ------- ------
 0.001    0.05     0.056    0.05977    0.067    0.128    62  
-------------------------------------------------------------

-The 10 most alcoholic beers are listed below

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


The distribution of inernational bitterness units (IBU) is very right skewed. The most bitter beer is 'Bitter Bitch Imperial IPA' out of Oregon. Nine out of the 10 most bitter beers are IPAs and eight of the 10 most bitter beers are Double Imperial IPAs. Also, there is no overlap between the 10 most bitter and 10 most alcoholic canned beers. However, all ten of the most bitter beers are above the median ABV of 5.6% and only one is below the mean ABV of 5.977%. Similarly, all ten of the most alcoholic beers lie above the mean and median IBU. 

-Summary statistics for IBU

```r
## Summary Statistics of IBU ##
#summary(AllBeerReg$IBU)
panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(summary(AllBeerReg$IBU))
```


---------------------------------------------------------
 Min.   1st Qu.   Median   Mean    3rd Qu.   Max.   NA's 
------ --------- -------- ------- --------- ------ ------
  4       21        35     42.71     64      138    1005 
---------------------------------------------------------

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


Upon further inspection, ABV and IBU do appear to be related, which is reasonable. The association is strong but not very powerful, in the sense that large increases of IBU values are associated with a small increases in ABV despite being a likely association to occur. More precisely, positing a linear relationship suggests a 10 point increase in IBU is only associated with a 0.35% statistically significant increase in ABV. However, almost 40% of IBU values are missing. This could bias the results as less popular or accessible craft brews may be more likely to be niche products with a higher variance in IBU and ABV. 


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


-For ABV to IBU regression summary details, expand below. 

```r
  # L$coeff
  #bquote(ABU[i] == IBU[i]%*% .(signif(L$coeff[2], 3)) + .(signif(L$coeff[1], 3)))
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
# Summary and Conclusions

## Spatial Summary and Conclusions
As one can see, craft canned breweries are roughly equally distributed across the country with a few notable exceptions.  Colorado contains more craft breweries than any other single state.  The west coast trends higher than the rest of the country and the upper Midwest and St. Lawrence River corridor shows slightly higher than usual distribution.  In order to evaluate why, we'd need more data but reasonable assumptions for the west coast and the St. Lawrence corridor stem from the large population in those regions.  Colorado remains an anomaly at this point as commonly available data do not give any meaningful explanation to this phenomenon.

In order to discuss measures of popularity or preference we must note that the only data in the given dataset to derive a measure of these descriptive terms stems from the number of beers brewed of a particular style, or with significant deviations from the median ABV or IBU.  A better statistic would be to look at consumption patterns rather than brewing patterns as it is possible to brew beer that no one drinks or is otherwise considered unpopular.

There appear to be no easily quantifiable spatial distribution trends for ABV oby state.  The central states away from the coasts appear higher overall but do not deviate from the median significantly enough to note a trend.  Utah stands out as the sole anomaly with significantly lower ABV than the surrounding states, especially since it rests central to a cluster of higher than typical ABV states.  This could be due to government intervention by the state or from societal differences given the large Mormon population in Utah.  

Certain regions stand out as preferring different levels of bitterness as shown by the map of IBU by state.  The Pacific Coast and northwestern states prefer a moderate to high level of bitterness while the central plains states appear to prefer lower bitterness.  Both the southeastern and northeastern states seemingly prefer higher bitterness levels as well, but not as consistently as the west and northwest.  Of note is the absence of data for South Dakota.  Without further data we can only assume this is a regional preference and not some other underlying social, governmental, or societal difference.

## Statistical Summary and Conclusions

Alcohol by volume, abbreviated as ABV, appears to be relatively consistent among the styles and among states. Beers brewed out of Utah are the only ones whose median ABV deviate substantially from the rest of the states. International bitterness units, abbreviated IBU, varies much more among states and among styles. However, much of the data is missing which could account for the additional variance we are seeing. The most bitter beers are American Double IPAs. It appears that 'American' beer styles, like American IPA and APA, are very popular and make up a disproportionate share of all craft canned beers that are brewed. In fact, American IPA and American Pale Ale alone make up 27.8% of all canned beers that were surveyed. However, only 37 of the 2410 beers in the sample actually have 'American' in the title making it likely that these styles are brewed out of popularity and not as a marketing tactic. 


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
* What is driving the opening of so many breweries in Colorado?
* Utah shows significantly lower median ABV.  Why?
* Are regions that grow more hops likely to prefer beer with a higher IBU?

In turn these questions would likely open up additional avenues of research as long as discoverable data exists to support that research.

### What's Next?
Leverage the current data to perform more analysis of distribution of various beer styles by state or region.  Use of the city variable did not come up in this research but could create an added component to show true hotspots if added to the plot for the number of breweries.

Since the IBU data contained many blank fields, that data could be researched further to fill in wholes to ensure the data represented in this study truly reflects the actual median and maximum values.  Additional data on actual volumes and sales of canned craft brew could show a better understanding of which styles are popular in various states and regions.  Additionally, deeper statistical analysis could be performed with market analysis to better aid the industry as a whole and answer questions about optimal locations for new breweries and demand.

>>>>>>> 29076ff94b4c37d5399fee3e90a43fefcc99d51e

