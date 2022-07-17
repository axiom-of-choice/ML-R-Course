auto <- read.csv("Documentos/CursoUdemyMLR/r-course-master/data/tema2/auto-mpg.csv")
##Transformar a vairable categórica los cilindros
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C","6C", "8C"))

##install.packages("lattice")
library(lattice)
attach(auto)
##Para dibujar un boxplot con lattice
##Variables a la izquiera, factores a la derecha
bwplot(~auto$mpg | auto$cylinders, 
       main = "MPG según cilindrada",
       xlab =  "Millas por Galón",
       layout = c(2,3))

##Variables a la izquiera, factores a la derecha
##Scatterplot 
xyplot(mpg~weight | cylinders, 
       main = "Peso vs Consumo vs Cilindrada", xlab = "Peso",
       ylab = "Millas por galón")


##bwplot, xyplot, densityplot, splom


##Para cambiar el esquema de color
trellis.par.set(theme = col.whitebg())
