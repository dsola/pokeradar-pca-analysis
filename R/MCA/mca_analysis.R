appearsMCAProcessed <- appearsProcessed
# Delete the numeric variables
appearsMCAProcessed[, coocMatches] <- NULL
appearsMCAProcessed$class <- as.factor(appearsMCAProcessed$class)
res.MCA = MCA(appearsMCAProcessed, quali.sup=13)

plot.MCA(res.MCA, invisible=c("var","quali.sup"), cex=0.7)
plot.MCA(res.MCA, invisible=c("ind","quali.sup"), cex=0.7)
plot.MCA(res.MCA, invisible=c("ind"))
plot.MCA(res.MCA, invisible=c("ind", "var"))