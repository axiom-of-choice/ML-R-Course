'Gráficos 3D'
##install.packages("plot3D")
library(plot3D)

mtcars <- read.csv("Tema7/data/mtcars.csv")

row.names(mtcars) = mtcars$X

mtcars$X <- NULL

##Gráficos en 3 dimensiones espaciales

scatter3D(x = mtcars$disp, y = mtcars$wt, z = mtcars$mpg, 
          clab = "Millas/Galón", pch = 19, main = "Coches de los 70",
          theta = 20, phi = 20, xlab = "Desplazamiento", ylab = "Peso en mil libras",
          zlab = "Millas por galón", bty = "g", cex = 0.8) 
##podemos agregar texto a los puntos

text3D(x = mtcars$disp, y = mtcars$wt, z = mtcars$mpg, add = T,
       labels = rownames(mtcars), colkey = F, cex = 0.5)


'''Histogramas 3D'''


data("VADeaths")

hist3D(z = VADeaths, scale = F, expand = 0.01, bty = "g", phi = 40,
       col = "#1188CC", border = "black", shade = 0.4, ltheta = 80,
       space = 0.3, ticktype = "detailed", xlab = "Desplazamiento",
       ylab = "Peso", zlab = "Millas por galón")



'''Gráfico híbrido'''

scatter3D(x = mtcars$disp, y = mtcars$wt, z = mtcars$mpg, 
          clab = "Millas/Galón", pch = 19, main = "Coches de los 70",
          theta = 20, phi = 20, xlab = "Desplazamiento", ylab = "Peso en mil libras",
          zlab = "Millas por galón", bty = "g", cex = 0.8, type = "h") 
##podemos agregar texto a los puntos