##La de boston con missing values

housing.data <- read.csv(file = "data/housing-with-missing-value.csv",
                         header = TRUE, stringsAsFactors = FALSE)

summary(housing.data)


##quitar todas las observaciones que contengan algún NA

housing.data.1 <- na.omit(housing.data)

##Eliminar las NA's de ciertas columnas

drop_na <- c("rad")
housing.data.2 <- housing.data[
  complete.cases(housing.data
                 [,!names(housing.data)%in% drop_na]),]

summary(housing.data.2)


##Podemos eliminar toda una columna del dataframe
##Si tenemos una columna demasiado corrupta
housing.data$rad <- NULL

delete <- c("rad", "ptratio")
housing.data.3 <- housing.data[, !names(housing.data)
                               %in% delete]

install.packages("Hmisc")
library(Hmisc)

housing.data.copy1 <- housing.data
##Función impute para cambiar los NA por la media
housing.data.copy1$ptratio <- impute(x = housing.data.copy1$ptratio,
                                     fun = mean)

housing.data.copy1$rad <- impute(housing.data.copy1$rad,
                                 mean)


summary(housing.data.copy1)

housing.data.copy2 <- housing.data

##Ahora los cambiamos con la mediana

housing.data.copy2$ptratio <- impute(x = housing.data.copy2$ptratio,
                                     fun = median)

housing.data.copy2$rad <- impute(x = housing.data.copy2$rad,
                                     fun = median)

summary(housing.data.copy2)

##Para cambiarlo con un valor constante cualquiera

  housing.data.copy3 <- housing.data 
housing.data.copy3$ptratio <- impute(housing.data.copy3$ptratio,
                                     18)

housing.data.copy3$rad <- impute(housing.data.copy3$rad,
                                     7)

summary(housing.data.copy3)
##Paquete mice
install.packages("mice")

library(mice)
##Cuando falta información podemos ver el patrón que sigue la información faltante

md.pattern(housing.data)

##Podemos ver gráficamente esta
##Falta de información
install.packages("VIM")

library(VIM)

aggr(housing.data, numbers=TRUE, sortVars = TRUE,
     labels = names(housing.data), 
     cex.axis =1, gap = 0.8)




