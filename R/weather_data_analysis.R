####################### WEATHER DATA ##############################################
## The information about the weather at the appearing moment of a Pokémon
###################################################################################
### weather (factor variable) -> provides the general information about the weather
### temperature (continous variable) -> temperature in celsius
### windSpeed (continous variable) -> speed of the wind in km/h at the location 
### windBearing (continous variable) -> wind direction
### pressure (continous variable) ->  atmospheric pressure in bar at the location
### weatherIcon (continous variable) ->   compact representation of the weather at the location
### sunriseMinutesMidnight-sunsetMinutesBefore (continous variable) -> time of appearance relatively to sunrise/sunset (splitted by hours and minutes)
###################################################################################

## Check the difference of weather and weatherIcon
unique(appearsProcessed$weather)
unique(appearsProcessed$weatherIcon)
### weather has 26 levels, it's a lot and weather-icon it's compacted. So we can ignored from our study
appearsProcessed$weather <- NULL

## Investigate sunset time variable. We can categorize the sunset time because the sunset hours are between 17 and 20
### we should create the following category variables
### 17, 17:30, 18, 18:30, 19, 19:30, 20, 20:30, 21
sunsetTimeCols <- subset(appearColNames, grepl("sunsetMinute|sunsetHour", appearColNames))
appearsProcessed$sunsetTime <- apply(appearsProcessed[, sunsetTimeCols], 1, getSunsetFactorTime)
appearsProcessed$sunsetTime <- as.factor(appearsProcessed$sunsetTime)
appearsProcessed[, sunsetTimeCols] <- NULL

## Investigate sunset time variable. We can categorize the sunset time because the sunset hours are between 17 and 20
### we should create the following category variables
### 4, 4:30, 5, 5:30, 6, 6:30, 7, 7:30, 8, 8:30
sunriseTimeCols <- subset(appearColNames, grepl("sunriseHour|sunriseMinute", appearColNames))
appearsProcessed$sunriseTime <- apply(appearsProcessed[, sunriseTimeCols], 1, getSunriseFactorTime)
appearsProcessed$sunriseTime <- as.factor(appearsProcessed$sunriseTime)
appearsProcessed[, sunriseTimeCols] <- NULL
