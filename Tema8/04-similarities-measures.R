'Medidas de similitud'

##install.packages("lsa")

library(lsa)

mtcars <- read.csv("Tema8/data/mtcars.csv")
head(mtcars)
mtcars$X <- NULL

#Distancia Euclidea (pueden ser DF o vectores)

coche1 <- mtcars[1,]
coche2 <- mtcars[2,]
dist(coche1,coche2,method = "euclidean")
#Calculada a mano
sqrt(sum((coche1-coche2)**2))
x1 <- rnorm(100)
x2 <- rnorm(100)
dist(rbind(x1,x2), method = "euclidean")


#Distancia del coseno (deben ser vectores) (es el producto punto dividida entre el producto de las normas)
#Mide el ángulo entre los vectores (direccional)
#Recomendaciones  basadas en ítems
v1 <- c(0,1,0,1,1,0,0,1)
v2 <- c(1,0,1,0,1,1,1,1)
cosine(v1,v2)

#Coeficiente de correlación de Pearson (Cov(X,Y)/sqrt(Var(X)*Var(Y)))
#Mide la correlación lineal prácticamente, está entre -1 y 1
#Recomendaciones basadas en usuarios
pear <- cor(mtcars, method = "pearson")
pear
corrplot::corrplot(pear)
