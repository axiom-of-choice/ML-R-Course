##Clusterings jerárquicos AGLOMERATIVOS
protein <- read.csv("r-course-master/data/tema5/protein.csv")
##Escalamos las variables excepto la primera columna que es el país
data <- as.data.frame(scale(x = protein[,-1]))
data$Country <- protein$Country
row.names(data) <- data$Country
##Haremos un cluster jerárquico con la función hclust()
##Hay que indicar la distancia con la que vamos a comparar
##Se usa en general la distancia euclídea
##El método del hclust "normal" es el ward.D2
hc <- hclust(dist(data, method = "euclidean"), method = "ward.D2")
#?hclust
hc
##ahora graficamos el dendograma
plot(hc, hang = -0.01, cex = 0.7, labels = data$Country)
## "Cuanto más cerca del cero se juntan los países, más similares son en cuanto a consumo de proteínas"

##ahora construimos otro clustering con otro método

hc2 <- hclust(dist(data, method = "euclidean"), method = "single")
##Y vemos el dendograma
plot(hc2, hang = -0.01, cex = 0.7, labels = data$Country)


##Podemos ver la distancia en una matriz

d <- dist(x = data, method = "euclidean")
d

hc3 <- hclust(dist(data, method = "euclidean"), method = "complete")
plot(hc3, hang = -0.01, cex = 0.7, labels = data$Country)


hc4 <- hclust(dist(data, method = "euclidean"), method = "average")
plot(hc4, hang = -0.01, cex = 0.7, labels = data$Country)


##el parámetro merge nos da la forma en las que une las variables
##Los negativos indican las filas, los positivos indican los clusters

hc4$merge


##Los métodos de un cluster nos indican con base en qué "ponderan" las divisiones y las variables para hacer las divisiones mayores
##En general, el método "ward.D2" es el más justo porque pondera con base en 2 criterios

##install.packages("cluster")
library(cluster)


##Podemos ahcer clustering jerárquico DIVISITIVO

div <- diana(data, metric = "euclidean")
par(mfrow = c(1,2))
##Las barras rojas nos indican en qué altura se juntarán en el dendograma
plot(div)

##La función cut tree se puede utilizar con cualquier cluster jerárquico
##Se puede usar para dividir el dendograma en grupos significativos
##Con esto podemos ver a que grupo pertenecen
cut <- cutree(tree = hc, k = 4)
##Con esto podemos cuántos países tiene cada grupo
table(cut)

##Para visualizar los grupos dentro del mismo dendograma podemos hacer lo siguiente
plot(hc, hang = -0.01, cex = 0.7, labels = data$Country)
rect.hclust(tree = hc, k = 4, border = "red")

