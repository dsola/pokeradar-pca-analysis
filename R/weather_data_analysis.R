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

## Delete the sunset and sunrise information because you can only compare this variables with appearings at the same time region
## and the problem gets a complexity that we want to avoid
sunsetTimeCols <- subset(appearColNames, grepl("sunsetMinute|sunsetHour", appearColNames))
appearsProcessed[, sunsetTimeCols] <- NULL

## Delete the sunset and sunrise information because you can only compare this variables with appearings at the same time region
## and the problem gets a complexity that we want to avoid
sunriseTimeCols <- subset(appearColNames, grepl("sunriseHour|sunriseMinute", appearColNames))
appearsProcessed[, sunriseTimeCols] <- NULL

## Transform temperature as category variable

## Transform windSpeed as category variable