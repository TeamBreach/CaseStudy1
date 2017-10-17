Intro
=====

Intro
-----

-Intro goes here

Data
====

About the Data
--------------

### Source

The tables contain a list of 2410 US craft beers and 510 US breweries. The beer data corresponds to craft beers available in cans and lists the beer ID number, the size of the can in ounces, style of beer, percent alcohol per volume (ABV), and international bitterness units (IBU) as well as the beer name and brewery ID.The Breweries data lists breweries by location of state and city along with a unique ID. This data was traced to CraftCans.com and further traced to the Brewers Association (BA). A more expansive data set is available to Brewers Association members.

To prepare the data for analysis, variable names are altered for clarity and to minimize merging issues. The beers and breweries are linked by a unique numeric ID (Brew\_ID), so no assumptions or algorithm was needed to combine the tables.

-View the original data. Expand below to see details.

``` r
str(rawbeers)
```

    ## 'data.frame':    2410 obs. of  7 variables:
    ##  $ Name      : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 1638 577 1705 1842 1819 268 1160 758 1093 486 ...
    ##  $ Beer_ID   : int  1436 2265 2264 2263 2262 2261 2260 2259 2258 2131 ...
    ##  $ ABV       : num  0.05 0.066 0.071 0.09 0.075 0.077 0.045 0.065 0.055 0.086 ...
    ##  $ IBU       : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Brewery_id: int  409 178 178 178 178 178 178 178 178 178 ...
    ##  $ Style     : Factor w/ 100 levels "","Abbey Single Ale",..: 19 18 16 12 16 80 18 22 18 12 ...
    ##  $ Ounces    : num  12 12 12 12 12 12 12 12 12 12 ...

``` r
str(rawbreweries)
```

    ## 'data.frame':    558 obs. of  4 variables:
    ##  $ Brew_ID: int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Name   : Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 12 266 319 201 136 227 477 59 491 ...
    ##  $ City   : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 200 122 299 300 62 91 48 152 136 ...
    ##  $ State  : Factor w/ 51 levels " AK"," AL"," AR",..: 24 18 20 5 5 41 6 23 23 23 ...

-Prepare for merging. Expand below to see details.

``` r
## Prepare for merging ##

names(rawbeers)[5] = "Brew_ID"  #Rename 'Brewery_id' to ease merging

names(rawbeers)[1] = "Beer_Name" #Rename 'Name' to 'Beer_Name' to avoid confusion with brewery name or state

names(rawbreweries)[2] = "Brewery_Name"  #Rename 'Name' to 'Brewery_Name' avoid confusion and ease merging
```

-Merged to create a single table, details below.

``` r
## Merge Data ##

AllBeer <- merge(rawbeers, rawbreweries, by="Brew_ID")

str(AllBeer)
```

    ## 'data.frame':    2410 obs. of  10 variables:
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

``` r
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))  #Trim the leadig spaces from state abbreviation
```

-Expand below to see the first 6 rows and perform a spot check for integrity (raw)

