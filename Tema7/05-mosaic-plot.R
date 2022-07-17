##GRáfico de mosaicos para visualizar datos de dos o más variables cualitativas
##sirve para "cruzar variables"

library(stats)

mtcars<- read.csv("r-course-master/data/tema7/mtcars.csv")

##Con este mosaico cruzamos dos variables
mosaicplot(~ gear+carb , data = mtcars, color = 2:7, las = 1)


mosaicplot(~ gear + cyl , data = mtcars, color = 2:7, las = 1)


mosaicplot(~ carb + cyl , data = mtcars, color = 2:10, las = 1)
