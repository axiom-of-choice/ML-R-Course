##Análisis de componentes principales

bh <- read.csv("r-course-master/data/tema5/BostonHousing.csv")

##Paquete para plotear la matriz de correlación
##install.packages("corrplot")

library(corrplot)

##Ahora veremos la correlación  entre las columnas

corr <- cor(bh[,-14])
corr

##Matriz de correlación muy bonitas
corrplot(corr = corr, method = "color")

##Las correlaciones se pintan con colorsitos
##Observe que mientras más azules o más rojas, más correlacionadas están dichas variables

##En este caso, mientras más grande la bola, más correlacionadas
corrplot(corr = corr, method = "circle")

##con esto en mente, podemos hacer el análisis de componentes principales

#Si se usa Scale  = T usa la matriz de correlaciones, si es F es la matriz de covarancias

bh.acp <- prcomp(bh[,-14], scale = T)

##Cuando miramos la "CUMULATIVE PROPORTION" se ve cuánto porcentaje de los datos se representan
##Con más o menos componentes
bh.acp

plot(bh.acp)

plot(bh.acp, type = "l")


biplot(bh.acp, col = c("gray", "red"))


##Matriz de rotación

bh.acp$rotation

##DEsviación estándar de cada una de las componentes

bh.acp$sdev
