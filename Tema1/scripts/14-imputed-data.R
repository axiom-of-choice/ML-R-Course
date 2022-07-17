library(mice)

housing.data <- read.csv("CursoUdemyMLR/Sección 3/data/housing-with-missing-value.csv", 
                         header = TRUE, 
                         stringsAsFactors = FALSE)
##columnas con NA's
columns <- c("ptratio", "rad")

##Función imputed_data para gestionar la información 
##que falta, haciendo uso de técnicas de análisis multivariado
##Solo nos crea un modelo de datos
imputed_data <- mice(housing.data[, names(housing.data) %in% columns],
                     m=5, maxit = 50, method = "pmm",
                     seed = 2018)
summary(imputed_data)
##Existen 4 métodos pmm --  Comparación predictiva de medias
##logreg -- regresión logística
##polyreg -- regresión logística politómica
##polr -- modelo de probabilidades proporcionales

##Aplicamos el modelo de datos y que se genere la información
##Que inferimos con nuestro modelo predictivo
complete.data <- complete(data = imputed_data)

##Ahora completamos la housing con la completa

housing.data$ptratio <- complete.data$ptratio
housing.data$rad <- complete.data$rad

##Así nos damos cuenta de que no hay más NA's
anyNA(housing.data)

library(Hmisc)

impute_arg <- aregImpute(~ptratio + rad, data = housing.data, 
                         n.impute = 5)

impute_arg

