##Scatter plot para mostrar relación entre 2 variables cuantitativas

library(ggplot2)

auto <- read.csv("r-course-master/data/tema7/auto-mpg.csv", stringsAsFactors = F)

auto$cylinders <- factor(auto$cylinders, labels = c("3c", "4c","5c","6c","8c"))

head(auto)

plot <- ggplot(data = auto, aes(weight, mpg)) ##Con aes elegimos los ejes
##Geometrías
plot + geom_point() 
##Los coches son de un color u otro dependiendo de la cilindrada
plot + geom_point(alpha = 1/2, size = 5, aes(color = factor(cylinders))) + 
    geom_smooth(method = "lm", se= TRUE, col = "green") + ##Sagrega la recta de regresión
    #facet_grid(cylinders ~ .) + ##Segmenta la información por cilindrada
    theme_bw(base_family = "Times", base_size = 10) + ##Cambia el tema y la fuente 
    labs(x = "Peso") + labs(y = "Millas por galón") + ##Etiquetas de los ejes
    labs(title = "Consumo vs peso") ##Título




