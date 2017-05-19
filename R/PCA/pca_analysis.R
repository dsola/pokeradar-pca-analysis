#Let's execute the PCA analysis with the factorMineR tools
# We have to standarize the variables because they are represented by different measure units
factorVariables <- c(
  "appearedTimeOfDay", "appearedDayOfWeek", 
  "terrainType", "closeToWater", "continent",
  "pressure", "weatherIcon", "class", "urbanization", "sunsetTime", "sunriseTime"
)
numericVariables <- c(
  "appearedHour", "appearedMinute", "appearedDay",
  "temperature", "windSpeed", "windBearing", "gymDistanceKm", "pokestopDistanceKm"
)

# Delete all the factor Variables because they distort on the analysis
appearsPCAProcessed <- appearsProcessed

## Delete the class because we are focus on the co-occurrence
appearsPCAProcessed$class <- NULL

# We have to choose the active variables
## Factor variables -> city, closeToWater, continent, weatherIcon, class, urbanization, appearedDayOfWeek
## Continous variables -> gymDistanceKm, pokestopDistanceKm, appearedHour
numberOfDimensions = 5
#Execute the PCA
pca.desp <- PCA(
  appearsPCAProcessed, 
  quali.sup=c(1:12,163:165)
  #ncp=numberOfDimensions
)


## Plot of individuals
plot(pca.desp, axes = c(1,2), choix = c("ind"), label="quali", title="Plot of individuals", cex=0.7)
## Plot of variables
plot(pca.desp, axes = c(1,2), choix = c("var"), title="Plot of variables")

#####################################################################
### Now we are looking for the real number of significant dimensions
#####################################################################

# Representation for the Screenplot
eigenValues <- pca.desp$eig
barplot(eigenValues[,2], names.arg=1:nrow(eigenValues), 
        main = "Variances",
        xlab = "Principal Components",
        ylab = "Percentage of variances",
        col ="steelblue",
        type="l")
## Add connected line segments to the plot
lines(x = 1:nrow(eigenValues), eigenValues[, 2], 
      type="b", pch=19, col = "red")
## you can look the eig values as well.
attributes(pca.desp)
pca.desp$eig

## Rotation looking for the latent concepts
## We decide to get 8 significant variables applying the elbow rule
pca.desp.rot <- varimax(pca.desp$var$cor[,1:8])
pca.desp.rot
