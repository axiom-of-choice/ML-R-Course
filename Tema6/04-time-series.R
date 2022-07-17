s <- read.csv("Tema6/data/ts-example.csv")

##Podemos crrar series temporales sin saber nad acerca del tiempo

ds <- ts(s)
ds
##Observe que la serie temporal inicia en 0 y termina en 100
plot(ds)
##Aunque podemos cambiar el momento de start
ds.a <- ts(s, start = 2021)
ds.a
plot(ds.a)

##Podemos hacer una serie de tiempo mensual
##start = c(AÑO, mes), frequency (12, pues 12 meses al año)
ds.m <- ts(s, start = c(2021, 1), frequency = 12)
ds.m
plot(ds.m)

##Podemos hacer una serie temporal trimestral
ds.q <- ts(s, start = c(2021,1), frequency = 4)
ds.q
plot(ds.q)

##Podemos preguntarle a R diferentes datos acerca de la serie temporal

##¿Cuándo empieza, termina y cada cuánto se añaden datos?
start(ds.m)

end(ds.m)

frequency(ds.m)

##¿Y qué cuando tenemos más de una variable 
##La frquencia es mensual
prices <- read.csv("Tema6/data/prices.csv")
head(prices)

prices.ts <- ts(prices, start = c(1980,1), frequency = 12)
prices.ts
##Se grafican por separado
plot(prices.ts)
##Para esto se arregla con
plot(prices.ts, plot.type = "single", col = c(1,2))
##topleft arriba a la izquierda
legend("topleft", colnames(prices.ts), col = 1:2, lty = 1)

##Cuando una serie temporal se tiene la sospecha de que es multiplicativa se aplica la función logaritmo
flour.logaritmic <- log(prices.ts[,1])


##PARA DESCOMPONER UNA SERIE TEMPORAL, PODEMOS UTILIZAR DOS MÉTODOS
##FUNCIÓN STL SEASONAL DECOMPOSITION OF TIME SERIES 
##S.WINDOW "PERIOD" ES PARA DARLE UNA CARACTERÍSTICA DE PERIODO
flour.stl <- stl(flour.logaritmic, s.window = "period")
plot(flour.stl)
##OBSERVE LA DESCOMPOSICIÓN DE MANERA SEASONAL, LA TENDENCIA Y EL RUIDO.DATA ES LOS DATOS ORIGINALES
flour.stl
str(flour.stl)


##DECOMPOSE BY MOVING AVERAGE

flour.dec <- decompose(flour.logaritmic)
plot(flour.dec)


##ahora con la gasolina

gas.logaritmic <- log(prices.ts[,2])
gas.stl <- stl(gas.logaritmic, s.window = "period")
plot(gas.stl)


gas.dec <- decompose(gas.logaritmic)
plot(gas.dec)


##Podemos eliminarles los datos estacionales para quedarnos con la idea global del mercado
##Compare
plot(prices.ts[,2])
gas.season.adjusted <- prices.ts[,2] - gas.dec$seasonal
plot(gas.season.adjusted)

