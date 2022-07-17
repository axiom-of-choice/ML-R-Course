s <- read.csv("r-course-master/data/tema6/ts-example.csv")

##Definimos un filtro de período 7 esto si por ejemplo tomamos la información como diaria
##Y cada semana tiene 7 días
n <- 7
##Definimos unos pesos que tienen que sumar 1

weights <- rep(1/n, n)

s.filter.1 <- filter(s$sales, filter = weights, sides = 2)
##Esto promedia los valores con centro en los múltiplos de 3 y promedia con 3 anteriores y 3 posteriores
##Esto para suavizar la curva pero seguir visualizando la tendencia
s.filter.1
##Observe
plot(s$sales, type = "l")
lines(s.filter.1, col = "blue", lwd = 3)

##Podemos filtrar de manera unilateral

s.filter.2 <- filter(s$sales, filter = weights, sides = 1)
s.filter.2
##Observe
lines(s.filter.2, col = "red", lwd = 3)


##Si queremos un filtro con información que se mide 12 veces por año, podemos hacer el análisis
prices <- read.csv("r-course-master/data/tema6/prices.csv")
prices.ts <- ts(prices, start = 1980, frequency = 12)

gas.dec <- decompose(prices.ts[,2])

gas.season.adjusted <- prices.ts[,2] - gas.dec$seasonal

n <- 12

gas.filter.1 <- filter(gas.dec$x, filter = rep(1/n, n), sides = 2)
plot(gas.dec$x)
lines(gas.filter.1, col = "green", lwd = 3)
gas.filter.2 <- filter(gas.dec$x, filter = rep(1/n, n), sides = 1)
lines(gas.filter.2, col = "red", lwd = 3)


