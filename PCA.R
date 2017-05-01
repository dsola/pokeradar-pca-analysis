library(FactoMineR);

## Load the dataset
appears <- read.csv("dataset/300k.csv",header=T)
## Display the columns
str(appears)
appearColNames <- colnames(appears)
appearsProcessed <- appears

## Delete co-occurrence because it's not necessary to generate a PCA
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appearsProcessed[, coocMatches] <- NULL

## I don't know the reference of the identifier X_id, so we can delete it.
appearsProcessed$X_id <- NULL

####################### TIME DATA #################################################
## The information about the appeared time it's splitted in different variables
###################################################################################
### appearedLocalTime (continuous variable)
### appearedHour (continous variable, included in appeared Local time) 
### appearedMonth (character variable, included in appeared Local time)
### appearedYear (continous variable, included in appeared Local time)
### appearedDay (continous variable, included in appeared Local time)
### appearedDayOfWeek (factor variable, included in appeared Local time)
### appearedTimeOfDay (factor variable, can be extracted from appeared Local time)
###################################################################################

## Check different years (ignore if it's always the same)
unique(appears$appearedYear) # Only one value, so we can delete from dataset
appearsProcessed$appearedYear <- NULL

## Check different months (ignore if it's always the same)
unique(appears$appearedMonth) # Only one value, so we can delete from dataset
appearsProcessed$appearedMonth <- NULL

### Take a look to the continous variables
hist(appearsProcessed$appearedHour, main="Histogram of appeared hours")
boxplot(appearsProcessed$appearedHour, main="Box Plot of appeared hours")

hist(appearsProcessed$appearedDay, main="Histogram of appeared days")
boxplot(appearsProcessed$appearedDay, main="Box Plot of appeared days")
### The distribution of this variables appears to be significant, I think it's not necessary to manipulated

## Now let's take a look to the factor variables
summary(appearsProcessed$appearedDayOfWeek) #WTF dummy_day means? I suppose it's a NA
## We can get this info without NA's
defineDayOfWeek <- function(appear){
  date <- as.Date(appear["appearedLocalTime"], format='%Y-%m-%dT%H:%M:%S')
  format.Date(date,"%A")
}
appearsProcessed$appearedDayOfWeek <- apply(appearsProcessed, 1, defineDayOfWeek)
appearsProcessed$appearedDayOfWeek <- as.factor(appearsProcessed$appearedDayOfWeek)

summary(appearsProcessed$appearedTimeOfDay) #Looks good :)

### I think the appearedLocalTime is not a good variable to analyze because it's difficult to find occurences
appearsProcessed$appearedLocalTime <- NULL

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