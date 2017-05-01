####################### LOCATION DATA #################################################
## The information about the location where Pokémon appeared
###################################################################################
### "rural","midurban","suburban","urban" (boolean variable) -> defines the population density
### latitude, longitude (continous variable) -> included in appeared Local time
### gymInXm (boolean variable) -> defines if the distance from a gym is greater than a value
### gymDistanceKm (continous variable) -> defines the distance from a gym
### pokestopInX (boolean variable) -> defines if the distance from a pokestop is greater than a value
### pokestopDistanceKm (boolean variable) -> defines the distance from a pokestop
### closeToWater (boolean variable) - defines if the position it's close to the Water
### population_density (continous variable) - what is the population density per square km
## TerrainType (continous type) - http://glcf.umd.edu/data/lc/
###################################################################################

## Join (urban, suburban, midurban and rural) to only one factor variable
appearsProcessed[1:100,c("urban","suburban","midurban","rural")] # Not sure to transform it, because a row can be multiple values
unique(appearsProcessed[,c("urban","suburban","midurban","rural")]) # Check the posible combinations
urbanColNames <- c("rural","midurban","suburban","urban")
appearsProcessed$urbanization <- apply(appears[,urbanColNames], 1, defineUrban)
appearsProcessed$urbanization <- as.factor(appearsProcessed$urbanization)
appearsProcessed[,urbanColNames] <- NULL
## This variable represents the factorization of population_density, so population_density can be excluded
## from our dataset because we are not interested in the specific number of population
appearsProcessed$population_density <- NULL

## Delete gymInXm because it's informed in gymDistanceKm
gymInMatches <- subset(appearColNames, grepl("gymIn", appearColNames))
appearsProcessed[, gymInMatches] <- NULL

## Delete pokestopInX because it's informed in pokestopDistanceKm
pokestopInMatches <- subset(appearColNames, grepl("pokestopIn", appearColNames))
appearsProcessed[, pokestopInMatches] <- NULL
## Transform PokestopDistanceKm into continous variable
appearsProcessed$pokestopDistanceKm <- as.integer(appearsProcessed$pokestopDistanceKm)

### Transform terrain Type variable to understanding factor variable
appearsProcessed$terrainType <- apply(appearsProcessed, 1, transformTerrainType)
appearsProcessed$terrainType <- as.factor(appearsProcessed$terrainType)

## The location coordinates are not relevant for this study
locationCoordinatesMatches <- subset(appearColNames, grepl("cellId|latitude|longitude", appearColNames))
appearsProcessed[, locationCoordinatesMatches] <- NULL