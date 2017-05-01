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
appearsProcessed$appearedDayOfWeek <- apply(appearsProcessed, 1, defineDayOfWeek)
appearsProcessed$appearedDayOfWeek <- as.factor(appearsProcessed$appearedDayOfWeek)

summary(appearsProcessed$appearedTimeOfDay) #Looks good :)

### I think the appearedLocalTime is not a good variable to analyze because it's difficult to find occurences
appearsProcessed$appearedLocalTime <- NULL