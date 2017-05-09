# Get the coordinates of the eigenValues obtained in PCA
Psi = pca.desp$ind$coord
# Calculate the distance matrix between individuals
dist.appears <- dist(Psi)

# the heriarchical clustering tree, using the Ward method
hclus.appears <- hclust(dist.appears,method="ward.D2")
# Generate the plot of the clustering tree
plot(hclus.appears,cex=0.3)

# generate a barplot of aggregation index given the last 30 aggregations in the tree
barplot(hclus.appears$height[(nrow(appearsProcessed)-30):(nrow(appearsProcessed)-1)])

# How many clusters are significative? (Using the elbow rule in barplot)
numberOfClasses <- 8

# Obtain the tree to get numberOfClasses classes
cuttedTree <- cutree(hclus.appears,numberOfClasses)

# Generate a plot with the selected classes in a factorial space
plot(Psi[,1],Psi[,2],type="n",main="Clustering of Pokémn appears in 10 classes")
text(Psi[,1],Psi[,2],col=cuttedTree,labels="pokemonId",cex = 0.6)
abline(h=0,v=0,col="gray")
legend("topleft",c("c1","c2","c3","c4","c5","c6","c7","c8"),pch=20,col=c(1:numberOfClasses))

# Number of elements per class
table(cuttedTree)

# Calculate the quality of the tree
cdg <- aggregate(as.data.frame(Psi),list(cuttedTree),mean)[,2:(numberOfDimensions+1)]
Bss <- sum(rowSums(cdg^2)*as.numeric(table(cuttedTree)))
Tss <- sum(Psi^2)
(TreeQuality <- 100*Bss/Tss)


######################################
## CONSOLIDATION
######################################

# Calculate the centers of the classes using the mean
classMeanCenters <- aggregate(as.data.frame(Psi),list(cuttedTree),mean)[,2:(numberOfDimensions+1)]
# Execute the Kmeans Algorihtm with the initial centers obtained in the previous point (classMeanCenters)
kmeans <- kmeans(Psi,centers=classMeanCenters)
# Final number of instances per class
kmeans$size
# Calculate the quality of the tree again
(100*kmeans$betweenss/kmeans$totss)

# Generate a plot with the selected classes in a factorial space
plot(Psi[,1],Psi[,2],type="n",main="Clustering of Pokémon appears in 10 classes")
text(Psi[,1],Psi[,2],col=kmeans$cluster,labels="pokemonId",cex = 0.6)
abline(h=0,v=0,col="gray")
legend("topleft",c("c1","c2","c3","c4","c5","c6","c7","c8"),pch=20,col=c(1:numberOfClasses))