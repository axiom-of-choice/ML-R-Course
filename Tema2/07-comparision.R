data <- read.csv("Tema2/data/daily-bike-rentals.csv")

##Vamos a cambiar algunos datos para que sean más manejables

data$season <- factor(data$season, levels = c(1,2,3,4),
                      labels = c("Invierno", "Primavera", "Verano", "Otoño"))
data$workingday <- factor (data$workingday, levels = c(0,1),
                           labels = c("Festivo", "Laboral"))
data$weathersit <- factor(data$weathersit, levels = c(1,2,3),
                          labels = c("Despejado", "Nublado", "Lluvia/nieve ligera"))

data$dteday <- as.Date(x = data$dteday, 
                       format =  "%Y-%m-%d")
attach(data)

##Facilitar la comparación de alquier de bicicletas x estación de año
par(mfrow=c(2,2))
##Hago subconjuntos del dataframe original, por estación y con solo la columna cnt
winter <- subset(data, season == "Invierno")$cnt
spring <- subset(data, season == "Primavera")$cnt
summer <- subset(data, season == "Verano")$cnt
fall <- subset(data, season == "Otoño")$cnt


##Histogramas

hist(winter, probability = TRUE, xlab = "Alquiler diario en invierno", main ="")##Pintar histograma
lines(density(winter))##Pintar la densidad
abline(v = mean(winter), col = "red")##Pintar la línea vertical por donde pasa la media
abline(v = median(winter), col = "blue")

hist(spring, probability = TRUE, xlab = "Alquiler diario en primavera", main ="")##Pintar histograma
lines(density(spring))##Pintar la densidad
abline(v = mean(spring), col = "red")##Pintar la línea vertical por donde pasa la media
abline(v = median(spring), col = "blue")


hist(summer, probability = TRUE, xlab = "Alquiler diario en verano", main ="")##Pintar histograma
lines(density(summer))##Pintar la densidad
abline(v = mean(summer), col = "red")##Pintar la línea vertical por donde pasa la media
abline(v = median(summer), col = "blue")

hist(fall, probability = TRUE, xlab = "Alquiler diario en Otoño", main ="")##Pintar histograma
lines(density(fall))##Pintar la densidad
abline(v = mean(fall), col = "red")##Pintar la línea vertical por donde pasa la media
abline(v = median(fall), col = "blue")

##install.packages("beanplot")

library(beanplot)
par(mfrow=c(1,1))
beanplot(cnt~season, col = c("blue", "red", "yellow"))



###Análisis de causalidad
library(lattice)

bwplot(cnt~weathersit, 
       layout = c(1,1), 
       xlab = "Pronóstico del tiempo",
       ylab = "Frecuencias", ##Insertamos una función a ejecutarse que nos dice la frecuencia de cuándo hay mal tiempo o no
       panel = function(x,y,...) {
           panel.bwplot(x,y,...)
           panel.stripplot(x,y,jitter.data = TRUE, ...)
       },
       par.settings = list(box.rectangle = list(fill = c("red", "yellow", "green"))))
