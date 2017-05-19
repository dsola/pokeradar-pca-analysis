library(FactoMineR);
source("R/functions.R")

## Load the dataset
appears <- read.csv("data/300k.csv",header=T, check.names = FALSE)

## Define the number of rows to analyze
nRows <- 10000
## Display the columns
appearColNames <- colnames(appears)

## You can increase the memory limit using memory.limit(size) (not available in Linux/Mac)

## Store 10000 random observations into another variable to start the pre-processing
appearsProcessed <- appears[sample(1:nRows, replace = TRUE),]

## Transform co-occurrence to numeric variables
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appearsProcessed[, coocMatches] <- lapply(appearsProcessed[, coocMatches], as.numeric)

## I don't know the reference of the X_id identifier, so we can delete it.
appearsProcessed$X_id <- NULL
appearsProcessed$'_id' <- NULL

# Let's analyze the time data!
source("R/processing/time_data_analysis.R")

# Let's analyze the location data!
source("R/processing/location_data_analysis.R")

# Let's analyze the wather data!
source("R/processing/weather_data_analysis.R")

## Delete the class because we are focus on the co-occurrence
#appearsProcessed$class <- NULL
## Pokemon ID represents the same than class...
appearsProcessed$pokemonId <- NULL

## Execute the PCA analysis
source("R/PCA/init.R")

## Execute the MCA analysis
source("R/MCA/init.R")