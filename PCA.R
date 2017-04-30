library(FactoMineR);

## Load the dataset
appears <- read.csv("dataset/300k.csv",header=T)
## Display the columns
str(appears)
appearColNames <- colnames(appears)

## Check different years (ignore if it's always the same)
unique(appears$appearedYear) # Only one value, so we can delete from dataset
appears$appearedYear <- NULL

## Check different months (ignore if it's always the same)
unique(appears$appearedMonth) # Only one value, so we can delete from dataset
appears$appearedMonth <- NULL

## Join (urban, suburban, midurban and rural) to only one factor variable

appears[1:100,c("urban","suburban","midurban","rural")] # Not sure to transform it, because a row can be multiple values
unique(appears[,c("urban","suburban","midurban","rural")]) # Check the posible combinations

## Delete gymInXm because it's informed in gymDistanceKm
gymInMatches <- subset(appearColNames, grepl("gymIn", appearColNames))
appears[, gymInMatches] <- NULL

## Delete pokestopInX because it's informed in pokestopDistanceKm
pokestopInMatches <- subset(appearColNames, grepl("pokestopIn", appearColNames))
appears[, pokestopInMatches] <- NULL

## Delete co-occurrence because it's not necessary to generate a PCA
coocMatches <- subset(appearColNames, grepl("cooc_", appearColNames))
appears[, coocMatches] <- NULL

urbanColNames <- c("rural","midurban","suburban","urban")
### Urban -> urban + suburban + midurban
### Suburban -> suburban + midurban
### Rural <- rural
### MidUrban <- midurban

## This function returns the new category variable following the previous rules
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
appearsProcessed <- appears
appearsProcessed$urbanization <- apply(appears[,urbanColNames], 1, defineUrban)
appearsProcessed[,urbanColNames] <- NULL

## The location coordinates are not relevant for this study
locationCoordinatesMatches <- subset(appearColNames, grepl("cellId|latitude|longitude", appearColNames))
appearsProcessed[, locationCoordinatesMatches] <- NULL

## I don't know the reference of the identifier X_id, so we can delete it.
appearsProcessed$X_id <- NULL
