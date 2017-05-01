### Urban -> urban + suburban + midurban
### Suburban -> suburban + midurban
### Rural <- rural
### MidUrban <- midurban
### This function returns the new category variable following the previous rules
defineUrban <- function(appear){
  if (appear["rural"] == "true") { 
    "rural"
  } else if (appear["midurban"] == "true" && appear["suburban"] == "true" && appear["urban"] == "true") {
    "urban"
  } else if (appear["midurban"] == "true" && appear["suburban"] == "true") {
    "suburban"
  } else {
    "midurban"
  }
}

defineDayOfWeek <- function(appear){
  date <- as.Date(appear["appearedLocalTime"], format='%Y-%m-%dT%H:%M:%S')
  format.Date(date,"%A")
}

#http://glcf.umd.edu/data/lc/
terrainTypeConversions[1] <- "Water"
terrainTypeConversions[2] <- "Evergreen Needleleaf forest"
terrainTypeConversions[3] <- "Evergreen Broadleaf forest"
terrainTypeConversions[4] <- "Deciduous Needleleaf forest"
terrainTypeConversions[5] <- "Deciduous Broadleaf forest"
terrainTypeConversions[6] <- "Mixed forest"
terrainTypeConversions[7] <- "Closed shrublands"
terrainTypeConversions[8] <- "Open shrublands"
terrainTypeConversions[9] <- "Woody savannas"
terrainTypeConversions[10] <- "Savannas"
terrainTypeConversions[11] <- "Grasslands"
terrainTypeConversions[12] <- "Permanent wetlands"
terrainTypeConversions[13] <- "Croplands"
terrainTypeConversions[14] <- "Urban and built-up"
terrainTypeConversions[15] <- "Cropland/Natural vegetation mosaic"
terrainTypeConversions[16] <- "Snow and ice"
terrainTypeConversions[17] <- "Barren or sparsely vegetated"

# TODO: improve this function
transformTerrainType <- function(appear) {
  terrainType <- as.integer(appear["terrainType"])
  if (terrainType == 0) "Water"
  else if (terrainType == 1) "Evergreen Needleleaf forest"
  else if (terrainType == 2) "Evergreen Broadleaf forest"
  else if (terrainType == 3) "Deciduous Needleleaf forest"
  else if (terrainType == 4) "Deciduous Broadleaf forest"
  else if (terrainType == 5) "Mixed forest"
  else if (terrainType == 6) "Closed shrublands"
  else if (terrainType == 7) "Open shrublands"
  else if (terrainType == 8) "Woody savannas"
  else if (terrainType == 9) "Savannas"
  else if (terrainType == 10) "Grasslands"
  else if (terrainType == 11) "Permanent wetlands"
  else if (terrainType == 12) "Croplands"
  else if (terrainType == 13) "Urban and built-up"
  else if (terrainType == 14) "Cropland/Natural vegetation mosaic"
  else if (terrainType == 15) "Snow and ice"
  else if (terrainType == 16) "Barren or sparsely vegetated"
  else "Unknown"
}

getFactorTime <- function(hours, minutes) {
  hoursChar <- as.character(hours)  
  if (minutes < 30) {
    hoursChar
  }
  else if (minutes < 45) {
    paste(hoursChar, "30", sep=":")
  }
  else {
    nextHour <- as.integer(hours) + 1
    as.character(nextHour)
  }
}

getSunsetFactorTime <- function(appear) {
  getFactorTime(appear["sunsetHour"], appear["sunsetMinute"])
}

getSunriseFactorTime <- function(appear) {
  getFactorTime(appear["sunriseHour"], appear["sunriseMinute"])
}