ozone.data <- read.csv("Documentos/CursoUdemyMLR/Sección 3/data/ozone.csv",
                       stringsAsFactors = FALSE)

##Determinamos outliers en la variable presión
##main para poner el título
outlier.values <- boxplot(ozone.data$pressure_height,
                          main =  "Pressure Height",
                          boxwex = 0.5)

summary(ozone.data$pressure_height)

##Podemos ver pressure height, en función del mes
boxplot(ozone.data$pressure_height ~ ozone.data$Month)
boxplot(pressure_height~Month, data = ozone.data,
        main =  "Pressure Height Per Month")$out

##Se pueden consultar los outliers con el parámetro $out al final del boxplot




##Función que reemplaza valores outliers por la media o la mediana,
##dependiendo si está antes del cuantil 5, o después del 95
impute_outliers <- function(x, removeNA = TRUE){
    quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
    x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
    x[x>quantiles[2]] <- median(x, na.rm = removeNA)
    return(x)
}
##Le aplicamos la función
imputed_data <- impute_outliers(ozone.data$pressure_height)

##Podemos hacer dos gráficos en una sola imagen
par(mfrow =  c(1,2))
boxplot(ozone.data$pressure_height, main =  "Pesión con outliers")
boxplot(imputed_data, main =  "Boxplot sin outliers")


##Otra función para reemplazar los valores

replace_outliers <- function(x, removeNA=TRUE){
    qrts <- quantile(x, probs = c(0.25,0.75), na.rm = removeNA)
    caps <- quantile(x, probs = c(0.05, 0.95), na.rm = removeNA)
    iqr <- qrts[2]-qrts[1]
    h <- 1.5*iqr
    x[x<qrts[1]-h] <- caps[1]
    x[x>qrts[2]+h] <- caps[2]
    return(x)
}

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main =  "Pesión con outliers")
capped_pressure_height <- replace_outliers(ozone.data$pressure_height)
boxplot(capped_pressure_height, main =  "Boxplot sin outliers")

