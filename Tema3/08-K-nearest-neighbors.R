library(caret)
##install.packages("class")
library(class)
##K nearest  neighbors requiere que las variables predictoras sean numéricas y la que quiero predecir sea categórica
vac <- read.csv("r-course-master/data/tema3/vacation-trip-classification.csv")
##Cuando hay discrepancia en los datos, hay que normalizarlos
set.seed(2018)
vac$Income.norm <- scale(vac$Income)
vac$Family_size.norm <- scale(vac$Family_size)
#Así, vamos a usar como predictoras las normalizadas
##Partiremos en 3 trozos
t.ids <- createDataPartition(vac$Result, p=0.5, list = F)
train <- vac[t.ids,]
temp <- vac[-t.ids,]

v.ids <- createDataPartition(temp$Result, p = 0.5, list=F)
val <- temp[v.ids,]
test <- temp[-v.ids,]
##Hacemos una predicción
pred1 <- knn(train[,4:5], val[,4:5], train[,3], k = 5)
##Generamos una amtriz de error
errmat1 <- table(val$Result, pred1, dnn = c("Actual", "Predichos"))
errmat1


pred2 <- knn(train[,4:5], test[,4:5], train[,3], k=1)
errmat2 <- table(test$Result, pred2, dnn = c("Actual", "Predicha"))
errmat2
##Hacemos una función que evalúe distintos "k" para elegir el mejor
knn.automate <- function(training_predictors, validation_predictors,
                         training_target,validation_target,
                         start_k,end_k){
    for(k in start_k:end_k){
        pred <- knn(training_predictors, validation_predictors,
                    training_target, k)
        tab <- table(validation_target, pred, dnn = c("Actual", "Predicho"))
        cat(paste("Matriz de confusión para k=",k,"\n"))
        cat("===================\n")
        print(tab)
        cat("---------------\n")
    }
}

knn.automate(train[,4:5], val[,4:5], train[,3], val[,3],1,8)
##Hay una función en caret que  generaliza knn algorithm
##Dato de control
training.control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
##Buscar la información de trainControl en help de R
##Buscar la información de train en help de R
caret_knn_fit <- train(Result ~ Family_size + Income, data = train,
                              method = "knn", trControl = training.control,
                              preProcess = c("center", "scale"),
                              tuneLength =10)
caret_knn_fit

pred5 <- knn(train[,4:5], val[,4:5],train[,3], k=5, prob = T)
pred5

