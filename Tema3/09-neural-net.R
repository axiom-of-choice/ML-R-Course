##install.packages("nnet")
library(nnet)
library(caret)
library(ROCR)
bn <- read.csv("r-course-master/data/tema3/banknote-authentication.csv")
bn$class <- factor(bn$class)
set.seed(seed = NULL)
##Partición de datos
t.ids <- createDataPartition(bn$class, p = 0.7, list =F)
##Elaboramos el modelo 

mod <- nnet(class ~ ., data = bn[t.ids,], size = 3, maxit = 10000,
            decay = .001 , rang = 0.05)
##size es el nivel de capas que usa la red neuronal
##El size podemos ponerlo como el promedio de las variables de entrada y de salida
##maxit es el número máximo de iteraciones
##decay se usa para controlar el "overfitting"
##rang especifica el rango de pesos (aleatorios) que se asignan a la red neuronal



##Ahora calculamos la predicción sobre el conjunto de entrenamiento
pred <- predict(mod, newdata = bn[-t.ids,], type = "class")
##Matriz de confusión
table(bn[-t.ids,]$class, pred, dnn = c("Actual", "Predichos"))

##OJO CON LOS NA'S son peligrosos con las redes neuronales
##Se puede arreglar con el argumento na.action

mod <- nnet(class ~ ., data = bn[t.ids,], size = 3, maxit = 10000,
            decay = .001 , rang = 0.05, na.action = na.omit)

##Se usa el rang * max(|variables|) sea lo más cercano a 1
apply(bn,2, max)

##Podemos usar la propia red neuronal para calcular valores probabilísticos y ver en qué porcentajes...
##La predicción es correcta o no, esto con una curva ROC para ver el performance de la red neuronal

pred2 <- predict(mod, newdata = bn[-t.ids,], type = "raw")

perf <- performance(prediction(pred2, bn[-t.ids, "class"]), 
                    "tpr","fpr")

plot(perf)


