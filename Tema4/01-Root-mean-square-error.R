data <- read.csv("Tema4/data/rmse.csv")

##La medida del error cuadrático medio nos mide qué tan buenos son las predicciones de algunos valores

rmse <- sqrt(mean((data$price -data$pred)^2))

##Esto quiere decir cuánto nos equivamos con las predicciones respecto al valor original

##Podemos plotear el valor real frente al de la predicción

plot(x = data$price, y = data$pred, xlab = "Actual", ylab = "Predicho")
abline(0,1, col = "blue")

##Cuando calculamos el error cuadrático medio vemos cómo me alejo de la recta identidad
##También la podemos preparar con una función

rmsef <- function(actual, predicho){
    return(sqrt(mean((actual-predicho)^2)))
}

rmsef(data$price, data$pred)

