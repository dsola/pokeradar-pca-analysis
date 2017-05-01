#Let's execute the PCA analysis with the factorMineR tools
# We have to standarize the variables because they are represented by different measure units
factorVariables <- c(
  "appearedTimeOfDay", "appearedDayOfWeek", 
  "terrainType", "closeToWater", "city", "continent",
  "pressure", "weatherIcon", "class", "urbanization", "sunsetTime", "sunriseTime"
)
numericVariables <- c(
  "appearedHour", "appearedMinute", "appearedDay",
  "temperature", "windSpeed", "windBearing", "gymDistanceKm", "pokestopDistanceKm"
)
appearColNames <- colnames(appearsProcessed)
#Transform dataframe to matrix
appearsMatrix <- as.matrix(appearsProcessed, ncol=length(appearColNames),  byrow = TRUE)
pca.desp <- PCA(
  appearsMatrix, 
  quali.sup=c(2,5,7,8,9,10,15,18,19,20,21), 
  quanti.sup=c(3,4,6,8,11,12,13,14,16), 
  scale.unit=T,
  graph = TRUE
)
