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

#Transform all the factor variables to numeric variables
## TODO: implement this logic with factorVariables and a loop
appearsPCAProcessed <- appearsProcessed
appearsPCAProcessed$appearedTimeOfDay <- as.numeric(appearsPCAProcessed$appearedTimeOfDay)
appearsPCAProcessed$appearedDayOfWeek <- as.numeric(appearsPCAProcessed$appearedDayOfWeek)
appearsPCAProcessed$terrainType <- as.numeric(appearsPCAProcessed$terrainType)
appearsPCAProcessed$closeToWater <- as.numeric(appearsPCAProcessed$closeToWater)
appearsPCAProcessed$city <- as.numeric(appearsPCAProcessed$city)
appearsPCAProcessed$continent <- as.numeric(appearsPCAProcessed$continent)
appearsPCAProcessed$pressure <- as.numeric(appearsPCAProcessed$pressure)
appearsPCAProcessed$weatherIcon <- as.numeric(appearsPCAProcessed$weatherIcon)
appearsPCAProcessed$class <- as.numeric(appearsPCAProcessed$class)
appearsPCAProcessed$urbanization <- as.numeric(appearsPCAProcessed$urbanization)
appearsPCAProcessed$sunsetTime <- as.numeric(appearsPCAProcessed$sunsetTime)
appearsPCAProcessed$sunriseTime <- as.numeric(appearsPCAProcessed$sunriseTime)

# We have to choose the active variables
## Factor variables -> city, closeToWater, continent, weatherIcon, class, urbanization, appearedDayOfWeek
## Continous variables -> gymDistanceKm, pokestopDistanceKm, appearedHour

#Execute the PCA
pca.desp <- PCA(
  appearsPCAProcessed, 
  quanti.sup=c(1,11,12,13,14,20,21), 
  quali.sup=c(2,4,6),
  grap=TRUE,
  nc=11
)


## Plot of individuals
plot(pca.desp, axes = c(1,2), choix = c("ind"), label="quali", title="Plot of individuals", cex=0.7)
## Plot of variables
plot(pca.desp, axes = c(1,2), choix = c("var"), title="Plot of variables")

## Now we are looking for the real number of significant dimensions

# Representation for the Screenplot
eigenValues <- pca.desp$eig
barplot(eigenValues[,2], names.arg=1:nrow(eigenValues), 
        main = "Variances",
        xlab = "Principal Components",
        ylab = "Percentage of variances",
        col ="steelblue")
## Add connected line segments to the plot
lines(x = 1:nrow(eigenValues), eigenValues[, 2], 
      type="b", pch=19, col = "red")
## you can look the eig values as well.
attributes(pca.desp)
pca.desp$eig

## Rotation looking for the latent concepts
## We decide to get 6 significant variables applying the elbow rule
pca.desp.rot <- varimax(pca.desp$var$cor[,1:6])
pca.desp.rot
