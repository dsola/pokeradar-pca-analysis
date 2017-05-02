library(FactoMineR);
source("R/functions.R")

## Load the dataset
appears <- read.csv("data/300k.csv",header=T)
## Define the number of rows to analyze
nRows <- 1000
## Display the columns
appearColNames <- colnames(appears)
## Store 1000 random observations into another variable to start the pre-processing
appearsProcessed <- appears[sample(1:nRows),]

## Delete co-occurrence because it's not necessary to generate a PCA
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appearsProcessed[, coocMatches] <- NULL

## I don't know the reference of the identifier X_id, so we can delete it.
appearsProcessed$X_id <- NULL

# Let's analyze the time data!
source("R/time_data_analysis.R")

# Let's analyze the location data!
source("R/location_data_analysis.R")

# Let's analyze the wather data!
source("R/weather_data_analysis.R")

## Convert the class attribute into factor variable
appearsProcessed$class <- as.factor(appearsProcessed$class)

## We can get the Pokémon class (I was thinking class was the Pokémon type but it's the speice)

## Execute the PCA analysis
source("R/pca_analysis.R")