####################### LOCATION DATA #################################################
## The information about the location where Pokémon appeared
###################################################################################
### "rural","midurban","suburban","urban" (boolean variable) -> defines the population density
### latitude, longitude (continous variable) -> included in appeared Local time
### gymInXm (boolean variable) -> defines if the distance from a gym is greater than a value
### gymDistanceKm (continous variable) -> defines the distance from a gym
### pokestopInX (boolean variable) -> defines if the distance from a pokestop is greater than a value
### pokestopDistanceKm (boolean variable) -> defines the distance from a pokestop
###################################################################################

## Join (urban, suburban, midurban and rural) to only one factor variable
appearsProcessed[1:100,c("urban","suburban","midurban","rural")] # Not sure to transform it, because a row can be multiple values
unique(appearsProcessed[,c("urban","suburban","midurban","rural")]) # Check the posible combinations
urbanColNames <- c("rural","midurban","suburban","urban")
### Urban -> urban + suburban + midurban
### Suburban -> suburban + midurban
### Rural <- rural
### MidUrban <- midurban
### This function returns the new category variable following the previous rules
defineUrban <- function(appear){
  if (appear["rural"] == "true") { 
    "rural"
  } else if (appear["midurban"] == "true" && appear["suburban"] == "true"&& appear["urban"] == "true") {
    "urban"
  } else if (appear["midurban"] == "true" && appear["suburban"] == "true") {
    "suburban"
  } else {
    "midurban"
  }
}

appearsProcessed$urbanization <- apply(appears[,urbanColNames], 1, defineUrban)
appearsProcessed$urbanization <- as.factor(appearsProcessed$urbanization)
appearsProcessed[,urbanColNames] <- NULL

## Delete gymInXm because it's informed in gymDistanceKm
gymInMatches <- subset(appearColNames, grepl("gymIn", appearColNames))
appearsProcessed[, gymInMatches] <- NULL

## Delete pokestopInX because it's informed in pokestopDistanceKm
pokestopInMatches <- subset(appearColNames, grepl("pokestopIn", appearColNames))
appearsProcessed[, pokestopInMatches] <- NULL

## The location coordinates are not relevant for this study
locationCoordinatesMatches <- subset(appearColNames, grepl("cellId|latitude|longitude", appearColNames))
appearsProcessed[, locationCoordinatesMatches] <- NULL