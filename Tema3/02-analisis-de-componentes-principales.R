usarrests <- read.csv("Tema3/data/USArrests.csv", stringsAsFactors = FALSE)
##Simplemente hacemos que cada fila se llame por el estado que le corresponde
rownames(usarrests) <- usarrests$X 
usarrests$X <- NULL
head(usarrests)
##Vamos a calcular la varianza a las columnas
apply(usarrests,2,var)
##Podemos re escalar las variables para que haya menos variabilidad entre las vairables
##Esto con los parámetros center=TRUE, scale=TRUE
acp <- prcomp(usarrests, center = TRUE, scale = TRUE)
##Las rotaciones son los coeficientes de las combinaciones lineales de las varibales continuas
acp
##Ploteamos para entender mejor el análisis
plot(acp, type = "l")

summary(acp)
##Representación del ACP en un diagrama para ver todo mucho más visual 

biplot(acp, scale = 0)


##Primera componente principal del dartaset
pc1 <- apply(acp$rotation[,1]*usarrests,1,sum)
pc1
pc2 <- apply(acp$rotation[,2]*usarrests, 1, sum)

usarrests$pc1 <- pc1
usarrests$pc2 <- pc2


usarrests[,1:4] <- NULL
