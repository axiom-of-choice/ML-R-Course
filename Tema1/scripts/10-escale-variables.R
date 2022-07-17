housing <- read.csv("data/BostonHousing.csv")

##Con valores normalizados (estandarizados)
##Distribución normal
##Scale usar sin variables categóricas

housing.z <- scale(housing)
##Es lo mismo que 
housing.z <- scale(housing, center=TRUE, scale = TRUE)

##ALgo igual que housing sin reescalar

housing.none <- scale(housing, center = FALSE, scale = FALSE)


##Algo distinto 

housing.onlymean <- scale(housing, center = TRUE, scale = FALSE)


##Otro distinto

housing.onlysd <- scale(housing, center = FALSE, scale = TRUE)



##Estandarizar varias variables simultáneas y conservar las orgiinales

scale.varios <- function(dataframe, cols){
  names <- names(dataframe)
  for (col in cols){
    name <- paste(names[col], "z", sep = ".")
    dataframe[name] <- scale(dataframe[,col])
  }
  cat(paste("Hemos normalizado", length(cols), "variables"))
  dataframe
}


##Prueba

housing_3_escaladas<- scale.varios(housing, c(1,2,3))

