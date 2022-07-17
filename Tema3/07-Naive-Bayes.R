##install.packages("naivebayes")
library(e1071)
library(caret)


e.purchases <- read.csv("r-course-master/data/tema3/electronics-purchase.csv")
##Naive Bayes NECESITA que todas las variables sean categóricas
set.seed(2018)
t.ids <-createDataPartition(e.purchases$Purchase, p = 0.67, list = F)
##Modelo d eentrnamiento
mod <- naiveBayes(Purchase ~ ., data = e.purchases[t.ids,])
mod
##Ahora vamos a probar el modelo en la etapa de validación

pred <- predict(mod, e.purchases[-t.ids,])

tab <- table(e.purchases[-t.ids,]$Purchase, pred, dnn = c("Actual", "Predicha"))
##la función confusionMatrix nos da información extra sobre la tabla
confusionMatrix(tab)