``` r
#kable(head(AllBeer, 6), row.names = FALSE)
head(AllBeer, 6)
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

-Also expand below to see the last 6 rows and perform a spot check for integrity (pander)

``` r
panderOptions('table.split.table', 100)
panderOptions('table.continues', '...')
pander(tail(AllBeer, 6), row.names = FALSE)
```

<table>
<caption>...</caption>
<colgroup>
<col width="10%" />
<col width="29%" />
<col width="10%" />
<col width="8%" />
<col width="6%" />
<col width="27%" />
<col width="8%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Brew_ID</th>
<th align="center">Beer_Name</th>
<th align="center">Beer_ID</th>
<th align="center">ABV</th>
<th align="center">IBU</th>
<th align="center">Style</th>
<th align="center">Ounces</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">556</td>
<td align="center">Pilsner Ukiah</td>
<td align="center">98</td>
<td align="center">0.055</td>
<td align="center">NA</td>
<td align="center">German Pilsener</td>
<td align="center">12</td>
</tr>
<tr class="even">
<td align="center">557</td>
<td align="center">Heinnieweisse Weissebier</td>
<td align="center">52</td>
<td align="center">0.049</td>
<td align="center">NA</td>
<td align="center">Hefeweizen</td>
<td align="center">12</td>
</tr>
<tr class="odd">
<td align="center">557</td>
<td align="center">Snapperhead IPA</td>
<td align="center">51</td>
<td align="center">0.068</td>
<td align="center">NA</td>
<td align="center">American IPA</td>
<td align="center">12</td>
</tr>
<tr class="even">
<td align="center">557</td>
<td align="center">Moo Thunder Stout</td>
<td align="center">50</td>
<td align="center">0.049</td>
<td align="center">NA</td>
<td align="center">Milk / Sweet Stout</td>
<td align="center">12</td>
</tr>
<tr class="odd">
<td align="center">557</td>
<td align="center">Porkslap Pale Ale</td>
<td align="center">49</td>
<td align="center">0.043</td>
<td align="center">NA</td>
<td align="center">American Pale Ale (APA)</td>
<td align="center">12</td>
</tr>
<tr class="even">
<td align="center">558</td>
<td align="center">Urban Wilderness Pale Ale</td>
<td align="center">30</td>
<td align="center">0.049</td>
<td align="center">NA</td>
<td align="center">English Pale Ale</td>
<td align="center">12</td>
</tr>
</tbody>
</table>

<table style="width:76%;">
<colgroup>
<col width="44%" />
<col width="22%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Brewery_Name</th>
<th align="center">City</th>
<th align="center">State</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Ukiah Brewing Company</td>
<td align="center">Ukiah</td>
<td align="center">CA</td>
</tr>
<tr class="even">
<td align="center">Butternuts Beer and Ale</td>
<td align="center">Garrattsville</td>
<td align="center">NY</td>
</tr>
<tr class="odd">
<td align="center">Butternuts Beer and Ale</td>
<td align="center">Garrattsville</td>
<td align="center">NY</td>
</tr>
<tr class="even">
<td align="center">Butternuts Beer and Ale</td>
<td align="center">Garrattsville</td>
<td align="center">NY</td>
</tr>
<tr class="odd">
<td align="center">Butternuts Beer and Ale</td>
<td align="center">Garrattsville</td>
<td align="center">NY</td>
</tr>
<tr class="even">
<td align="center">Sleeping Lady Brewing Company</td>
<td align="center">Anchorage</td>
<td align="center">AK</td>
</tr>
</tbody>
</table>

### Data Integrity

The data were examined for missing values and nonsense entries through formal methods in addtion to spot checks. In summary, Only Style, ABV and IBU have missing values. Almost 50% of IBU values are missing, which will most certainly affect our conclusions. Only 3% of ABV values and 5 Style entries are missing.

-Confirm numeric missing values

``` r
## Prepare for merging ##

panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(apply(AllBeer, 2, is.na), 2, sum))
```

<table style="width:100%;">
<colgroup>
<col width="10%" />
<col width="13%" />
<col width="10%" />
<col width="6%" />
<col width="7%" />
<col width="8%" />
<col width="9%" />
<col width="16%" />
<col width="7%" />
<col width="7%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Brew_ID</th>
<th align="center">Beer_Name</th>
<th align="center">Beer_ID</th>
<th align="center">ABV</th>
<th align="center">IBU</th>
<th align="center">Style</th>
<th align="center">Ounces</th>
<th align="center">Brewery_Name</th>
<th align="center">City</th>
<th align="center">State</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">62</td>
<td align="center">1005</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
</tr>
</tbody>
</table>

-Confirm character missing values

``` r
## Double Check ##
## Look at blank Strings ##

panderOptions('table.split.table', 100)
panderOptions('table.continues', '')
pander(apply(AllBeer, 2, function(y) sum(y == "")))
```

<table style="width:100%;">
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="11%" />
<col width="6%" />
<col width="6%" />
<col width="8%" />
<col width="10%" />
<col width="16%" />
<col width="7%" />
<col width="7%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Brew_ID</th>
<th align="center">Beer_Name</th>
<th align="center">Beer_ID</th>
<th align="center">ABV</th>
<th align="center">IBU</th>
<th align="center">Style</th>
<th align="center">Ounces</th>
<th align="center">Brewery_Name</th>
<th align="center">City</th>
<th align="center">State</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">5</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">0</td>
</tr>
</tbody>
</table>

### Add Region & Division

R contains additional region and division data per state in the package 'datasets'. These data are from a 1977 report from the chamber of commerce. The state classifications for region and division have not changed. Prior to June 1984 however, the Midwest Region was designated as the North Central Region. These data were added to expand analysis options and segmenting the states and cities geographically.

``` r
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

    ## 'data.frame':    2410 obs. of  12 variables:
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

