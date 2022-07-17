##Clasificando con regresión logística 
library(caret)

bh <- read.csv("r-course-master/data/tema3/boston-housing-logistic.csv")

##La regresión logística requiere que las variables predictoras sean numéricas y las de salida categóricas

bh$CLASS <- factor(bh$CLASS, levels = c(0,1))

set.seed(2018)

t.ids <- createDataPartition(bh$CLASS, p=0.7, list = F)

mod <- glm(CLASS ~ ., data = bh[t.ids,], family = binomial)
##Family es binomial pues la clase es de tipo V o F, Sí o No, 1 o 0

summary(mod)

##Esto nos elabora ciertas probabilidades de que en función de los parámetros de clasificación, sea un éxito
##Gracias al parámetro type = "response"s
bh[-t.ids, "PROB_SUCCES"] <- predict(mod, newdata = bh[-t.ids,], type = "response")
##Ahora necesitamos una probabilidad de corte de modo que sea 1 o 0
##Partimos del 50% como en el modelo logístico
##Creamos la columna PROB_SUCCES para esto
bh[-t.ids, "PRED_50"] <- ifelse(test = bh[-t.ids, "PROB_SUCCES"]>=0.5, 1,0)
##Creamos la matriz de confusión, para verificar qué tan bien ha ido
table(bh[-t.ids,"CLASS"], bh[-t.ids, "CLASS"], dnn = c("Actual","Predicha"))
      



#En un modelo logístico, las variables más representativas en el modelo son
##Las que tienen menor Pr(>|z|)