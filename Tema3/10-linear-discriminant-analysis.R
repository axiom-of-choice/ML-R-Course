##install.packages("MASS")

library(MASS)
library(caret)

bn <- read.csv("Tema3/data/banknote-authentication.csv")

bn$class <- factor(bn$class)

set.seed(2018)

t.ids <- createDataPartition(bn$class, p = 0.7, list = F)

mod <- lda(bn[t.ids, 1:4], bn[t.ids,"class"])
##Vamos a predecir pero añadirlo al data frame original como una columna extra

bn[t.ids, "Pred"] <- predict(mod, bn[t.ids,1:4])$class

##Matriz de confusión 
table(bn[t.ids, "class"], bn[t.ids, "Pred"], dnn = c("Actual", "Predicha"))

bn[-t.ids, "Pred"] <- predict(mod, bn[-t.ids,1:4])$class

table(bn[-t.ids, "class"], bn[-t.ids,"Pred"], dnn = c("Actual", "Predicha"))

##Podemos usar una sintaxis usando la ~
mod <- lda(class ~ ., data = bn[t.ids,])