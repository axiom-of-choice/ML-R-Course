##install.packages("randomForest")
library(randomForest)
library(caret)


banknote <- read.csv("r-course-master/data/tema3/banknote-authentication.csv")

banknote$class <- factor(banknote$class)

set.seed(2018)

training.ids <- createDataPartition(banknote$class, p = 0.7, list = FALSE)
##Ahora construimos el modelo usanro Random Forest
##Cuidado con la potencia computacional de esta técnica

mod <- randomForest(x = banknote[training.ids, 1:4],
                    y = banknote[training.ids,5],
                    ntree = 500,
                    keep.forest = TRUE)
##x es la variable independiente, y la dependiente.
##ntree es el número de árboles(500 default), keep.forest nos mantiene los árboles generados, generalmente se pone FALSE
##x son las variables que predicen las categorías de la vairbale "y"


##Ahore checamos como predice nuestro modelo
pred <- predict(mod, banknote[-training.ids,])
table(banknote[-training.ids,"class"], pred, dnn = c("Actual", "Predicho"))
##Joder, observa la eficiencia de este modelo



##Ahora podemos predecir por probabilidades

probs <- predict(mod, banknote[-training.ids,], type = "prob")
head(probs)
pred2 <- prediction(probs[,2],banknote[-training.ids,"class"])
perf <- performance(pred2, "tpr", "fpr")
plot(perf)