``` r
apply(AllBeerReg, 2, function(y) sum(y == ""))
```

    ##          State        Brew_ID      Beer_Name        Beer_ID            ABV 
    ##              0              0              0              0             NA 
    ##            IBU          Style         Ounces   Brewery_Name           City 
    ##             NA              5              0              0              0 
    ##   state.region state.division 
    ##              0              0

``` r
apply(apply(AllBeerReg, 2, is.na), 2, sum)
```

    ##          State        Brew_ID      Beer_Name        Beer_ID            ABV 
    ##              0              0              0              0             62 
    ##            IBU          Style         Ounces   Brewery_Name           City 
    ##           1005              0              0              0              0 
    ##   state.region state.division 
    ##              0              0

Analysis
========

Analysis
--------

-   The total number of breweries per state (horizontal)

``` r
#Horizontal Table#

StBrews=sapply(tapply(AllBeerReg$Brew_ID, AllBeerReg$State, unique), length)
pander(StBrews)
```

<table style="width:100%;">
<colgroup>
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">AK</th>
<th align="center">AL</th>
<th align="center">AR</th>
<th align="center">AZ</th>
<th align="center">CA</th>
<th align="center">CO</th>
<th align="center">CT</th>
<th align="center">DC</th>
<th align="center">DE</th>
<th align="center">FL</th>
<th align="center">GA</th>
<th align="center">HI</th>
<th align="center">IA</th>
<th align="center">ID</th>
<th align="center">IL</th>
<th align="center">IN</th>
<th align="center">KS</th>
<th align="center">KY</th>
<th align="center">LA</th>
<th align="center">MA</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">7</td>
<td align="center">3</td>
<td align="center">2</td>
<td align="center">11</td>
<td align="center">39</td>
<td align="center">47</td>
<td align="center">8</td>
<td align="center">1</td>
<td align="center">2</td>
<td align="center">15</td>
<td align="center">7</td>
<td align="center">4</td>
<td align="center">5</td>
<td align="center">5</td>
<td align="center">18</td>
<td align="center">22</td>
<td align="center">3</td>
<td align="center">4</td>
<td align="center">5</td>
<td align="center">23</td>
</tr>
</tbody>
</table>

<table style="width:100%;">
<colgroup>
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">MD</th>
<th align="center">ME</th>
<th align="center">MI</th>
<th align="center">MN</th>
<th align="center">MO</th>
<th align="center">MS</th>
<th align="center">MT</th>
<th align="center">NC</th>
<th align="center">ND</th>
<th align="center">NE</th>
<th align="center">NH</th>
<th align="center">NJ</th>
<th align="center">NM</th>
<th align="center">NV</th>
<th align="center">NY</th>
<th align="center">OH</th>
<th align="center">OK</th>
<th align="center">OR</th>
<th align="center">PA</th>
<th align="center">RI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">7</td>
<td align="center">9</td>
<td align="center">32</td>
<td align="center">12</td>
<td align="center">9</td>
<td align="center">2</td>
<td align="center">9</td>
<td align="center">19</td>
<td align="center">1</td>
<td align="center">5</td>
<td align="center">3</td>
<td align="center">3</td>
<td align="center">4</td>
<td align="center">2</td>
<td align="center">16</td>
<td align="center">15</td>
<td align="center">6</td>
<td align="center">29</td>
<td align="center">25</td>
<td align="center">5</td>
</tr>
</tbody>
</table>

<table style="width:76%;">
<colgroup>
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
<col width="6%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">SC</th>
<th align="center">SD</th>
<th align="center">TN</th>
<th align="center">TX</th>
<th align="center">UT</th>
<th align="center">VA</th>
<th align="center">VT</th>
<th align="center">WA</th>
<th align="center">WI</th>
<th align="center">WV</th>
<th align="center">WY</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">4</td>
<td align="center">1</td>
<td align="center">3</td>
<td align="center">28</td>
<td align="center">4</td>
<td align="center">16</td>
<td align="center">10</td>
<td align="center">23</td>
<td align="center">20</td>
<td align="center">1</td>
<td align="center">4</td>
</tr>
</tbody>
</table>

``` r
names(rawbreweries)[2] = "Brewery_Name"  
```

-   The total number of breweries per state (vertical)

