library(FactoMineR);

## Load the dataset
appears <- read.csv("data/300k.csv",header=T)
## Display the columns
str(appears)
appearColNames <- colnames(appears)
appearsProcessed <- appears

## Delete co-occurrence because it's not necessary to generate a PCA
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appearsProcessed[, coocMatches] <- NULL

## I don't know the reference of the identifier X_id, so we can delete it.
appearsProcessed$X_id <- NULL

# Let's analyze the time data!
source("R/time_data_analysis.R")

# Let's analyze the location data!
source("R/location_data_analysis.R")