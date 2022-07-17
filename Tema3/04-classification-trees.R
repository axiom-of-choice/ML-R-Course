##install.packages(c("rpart", "rpart.plot", "caret"))
library(caret)
library(rpart)
library(rpart.plot)


banknote <- read.csv("Tema3/data/banknote-authentication.csv")


##Creamos índices de conjuntos de entrenamiento y de validación

set.seed(2018)

training.ids <- createDataPartition(banknote$class, p=0.7, list = FALSE)
##Generamos el árbol (modelo) aleatorio
mod <- rpart(class ~ ., data = banknote[training.ids,], method = "class",
             control = rpart.control(minsplit = 20, cp = 0.01))
            
##Class (columna del dataframe) ~. es lo mismo que class~  variance + skew + curtosis + entropy 
##Tomamos del data frame solo el conjunto de entrenamiento
##Method es el método que clasifica por casos (puede ser por clase o por regresión)
##Control 

mod
prp(mod, type = 2, extra = 104, nn = TRUE, 
    fallen.leaves = TRUE, faclen = 4, varlen = 8, 
    shadow.col = "gray")
##Tpye 2 es para mostra rlas bifurcaciones de una u otra forma
##Extra = 104 es para mostrar las probabilidades conidicionadas respecto a la total
##nn es para mostrar el número de nodo por encima de cada una de los nodos
##Fallen.leaves = TRUE es para mostrar los nodos hoja (finales) hasta abajo del todo
##faclen = 4 se utiliza para abreviar los nombres de las clases con una longitud específica
##varlen es para abreviar el nombre de las variables en una longitud específica
##Shadowcol es para añadir sombra a alguno de los nodos
##El árbol de decisión lleva a cabo una segmentación para clasificar datos de manera aleatoria










##Podemos "podar" un árbol (recortarlo)
mod$cptable

mod.cortado <- prune(mod, mod$cptable[5,"CP"])

prp(mod.cortado, type = 2, extra = 104, nn = TRUE, 
    fallen.leaves = TRUE, faclen = 4, varlen = 8, 
    shadow.col = "gray")

##Hacemos el modelo de predicción con la data cortada
predicted.cortada <- predict(mod.cortado, banknote[-training.ids,], type = "class")
##Vemos nuestra eficiencia con una matriz de confusión
table(banknote[-training.ids,]$class, predicted.cortada, dnn = c("Actual","Predicho"))



##Podemos hacerlo con un modelo probabilístico
predicted.cortada2 <- predict(mod.cortado, banknote[-training.ids,], type = "prob")
##Utilizando esto podemos generar un diagrama ROC paara ver la eficiencia de la predición

library("ROCR")
pred <- prediction(predicted.cortada2[,2], banknote[-training.ids,"class"])
perf <- performance(pred, "tpr", "fpr")
plot(perf)
##Observe que es muy bueno el diagrama ROC en esta predicción
