***
## Case Study 1 - Beer Research

### Created October 3rd, 2017

##### Team Breach is an analysis team formed by Arturo Casillas and Kevin Dickens.
---
| Responsibilities | Analyst |
| :--------------: | :-----: |
| Presentation Files | Arturo |
| Maps | Kevin |
| HTML Formatting | Arturo |
| Makefile | Arturo |
| Introduction | Kevin |
| Spatial Conclusion | Kevin |
| Statistical Conclusion | Arturo |
| Tidy Data | Both |
| Readme | Kevin |
| Codebook | Kevin |
| Analysis | Both |

## Organization
### Folder Structure
---
This repo contains the following folders:
* Code - Code repository.
  * Archive - Archive of older code either left unused or moved to archive after reconciliation of code files.
* Data - Raw data used for this project as well as various data exports
* Presentation - Files for presentation.
  * Archive - General Archive for Presentation files
  * CaseStudy1DummyRMDArturo_files
    * figure-html - Archive presentation files.
  * TestPresentation-figure - Test output folder

### Files
---
This section will detail the files that appear in this repo and their description.

### Code Folder
---
The code folder contains the following files:

* CaseStudy1CodeArturo.R
* CaseStudy1CombinedCode1.R
* Dickens_casestudy1.R
* Importfile.R
* Makefile.R

#### Code/Archive Folder
The following files are located within the Archive subfolder:
* map_testcode.R

### Data Folder
---
* Beers.csv - Raw dataset 1 of 2 used for the primary analysis questions of this project.
* Breweries.csv - Raw dataset 2 of 2 used for the primary analysis questions of this project.
* all-geocodes-v2016.csv - Geocodes.  Unused but kept for future analysis.
* median_beer.csv - Edited Test dataset used for map generation testing prior to StateName function implementation.
* mergeddata.csv - Final merged dataset of the two primary sources for analysis.
* state-geocodes-v2016.csv - State geocodes.  Unused but kept for future analysis.

### Presentation Folder
---
The presentation folder contains numerous files used for knitting together the file presentation such as:
* ABV_Map.jpeg - Image of the ABV by State map.
* Breweries.jpeg	- Image of the Breweries by State map.
* CaseStudy1BootstrapDoc.Rmd - RMD that generates the HTML file of the same name.
* CaseStudy1BootstrapDoc.html - Primary presentation output.
* Casestudy1BootstrapDoc.md - presentation viewable on Github.
* IBU_Map.jpeg - Image of the IBU by State map.
* TestPresentation.Rpres
* TestPresentation.md

#### Presentation/Archive Folder
The following files are located within the Archive subfolder:
* CaseStudy1Beamer.Rmd
* CaseStudy1Beamer.html
* CaseStudy1Beamer.md
* CaseStudy1Beamer.pdf
* CaseStudy1DummyRMDArturo.Rmd
* CaseStudy1DummyRMDArturo.html
* CaseStudy1DummyRMDArturo.md
* CS1minimalisticPresentation.Rmd
* CS1minimalisticPresentation.html
* CS1minimalisticPresentation.md

#### CaseStudy1DummyRMDArturo_files/figure-html Folder
* plot1-1.png - Presentation graphics (scatter plot).
* plot2-1.png - Presentation graphics (scatter plot).
* unnamed-chunk-1-1.png - Presentation graphics (bar plot).
* unnamed-chunk-2-1.png - Presentation graphics (bar plot).
* unnamed-chunk-2-2.png - Presentation graphics (bar plot).
* unnamed-chunk-3-1.png - Presentation graphics (bar plot).

#### CS1minimalisticPresentation/figure-html Folder
* plot1-1.png - Presentation graphics (scatter plot).
* plot2-1.png - Presentation graphics (scatter plot).
* unnamed-chunk-1-1.png - Presentation graphics (bar plot).
* unnamed-chunk-2-1.png - Presentation graphics (bar plot).
* unnamed-chunk-2-2.png - Presentation graphics (bar plot).
* unnamed-chunk-3-1.png - Presentation graphics (bar plot).

#### TestPresentation-figure Folder
* unnamed-chunk-2-1.png - Archive presentation graphic.

## This repo also contains a codebook explaining variable names and data transformation performed on original data for the purposes of creating tidy data for analysis.
