
## Codebook for Case Study 1

### Data Selection
The original data came in two files:  Beer.csv & Breweries.csv.  The tables contain a list of 2410 US craft beers and 510 US breweries.  These tables contain header information.   The beer data corresponds to craft beers available in cans and lists the beer ID number, the size of the can in ounces, style of beer, percent alcohol per volume (ABV), and international bitterness units (IBU) as well as the beer name and brewery ID.The Breweries data lists breweries by location of state and city along with a unique ID. This data was traced to CraftCans.com and further traced to the Brewers Association (BA). A more expansive data set is available to Brewers Association members.

To prepare the data for analysis, variable names are altered for clarity and to minimize merging issues. The beers and breweries are linked by a unique numeric ID (Brew_ID), so no assumptions or algorithm was needed to combine the tables.

### Variables & Descriptions

#### Beers.csv

| Original Name | Description |
| :------------:| :---------- |
| Name | The name of the beer. |
| Beer_ID | A unique ID given to a specific brew of beer.  Beers may have the same name but different IDs due to the year they were brewed. |
| ABV | Alcohol by Volume.  A ratio of number of millilitres (mL) of pure ethanol present in 100 mL of solution at 20 °C (68°F). |
| IBU | International Bitterness Units.  A measure of bitterness affecting chemicals in the beer.  Typical values are between 5 and 120. |
| Brewery_ID | The unique brewery ID given to each brewery for tracking purposes. |
| Style | The brewing and/or fermentation style of the beer. |
| Ounces | The number of fluid ounces for a single can of the described beer. |

#### Breweries.csv

| Original Name | Description |
| :------------:| :---------- |
| Brew_ID | A unique brewery ID given to each brewery for tracking purposes. |
| Name | The name of the brewery. |
| City | The city name for the location of the brewery. |
| State | The two letter state code of each US state and the District of Columbia. |

### Code to obtain tidy data set
```r
## Prepare for merging ##
names(rawbeers)[5] = "Brew_ID"  #Rename 'Brewery_id' to ease merging
names(rawbeers)[1] = "Beer_Name" #Rename 'Name' to 'Beer_Name' to avoid confusion with brewery name or state
names(rawbreweries)[2] = "Brewery_Name"  #Rename 'Name' to 'Brewery_Name' avoid confusion and ease merging

## Merge Data ##
AllBeer <- merge(rawbeers, rawbreweries, by="Brew_ID")
str(AllBeer)
levels(AllBeer$State)=trimws(levels(AllBeer$State), which = c("left"))  #Trim the leadig spaces from state abbreviation
```

### Table of variable names
| Variable Number | Original Name | Cleaned Name |
| :-------------: | :------------:| :----------: |
| 1 | Brewery_ID | Brew_ID |
| 2 | Name | Brew_Name |
| 3 | Name | Brewery_Name |
