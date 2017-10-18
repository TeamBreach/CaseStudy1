######################################
#  Case Study 1 Makefile
#  Arturo Casillas & Kevin Dickens
#  Created: October 18, 2017
#  Updated: October 18, 2017
######################################

#Set working directory
setwd("C:/Users/acasi/Documents")

#Raw Data
* Beers.csv # Raw dataset 1 of 2 used for the primary analysis questions of this project.
* Breweries.csv # Raw dataset 2 of 2 used for the primary analysis questions of this project.

#Code for analysis and data cleanup
## Gather and cleanup raw data files
## Merge our two data
## Produce our analyis including maps
* source("CaseStudy1CombinedCode1.R") - Code used to clean, merge, and analyze the data as well as prepare plots

#Presentation
## This is an R markdown file that is selfcontained
## Changes to the code will not automatically pass to the markdown file
* source("CaseStudy1BootstrapDoc.Rmd") - Markdown file that is used to generate the presentation.