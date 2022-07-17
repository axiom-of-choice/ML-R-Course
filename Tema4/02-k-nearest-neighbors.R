##install.packages("FNN")
##install.packages("dummies")
library(dummies)
library(FNN)
library(scales)
library(caret)

edu <- read.csv("r-course-master/data/tema4/education.csv",
                stringsAsFactors = T)

##Creamos variables dummies para la variable region
dummiesvar <- dummy(edu$region, sep = "_")

##Añadimos la variable dummi en el data frame
edu <- cbind(edu, dummiesvar)

##Hace falta reescalar los predictores para que nos sesguen la muestra
##Las variables dummies ya quedan estandarizadas (son binarias)

edu$urban.s <- rescale(edu$urban)
edu$income.s <- rescale(edu$income)
edu$under18.s <- rescale(edu$under18)


set.seed(2018)
##Conjunto de entrenamiento para predecir expense
t.ids <- createDataPartition(y = edu$expense, p = 0.6, list = F)
train <- edu[t.ids,]
##Conjunto de validación y de testing
temp <- edu[-t.ids,]
valid.ids <- createDataPartition(y = temp$expense, p = 0.5, list = F)
valid <- temp[valid.ids,]
test <- temp[-valid.ids,]
##Hay que construir un modelo para diferentes valores de k

## K  nearest neighbors con regresión
##El algoritmo más estándar es el "brute"
reg1 <- knn.reg(train = train[,7:13], test = valid[,7:13], y = train$expense, k = 1,
                algorithm = "brute")

reg1$pred
valid$expense
rmse1 <- rmsef(valid$expense, reg1$pred)
rmse1 <- rmsef(reg1$pred, valid$expense)
rmse1 <- sqrt(mean((valid$expense-reg1$pred)^2))

reg2 <- knn.reg(train = train[,7:13], valid[,7:13], train$expense, k = 2,
                algorithm = "brute")

rmse2 <- rmsef(reg2$pred, valid$expense)


reg3 <- knn.reg(train = train[,7:13], valid[,7:13], train$expense, k = 3,
                algorithm = "brute")

rmse3 <- rmsef(reg3$pred, valid$expense)

reg4 <- knn.reg(train = train[,7:13], valid[,7:13], train$expense, k = 4,
                algorithm = "brute")

rmse4 <- rmsef(reg4$pred, valid$expense)


errors <- c(rmse1, rmse2, rmse3, rmse4)

plot(errors, type = "o", xlab = "k", ylab = "RMSE")

##Ahora veremos sobre el conjunto de testing

reg.test <- knn.reg(train = train[,7:13], test[,7:13], train$expense, k = 3,
                    algorithm = "brute")

rmse.test <- rmsef(test$expense, reg.test$pred)
rmse.test <- rmsef(reg.test$pred, test$expense)



##Podemos hacerlo sin conjunto de validación

t.id <- createDataPartition(edu$expense, p=0.7, list = F)
tr <- edu[t.id,]
val <- edu[-t.id,]
reg <- knn.reg(tr[,7:13], test = NULL, y=tr$expense, k = 3, algorithm = "brute")


##Así, podemos calcular directamente el error cuadrático medio
rmse.reg <- sqrt(mean(reg$residuals^2))

##Para automatizar esto, podemos crear una función

rdacb.knn.reg <- function (tr_predictor, val_predictor,
                           tr_target, val_target, k){
    library(FNN)
    res <- knn.reg(tr_predictor, val_predictor, tr_target, k, algorithm = "brute")
    rmserror <- sqrt(mean((val_target - res$pred)^2))
    cat(paste("RMSE para k =", toString(k),":", rmserror,"\n",sep = ""))
}


rdacb.knn.reg(tr[,7:13], val[7:13], tr$expense, val$expense, 3)







##