s <- seq(0.01, 0.99,0.01)
##Devuelve los percentiles de la normal
qn <- qnorm(s)
##Un data frame para ver los percentiles de la normal
df <- data.frame(p=s, q=qn)

##Para genererar muestras aleatorias utilizando una Normal

samp <- rnorm(200)
##Sacamos los cuantiles

quantile(samp, prob=s)

##Gráfico cuantil-cuantil para comparar distribuciones con la normal


##qqnorm

##Cargamos un data frame que viene en R
trees
qqnorm(trees$Height)

##qqplot nos permite comparar cuantiles de dos distribuciones dadas
##Cargamos un data set por default de R de números aleatorios en [0,1]

randu
len <- length(randu$x)
##una manera
qqplot(randu$x, runif(len))
##Otra manera
##Ppoints genera un número de probabilidades generadas
y <- qunif(ppoints(len))
qqplot(randu$x, y)
##Por ejemplo con la normal no jala
qqnorm(randu$x)


##Generamos una distribución Xi cuadrada con 3 grados de libertad

chi3 <- qchisq(ppoints(30), df = 3)
n30 <- qnorm(ppoints(30))
qqplot(n30,chi3)

##Ahora vamos a comprara la distribución de cauchy

cauchy <- qcauchy(ppoints(30))
qqplot(n30, cauchy)



x <- seq(-3,3,0.01)
##Ahora pintamos las distribuciones
##La normal (distribución)
plot(x,dnorm(x))
##(densidad)
plot(x,pnorm(x))
##Juntas
par(mfrow=c(1,2))
plot(x,dnorm(x))
plot(x,pnorm(x))




##De la uniforome
plot(x,runif(x))
plot(x,punif(x))

###De la chi cuadrada

plot(x,dchisq(x,df=3))
plot(x,pchisq(x,df=3))


##De la Cauchy

plot(x,dcauchy(x))
plot(x,pcauchy(x))
