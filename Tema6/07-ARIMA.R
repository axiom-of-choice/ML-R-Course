####Modelo autoregresivo integrado de media móvil
library(forecast)

inf <- read.csv("Tema6/data/infy-monthly.csv")

inf.ts <- ts(inf$Adj.Close, frequency = 12, start = c(1999,3))

inf.arima <- auto.arima(x = inf.ts)

summary(inf.arima)
##NO ES ÚTIL PARA PLAZOS LARGOS
##ES MUY ÚTIL PARA PLAZOS CORTOS
inf.arima.fore <- forecast(inf.arima, h = 24)
plot(inf.arima.fore, col = "red", fcol = "blue")
##OBSERVE LA DIFERENCIA CON UN FORECASTING DE HOLT WINTERS
inf.hw <- HoltWinters(x = inf.ts)
inf.fore <- forecast(inf.hw, h = 24)
plot(inf.fore)


par(mfrow = c(2,1))
plot(inf.arima.fore, col = "red", fcol = "blue")
plot(inf.fore)

