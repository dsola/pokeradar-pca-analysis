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

#Transform dataframe to matrix
appearsMatrix <- matrix(unlist(appearsProcessed), ncol = length(appearsProcessed), byrow = TRUE)
#Execute the PCA
pca.desp <- PCA(
  appearsMatrix, 
  quali.sup=c(2,5,7,8,9,10,15,18,19,20,21), 
  quanti.sup=c(3,4,6,8,11,12,13,14,16), 
  scale.unit=T,
  graph = TRUE
)
attributes(pca.desp)
pca.desp$eig

#Representation for the Screenplot
pca.desp$ind$coor
plot(pca.desp$eig$eigenvalue, type="l")

#3
## Sin rotar
pca.desp$var$cor