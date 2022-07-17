'Matrices de Correlación'
library(ggplot2)
library(corrplot) ##Para pitnar las matrices de correlación

mtcars <- read.csv("Tema7/data/mtcars.csv")
mtcars$X <- NULL
##Matriz de correlación
mtcars.cor <- cor(mtcars, method = "pearson")
##Redondeada
round(mtcars.cor , digits = 2)
##Ploteamos una matriz de correlación
corrplot(corr = mtcars.cor, method = "pie", shade.col = "white", tl.col = "black", tl.srt = 45,
         addCoef.col = "black", order = "AOE", type = "upper", diag = F)

##type = "lower" y "diag" = F para borrar partes de la matiz, ya que es simétirca

'Con GGPLOT'
##install.packages("reshape2")

library(reshape2)
##Fundimos la matriz de correlacióm
mtcars.melted <- melt(mtcars.cor)
##Ahora usamos ggplot
ggplot(mtcars.melted, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() + coord_fixed()

'Un mapa de calor (heatmap)'
#Definimos funciones para obtener la parte inferiro de una matriz simétrica

get_lower_triangle <- function(corrmat) {
    corrmat[upper.tri(corrmat)] <- NA
    return(corrmat)
}

#Definimos funciones para obtener la parte superior de una matriz simétrica

get_upper_triangle <- function(corrmat) {
    corrmat[lower.tri(corrmat)] <- NA
    return(corrmat)
}


##Una función para reordenar una matriz de correlación con base en un clustering
reorder_corrmat <- function(corrmat){
    dd <- as.dist((1-corrmat)/2)
    hc <- hclust(dd)
    corrmat <- corrmat[hc$order, hc$order]
}

cormat <-reorder_corrmat(mtcars.cor)
cormat.upper.triangle <- get_upper_triangle(cormat)
cormat.upper.triangle.melted <- melt(cormat.upper.triangle, na.rm = T)

##Ploteamos

ggplot(cormat.upper.triangle.melted, aes(Var2, Var1, fill = value)) +
    geom_tile(color = "white") + scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                                                      midpoint = 0, limit = c(-1,1), name = "Pearson\nCorrelation")+
    coord_fixed() + theme_minimal()
    
