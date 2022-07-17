inf <- read.csv("r-course-master/data/tema6/infy-monthly.csv")
head(inf)
tail(inf)

infall.ts <- ts(data = inf, start = c(1999,3), frequency = 12)
infall.ts
plot(infall.ts)

inf.ts <- ts(data = inf$Adj.Close, start = c(1999,3), frequency = 12)
inf.ts
plot(inf.ts)

##Suavizado exponencial de HolyWinters con un filtro distinto a moving-averages
##También nos sirve para hacer predicciones de algún valor, pero dentro del mismo peridodo de tiempo
inf.hw <- HoltWinters(inf.ts)
head(inf.hw)

plot(inf.hw, col = "blue", col.predicted = "red")
inf.hw

##install.packages("forecast")
library(forecast)

inf.forecast <- forecast(inf.hw, h = 24) ##Para una predicción de 2 años 

plot(inf.forecast)
##Crea un "pasillo" alrededor de esa predicción de datos
##La predicción de los valores van de color azu, las bandas de color oscuro están en un intervalo de confianza del 85%
##Los coolores claros engloban predicciones con accuracy del 95%

##Podemos comparar
quantmod::getSymbols("INFY")
ts(INFY, frequency = 12)
par(mfrow = c(1,2))
plot(INFY$INFY.Adjusted)
plot(inf.forecast)
