##También podemos usar los random forests
library(caret)
library(randomForest)

bh <- read.csv("Tema4/data/BostonHousing.csv")

set.seed(2018)

t.ids <- createDataPartition(bh$MEDV, p = 0.7, list = F)
##Crearemos un bosque aleatorio de varios árboles de regresión

mod <- randomForest(x = bh[t.ids, 1:13], y = bh[t.ids, 14],
                    ntree = 1000, xtest = bh[-t.ids, 1:13],
                    ytest = bh[-t.ids, 14], importance = TRUE,
                    keep.forest = TRUE)
##Un summary de lo que explica el modelo y sus errores
mod
##Importance nos imprime de cada uno de los predictores, su importancia
mod$importance

##ahora podemos comparar los predictores sobre el conjunto de entrnamiento

plot(bh[t.ids,]$MEDV, predict(mod, newdata = bh[t.ids,]),
     xlab = "Actual", ylab = "Predichos")
abline(0,1)

##O sobre el conjunto de validación
plot(bh[-t.ids,]$MEDV, predict(mod, newdata = bh[-t.ids,]),
     xlab = "Actual", ylab = "Predichos")
abline(0,1)


##PARÁMETROS A TENER EN CUENTA 

##MTRY = m/3 donde m = número de predictores
##nodesize = 5 por defecto, esto nos da el número mínimo para considerarlo como un árbol
##maxnodes = el número de nodos máximos (podemos podarlo)

