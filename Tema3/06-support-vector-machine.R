##install.packages("e1071")
library(caret)
library(e1071)


banknote <- read.csv("r-course-master/data/tema3/banknote-authentication.csv")

banknote$class <- factor(banknote$class)
##Partición
set.seed(2018)
training.ids <- createDataPartition(banknote$class, p=0.7, list = FALSE)
##Modelo de suppor vector machine
##La dependiente es la clase, a partir de todas las demás, por eso se usa el punto
mod <- svm(class ~ ., data = banknote[training.ids,] )

##Vemos qué tal el modelo con una matriz de confusión aplicada al conjunto de entrenamiento

table(banknote[training.ids,"class"], fitted(mod), dnn = c("Actual", "Predicho"))
##Ahora vemos qué tal la predicción con el conjunto de validación
pred <- predict(mod, banknote[-training.ids,])
table(banknote[-training.ids,"class"], pred, dnn = c("Actual", "Predicho"))
##Ahora hacemos un plot del modelo para ver cómo los ha separado
##Pero solo es posible con un par de coordenadas
plot(mod, data = banknote[training.ids,], skew ~ variance)
##Ahora con el conjunto de validación
plot(mod, data = banknote[-training.ids,], skew ~ variance)

mod

##Modelo svm tuneado

tuned <- tune.svm(class ~ ., data = banknote[training.ids,], gamma = 10^(-6:-1), cost = 10^(1:2))
summary(tuned)

##Nos quedamos con una gamma y un coste que nos minimice el error


