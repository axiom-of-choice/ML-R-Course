##Redes neuronales para predecir valores numéricos
library(nnet)
library(caret)
##install.packages("devtools")
library(devtools)
set.seed(2018)

bh <- read.csv("r-course-master/data/tema4/BostonHousing.csv")

t.ids <- createDataPartition(bh$MEDV, p = 0.7, list = F)
summary(bh$MEDV)

##Vamosa  escalar los valores entre 0 y 1 
##Size =6 es el número máximo de nodos intermedios
##Decay el factor de decaimiento
##maxit número máximo de iteraciones
##linout especifica si queremos una salida lieal o logística
fit <- nnet(MEDV/50 ~ ., data = bh[t.ids,], size = 6, 
            decay = 0.1, maxit = 1000, linout = T)

#install_github('fawda123/NeuralNetTools', ref = 'development')
#library(NeuralNetTools)
#plot(fit)


##Observe ahora el error de los valores sobre el conjunto de entrenamiento
sqrt(mean((fit$fitted.values*50 - bh[t.ids,"MEDV"])^2))

##Ahora calculamos el error sobre el conjunto de validación
pred <- predict(fit, bh[-t.ids, ])

sqrt(mean((pred*50 - bh[-t.ids, "MEDV"])^2))