``` r
#Initializes a new object with State, Brewery Name, and City

newbrewery<-AllBeerReg[,c("Brewery_Name", "City", "State")]
str(newbrewery)
```

    ## 'data.frame':    2410 obs. of  3 variables:
    ##  $ Brewery_Name: Factor w/ 551 levels "10 Barrel Brewing Company",..: 279 279 98 276 279 276 318 16 318 318 ...
    ##  $ City        : Factor w/ 384 levels "Abingdon","Abita Springs",..: 8 8 8 317 8 317 8 165 8 8 ...
    ##  $ State       : Factor w/ 51 levels "AK","AL","AR",..: 1 1 1 1 1 1 1 1 1 1 ...

``` r
newbrewery2<-aggregate(newbrewery$Brewery_Name, list(newbrewery$State), function(x) length(unique(x)))   #Returns a count of the unique breweries by state

names(newbrewery2) = c("State", "Freq")
```

-Map of total number of breweries per state

``` r
#Runs the StateName function to replace abbreviations with state names and then calls tolower to make certain they are lower case

newbrewery2<-StateName(newbrewery2)

newbrewery2$State<-tolower(newbrewery2$State)

str(newbrewery2)
```

    ## 'data.frame':    51 obs. of  2 variables:
    ##  $ State: chr  "alaska" "alabama" "arkansas" "arizona" ...
    ##  $ Freq : int  7 3 2 11 39 46 8 1 2 15 ...

``` r
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

![](CaseStudy1BootstrapDoc_files/figure-markdown_github/state.Brew.map-1.png)

-   Map of total number of breweries per state

### Beers with highest IBU

-'Bitter Bitch Imperial IPA' out of Oregon is the most bitter beer -Nine out of the 10 most bitter beers are IPAs -Eight our of the 10 most bitter beers are Imperial IPAs

``` r
o2<-AllBeerReg[order(AllBeerReg$IBU, decreasing = TRUE),c("State", "Beer_Name","Beer_ID" ,"ABV","IBU","Ounces","Style","Brewery_Name", "City")]
#kable(o2[1:10,])
o2[1:10,]
```

    ##      State                       Beer_Name Beer_ID   ABV IBU Ounces
    ## 1824    OR       Bitter Bitch Imperial IPA     980 0.082 138     12
    ## 2203    VA              Troopers Alley IPA    1676 0.059 135     12
    ## 1056    MA                   Dead-Eye DIPA    2067 0.090 130     16
    ## 1691    OH Bay of Bengal Double IPA (2014)    2440 0.089 126     12
    ## 1345    MN                    Abrasive Ale      15 0.097 120     16
    ## 2213    VT                    Heady Topper    1111 0.080 120     16
    ## 2214    VT                    Heady Topper     379 0.080 120     16
    ## 2035    TX                    More Cowbell    2123 0.090 118     16
    ## 202     CA                   Blazing World    1492 0.065 115     16
    ## 570     DC      On the Wings of Armageddon     851 0.092 115     12
    ##                               Style                       Brewery_Name
    ## 1824 American Double / Imperial IPA            Astoria Brewing Company
    ## 2203                   American IPA         Wolf Hills Brewing Company
    ## 1056 American Double / Imperial IPA           Cape Ann Brewing Company
    ## 1691 American Double / Imperial IPA Christian Moerlein Brewing Company
    ## 1345 American Double / Imperial IPA              Surly Brewing Company
    ## 2213 American Double / Imperial IPA                      The Alchemist
    ## 2214 American Double / Imperial IPA                      The Alchemist
    ## 2035 American Double / Imperial IPA      Buffalo Bayou Brewing Company
    ## 202        American Amber / Red Ale                  Modern Times Beer
    ## 570  American Double / Imperial IPA            DC Brau Brewing Company
    ##                 City
    ## 1824         Astoria
    ## 2203        Abingdon
    ## 1056      Gloucester
    ## 1691      Cincinnati
    ## 1345 Brooklyn Center
    ## 2213       Waterbury
    ## 2214       Waterbury
    ## 2035         Houston
    ## 202        San Diego
    ## 570       Washington

### ABV IBU Relationship

ABV and IBU appear to be related, which is reasonable. The association is strong but not very powerful, in the sense that a large increase of IBU values are associated with a small increase in ABV despite being very likely to be associated with higher ABV.

``` r
ggplot(dat=AllBeerReg, aes(x=IBU, y=ABV)) + 
  geom_point(shape=16) + 
  geom_smooth(method=lm) + theme_minimal() 
```

    ## Warning: Removed 1005 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 1005 rows containing missing values (geom_point).

![](CaseStudy1BootstrapDoc_files/figure-markdown_github/ABV.v.IBU-1.png)

Summary and Conclusions
-----------------------

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
