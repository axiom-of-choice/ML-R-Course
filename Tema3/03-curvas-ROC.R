##install.packages("ROCR")
library(ROCR)

data1 <- read.csv("Tema3/data/roc-example-1.csv")
data2 <- read.csv("Tema3/data/roc-example-2.csv")
##En data 1: = indica Fallo, 1 Indica Éxito. (Para cada fila)
pred1 <- prediction(data1$prob, data1$class)
##Con este objeto predicción genermaos un objeto que nos dice el performance (mide la eficiencia)
perf1 <- performance(pred1,"tpr","fpr") #TRUEPOSITIVERATE;FALSEPOSITIVERATE
##Ploteamos para visualizar estos objetos
plot(perf1)
##Esto pinta una línea recta
lines(par()$usr[1:2],par()$usr[3:4])
##Vamos a crear un data frame de probabilidades de corte
prob.cuts.1 <- data.frame(cut = perf1@alpha.values[[1]],
                          fpr = perf1@x.values[[1]],
                          tpr = perf1@y.values[[1]])

head(prob.cuts.1)
tail(prob.cuts.1)

##con esto, Podemos quedarnos con los valores cuya True positive Rate es mayor o igual al 0.8
prob.cuts.1[prob.cuts.1$tpr>=0.8,]





pred2 <- prediction(data2$prob, data2$class, label.ordering = c("non-buyer","buyer"))
perf2 <- performance(pred2, "tpr", "fpr")
plot(perf2)
lines(par()$usr[1:2],par()$usr[3:4])
prob.cuts.2 <- data.frame(cut = perf2@alpha.values[[1]],
                          fpr = perf2@x.values[[1]],
                          tpr = perf2@y.values[[1]])
head(prob.cuts.2)
tail(prob.cuts.2)

##con esto, Podemos quedarnos con los valores cuya True positive Rate es mayor o igual al 0.8
prob.cuts.2[prob.cuts.2$tpr>=0.8,]
