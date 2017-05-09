library(FactoMineR);
source("R/functions.R")

## Load the dataset
appears <- read.csv("data/300k.csv",header=T, check.names = FALSE)
## Define the number of rows to analyze
nRows <- 10000
## Display the columns
appearColNames <- colnames(appears)
## Store 10000 random observations into another variable to start the pre-processing
appearsProcessed <- appears[sample(1:nRows, replace = TRUE),]

## Delete co-occurrence because it's not necessary to generate a PCA
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appearsProcessed[, coocMatches] <- NULL

## I don't know the reference of the X_id identifier, so we can delete it.
appearsProcessed$X_id <- NULL
appearsProcessed$'_id' <- NULL

# Let's analyze the time data!
source("R/time_data_analysis.R")

# Let's analyze the location data!
source("R/location_data_analysis.R")

# Let's analyze the wather data!
source("R/weather_data_analysis.R")

## Convert the class attribute into factor variable
appearsProcessed$class <- as.factor(appearsProcessed$class)
## Pokemon ID represents the same than class...
appearsProcessed$pokemonId <- NULL

## TODO: Add if the Pokémon is rare, the Pokémon type or the pokemon habitats


## Execute the PCA analysis
source("R/pca_analysis.R")

# Execute the clustering analysis
source("R/clustering.R")

# Execute the profiling analysis
source("R/profiling.R")


