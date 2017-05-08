
Psi = pca.desp$ind$coord

# CLUSTERING DE LOS COCHES SEGUN SUS CARACTERISTICAS TECNICAS

# CALCULO DE LA MATRIZ DE DISTANCIAS ENTRE COCHES A PARTIR DE LAS LAS COMPONENTES SIGNFICATIVAS
dist.appears <- dist(Psi)

# CLUSTERING JERARQUICO, METODO DE Ward
hclus.appears <- hclust(dist.appears,method="ward.D2")

# PLOT DEL ARBOL JERAQUICO OBTENIDO
plot(hclus.appears,cex=0.3)

# DIAGRAMA DE BARRAS DEL INDICE DE AGREGACION DE LAS ULTIMAS 29 AGREGACIONES FORMADAS
barplot(hclus.appears$height[(nrow(appearsProcessed)-30):(nrow(appearsProcessed)-1)])

# CUANTAS CLASES (CLUSTERS) DE APARICIONES HAY?
nc = 10

# CORTE DEL ARBOL DE AGREGACION EN nc CLASES
cut6 <- cutree(hclus.appears,nc)

# GRAFICO DE LAS nc CLASES EN EL PRIMER PLANO FACTORIAL
plot(Psi[,1],Psi[,2],type="n",main="Clustering of Pokémn appears in 10 classes")
text(Psi[,1],Psi[,2],col=cut6,labels="pokemonId",cex = 0.6)
abline(h=0,v=0,col="gray")
legend("topleft",c("c1","c2","c3","c4","c5","c6"),pch=20,col=c(1:10))

# NUMERO DE APARICIONES POR CLASE
table(cut6)

# CALIDAD DEL CORTE DEL ARBOL JERARQUICO

cdg <- aggregate(as.data.frame(Psi),list(cut6),mean)[,2:(nd+1)]
cdg

Bss <- sum(rowSums(cdg^2)*as.numeric(table(cut6)))
Tss <- sum(Psi^2)

100*Bss/Tss


# CONSOLIDACION DE LA PARTICION

# CALCULO DE LOS CENTROIDES DE LAS nc CLASES OBTENIDAS POR CORTE DEL ARBOL JERARQUICO
cdg.nc <- aggregate(as.data.frame(Psi),list(cut6),mean)[,2:(nd+1)]


# ALGORITMO kmeans CON CENTROS INICIALES EN LOS CENTROIDES cdg.nc
kmeans <- kmeans(Psi,centers=cdg.nc)

# NUMERO DE COCHES POR CLASE FINAL
kmeans$size

# CALIDAD DE LA PARTICION FINAL EN 10 CLASSES

100*kmeans$betweenss/kmeans$totss

# VISUALIZACION DE LAS nc CLASES FINALES EN EL PRIMER PLANO FACTORIAL
plot(Psi[,1],Psi[,2],type="n",main="Clustering of Pokémon appears in 10 classes")
text(Psi[,1],Psi[,2],col=kmeans$cluster,labels="pokemonId",cex = 0.6)
abline(h=0,v=0,col="gray")
legend("topleft",c("c1","c2","c3","c4","c5","c6"),pch=20,col=c(1:10))