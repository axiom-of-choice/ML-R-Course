##install.packages("rpart")
##install.packages("rpart.plot")

library(rpart)
library(rpart.plot)
library(caret)

bh <- read.csv("r-course-master/data/tema4/BostonHousing.csv")
##Creamos partición para predecir MEDV

t.ids <- createDataPartition(bh$MEDV, p = 0.7, list = F)
##Necesitamos que las variables sean numéricas
bfit <- rpart(MEDV ~., data = bh[t.ids,])
##Node) es el nodo, split es la condición, n es el número de elementos del data frame que contiene ese nodo
##deviance es la suma de los cuadrados de los errores de dicho nodo
##yval es el valor promedio de las variables de salida de todos los elementos qu caen en ese nodo
bfit

##Representación gráfica

prp(bfit, type = 2, nn= T, fallen.leaves = T, faclen = 4, varlen = 8,
    shadow.col = "gray")


##Cp se refiere al factor de complejidad del árbol
##rel error es el error de clasificación total en raíz cuadrado
##x error es el error de validación cruzada promedio
##xstd es la desviación estándar en la validación cruzada
bfit$cptable

##Representación de los factores de complejidad, tamaño del árbol y xval relative error
##Para sleccionar el mejor árbol que represente y sea eficiente
plotcp(bfit)
##Árbol recortado.
bfitpruned <- prune(bfit, cp = 0.03134164 )


prp(bfitpruned, type = 2, nn= T, fallen.leaves = T, faclen = 4, varlen = 8,
    shadow.col = "gray")


##Finalmente utilizamos el árbol recortado para predecir lso valores fuera del conjunto de entrenamiento

preds <- predict(bfitpruned, bh[-t.ids,])
preds2 <- predict(bfit, bh[-t.ids,])
sqrt(mean((preds - bh[-t.ids,]$MEDV)^2))
sqrt(mean((preds2 - bh[-t.ids,]$MEDV)^2))






##Todo esto lo podemos hacer pero con predictores categóricos

ed <- read.csv("r-course-master/data/tema4/education.csv")
ed$region <- factor(ed$region)
##Queremos predecir expense
t.ids <- createDataPartition(ed$expense, p=0.7, list = F)
##Vamos a predecir solo con algunas variables
fit <- rpart(expense ~ region+urban+income+under18, data = ed[t.ids,])
prp(fit, type = 2, nn = T, fallen.leaves = T, faclen = 4, 
    varlen = 8, shadow.col = "gray")



##BAGGING
##La técnica del Bagging lo que hace es combinar de forma conjunta las predicciones
##De diferentes modelos o árboles para dar un resultado más preciso
##Efectivo para los métodos de alta varianza como los árboles de decisión

##install.packages("ipred")
library(ipred)

bagging.fit <- bagging(MEDV ~., data = bh[t.ids,])
prediction.t <- predict(bagging.fit, bh[t.ids,])
sqrt(mean((prediction.t-bh[t.ids,]$MEDV)^2))



##BOOSTING
##Esta técnica sirve para predecir con base en modelos que tienen mucho error
##Y combina varios árboles. Es mejor predictoria que las dos anteriores
##install.packages("gbm")
library(gbm)
gbm.fit <- gbm(MEDV~., data = bh[t.ids,], distribution = "gaussian")
prediction.g <- predict(gbm.fit, bh[t.ids,])
sqrt(mean((prediction.g-bh[t.ids,]$MEDV)^2))



