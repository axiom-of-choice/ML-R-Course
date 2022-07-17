##Clustering avanzado principalmente cuando tenemos ruido o outliers
##Clustering de densidad de puntos

library(factoextra)
library(fpc)


multi <- multishapes
datapoints <- multishapes[,1:2]
par(mfrow=c(1,1))
plot(datapoints)

##Lo podemos hacer con k means
km <- kmeans(x = datapoints, 5)
##Observe que las particiones están malas
fviz_cluster(km, data = datapoints)

##ahora podemos usar la función para hacer un clustering por densidades
dsfit <- dbscan(datapoints, eps = 0.15
                ,
                MinPts = 5)
##epsilon es el radio más pequeño que hay entre vecinos para hacer clusters se calcula "a ojo" viendo el número de puntos
##MinPts es para formar un cluster con el mínimo


dsfit

##Existen puntos core (como el interior)
##Puntos frontera, cuando no puedes juntar el minimo numero de vecinos
##El ruido u outlier es cuando no cumple ni epsilon ni minpts

##Obsrve la diferencia en repreentación gráfica
fviz_cluster(object = dsfit, data = datapoints, 
             geom = "point")



##Clusters basado en modelo

##install.packages("mclust")
library(mclust)

mclust <- Mclust(data = datapoints)
#3Podemos ver las gráficas de cada uno de los modelos
plot(mclust)

##Podemos ver que el número de clusters (9) que deberíamos tener en cuenta
summary(mclust)

##En general, Mclust ajusta con alguna distribución de probabilidad que se parezca a nuestros datos

