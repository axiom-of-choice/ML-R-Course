data <- read.csv("../Documents/CursoUdemyMLR/Sección 1/data/missing-data.csv", na.strings = "")
##_Rellenar casos NA con la media y agregarla comonueva columna

data$Income_mean <- ifelse(is.na(data$Income), mean(data$Income, na.rm = TRUE),
                           data$Income)


##Función para reemplazar valores por un valor aleatorio de la muestra
##X es un vector de datos que puede contener NA
##Missing es un vector del mismo tamaño que X booleano
##n.missing es el número de missing de X

random_replace <- function(x) {
  ##X es un vector de datos que puede contener NA
  ##Missing es un vector del mismo tamaño que X booleano
  missing <- is.na(x)
  ##n.missing es el número de missing de X
  
  n.missing <- sum(missing)
  ##x.obs son los valores que no son NA en X
  x.obs <- x[!missing]
  ##Por defecto se devuelve lo mismo que entra por parámetro
  replace <- x
  ##en los valores que faltan los reemplazas por una muestra de los que se conocen
  replace[missing] <- sample(x.obs, n.missing, replace = TRUE)
  return(replace)
}


random_replace_data_frame <- function(dataframe, cols){
  names <- names(dataframe)
  for (col in cols){
    name <- paste(names[col], "replaced", sep="")
    dataframe[name] = random_replace(dataframe[,col])
    
  }
  dataframe
}

data$Income[data$Income==0] <- NA
data_replaced <- random_replace_data_frame(dataframe = data, cols = c(1,2))
