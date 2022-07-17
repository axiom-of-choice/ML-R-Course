install.packages("scales")

library(scales)

estudiantes <- read.csv("data/data-conversion.csv")


estudiantes$Income_rescaled <- rescale(estudiantes$Income)


##Función rescale manual en un rango [0,1]

(estudiantes$Income- min(estudiantes$Income))/(max(estudiantes$Income)- min(estudiantes$Income))

##Función rescale en un rango [0,100]

rescale(estudiantes$Income, to = c(0,100))


rescale.varios <- function (dataframe, cols){
  names <- names(dataframe)
  for (col in cols ){
    name <- paste(names[col], "reescalada", sep = ".")
    dataframe[name] <- rescale(dataframe[,col])
  }
  cat(paste("Hemos reescalado", length(cols), "variables"))
  dataframe
}


estudiantes <- rescale.varios(estudiantes, cols = c(1,4))

