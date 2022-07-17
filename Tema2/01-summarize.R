data <- read.csv("Documentos/CursoUdemyMLR/r-course-master/data/tema2/auto-mpg.csv",
                 header = TRUE, stringsAsFactors = FALSE)
##Pasamos a factores el número de cilindros
data$cylinders <- factor(data$cylinders, 
                         levels = c(3,4,5,6,8),
                         labels = c("3cil", "4cil", "5cil", "6cil", "8cil"))
summary(data)
str(data)



##¿Cuántas veces aparece un factor? Tabla de frecuencias absoluta
summary(data$cylinders)
##Estadísticos básicos de variable numérica
summary(data$mpg)

str(data$cylinders)


##Paquetes nuevos para nuevas medidas estadísticas útiles

install.packages(c("modeest", "raster", "moments"))
library(modeest) ##Calcular la moda
library(raster) ##Calcular los quantiles, coeficiente de variación
library(moments) ##Calcular el coeficiente de asimetría y de curtosis

##Medidas de tendencia central
##Valores más probables, centro de los datos


X =  data$mpg

mean(X) ##Media aritmética
median(X) ##Mediana 
modeest::mfv(X) ##Calcular la moda 
quantile(X) ##Cuartiles



##Medidas de dispersión
##Qué tan dispersos están los datos del valor central

var(X) ##Varianza
sd(X) ##Desviación estándar
raster::cv(X) ##Coeficiente de variación; 
sd(X)/mean(X)*100 ##Coeficiente de variación


##Medidas de simetría
##La forma que tienen los datos, con colas o valores muy centrados
##También se pueden ver tendencias hascia la izquiera o derecha respecto al valor central


##Dependiendo si el coeficiente de asimetría es muy negativo o psotivo
##Tenemos los datos muy por debajo o por encima de la media
##Curtosis positiva, mesocurtica. Negativa, leptocurtica
moments::skewness(X) ##Asimetría En este caso sale positiva
moments::kurtosis(X) ##Curtosis En este caso es mesocurtica


hist(X) ##¿Cómo se ditribuye la función?
