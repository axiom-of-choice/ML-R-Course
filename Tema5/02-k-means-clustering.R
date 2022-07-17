##El k-means-clustering es un método que se utiliza para realizar k clusters basado en 
##que un elemento pertenece al grupo cuyo valor medio es más cercano

protein <- read.csv("Tema5/data/protein.csv")

rownames(protein) <- protein$Country
protein$Country <- NULL
protein.scaled <- as.data.frame(scale(protein))

##LIBRERÍA IMPORTANTE##
library(devtools)
##devtools::install_github("kassambara/factoextra", force = TRUE)

library(factoextra)

##en k-means ES NECESARIO EL ARUGMENTO NÚMERICO, LA K, y aún eligiendo una pueden variar los clusters
km <- kmeans(protein.scaled, 5)
km

##Podemos calcular la media de consumo de cada una de las proteínas por cluster
aggregate(protein.scaled, by = list(cluster = km$cluster), mean)

##Graficamos un "dendograma" multidimensional.  El centro geométrico representado por una figura
##En la gráfica, explicas el 44.5% + 18.2 % de los datos.
##Aunque parece que se cruzan los clusters, esto no sucede, pues solo vemos 2 dimensiones.

fviz_cluster(km , data = protein.scaled)

##¿CUÁNTOS CLUSTERS ES LO MÁS ÓPTIMO POR HACER?

