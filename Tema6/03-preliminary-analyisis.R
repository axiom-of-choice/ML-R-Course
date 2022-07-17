wmt <- read.csv("r-course-master/data/tema6/WMT.csv", stringsAsFactors = F)

plot(wmt$Adj.Close, type = "l")
##La función se usa para generar diferencias día a día
d <- diff(wmt$Adj.Close)
head(d)
plot(d, type = "l")
##Viendo esta tendencia, hacemos un histograma de las diferencias

hist(d, probability = T, ylim = c(0,0.8), main = "Walmart Stocks",
     col = "green", breaks = 50)
lines(density(d), lwd = 3)


##Data frame de Walmart mensual
wmt.m <- read.csv("r-course-master/data/tema6/WMT-monthly.csv", stringsAsFactors = F)
##Creamos una sserie temporal del valor ajustado al cierre
wmt.m.ts <- ts(wmt.m$Adj.Close) 
##Creamos unas diferencias 
d <- diff(as.numeric(wmt.m.ts))
d

##Retorno por stock
##La función lag() calcula diferencias en intervalos más amplios
##Este cociente nos da las diferencias porcentuales respecto al anterior.
##EJ: (16.64 - 14.3)/16.64
wmt.m.return <- d / lag(as.numeric(wmt.m.ts, k = -1))

##Histograma
hist(wmt.m.return, probability = T, col = "blue")

