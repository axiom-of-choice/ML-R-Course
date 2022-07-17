##install.packages(c("fpc", "NbClust"))

library(cluster)
library(factoextra)
library(fpc)
library(NbClust)

protein <- read.csv("Tema5/data/protein.csv")
rownames(protein) <- protein$Country
protein$Country <- NULL
protein.scaled <- as.data.frame(scale(protein))


##Con este método, podemos saber cuál es el número más óptimo de clusters.
nb <- NbClust(protein.scaled, distance = "euclidean", min.nc = 2, max.nc = 12,
              method = "ward.D2", index = "all")
##Con esto podemos ver gráficamnente cúal es el númer óptimo de clusters
fviz_nbclust(nb) + theme_dark()

##Ahora que lo sabemos, podemos hacer ese número con k-means
##Ponemos el Nstart para que salga un buen cluster
km.res <- kmeans(protein.scaled, 3, nstart = 20)

##La silueta de un cluster k-means
sil.km <- silhouette(km.res$cluster, dist(protein.scaled))
sil.sum <- summary(sil.km)
sil.sum
##Visualización de la silueta de un k-means
fviz_silhouette(sil.km)

##El número de barras es el número de elementos
##El tamaño del cluster
##ave.sil.width es la anchura de la silueta ¿Qué tan compactos están los clusters?
##Es importante pues un cluster debería compactar cosas cerca y separar cosas lejanas
##Sil.width SI está entre -1 y 1. Mientras más cerca de 0 esté, mejor es el clustering

##Cuanto más arriba está un punt (barra) es mejor la asignación de ese elemento en ese cluster


##Matriz de distancias
md <- dist(protein.scaled, method = "euclidean")

##Calculamos los stats
km_stats <- cluster.stats(md, km.res$cluster)

km_stats

##El whithin.cluster.ss
km_stats$within.cluster.ss
##Calcua de cada uno de los elementos de los clusters y el cluster que pertenece
##clust.avg.silwidths
km_stats$clus.avg.silwidths
##Es un promedio de la distancia entre culsters

## 0<dunn<inf
km_stats$dunn
##Se toma la distancia más pequeña entre observaciones que no están en el mismo cluster, dividido
##Por la distancia mayor entre elementos del mismo cluster.
##Se busca maximizarlo para que los clusters queden bien separados y los elementos de cada cluster, bien juntos

kmed <- pam(protein.scaled, 3)

kmed_stats <- cluster.stats(md, kmed$clustering)
kmed_stats$dunn


factoextra::fviz_cluster(km.res, data = protein.scaled)
factoextra::fviz_cluster(kmed, data = protein.scaled)


##Podemos comparar dos clusters con esta función
res.compared <- cluster.stats(md, km.res$cluster,
                              kmed$clustering)

##Y con esto podemos ver qué tanto coinciden los clusters
##-1< corrected.rand <1 y se intenta maximizar
res.compared$corrected.rand

##Con esto vemos la distancia que existe entre dos clusters
##Se trata de minimizar y 0 < vi < inf
res.compared$vi
