##Transformar espacios vacíos en na.strings
data <- read.csv("../Documents/CursoUdemyMLR/Sección 1/data/missing-data.csv", na.strings = "")

##Extraer la data limpia

data_limpia <- na.omit(data)


is.na(data)

##Eliminar NA's de solo la variable INCOME
data_income_clean <- data[!is.na(data$Income),]

##Te dice qué filas tiene o no NA's
complete.cases(data)

##Otra manera de extraer data limpia

data_limpia_2 <- data[complete.cases(data),]

##Convertir los ceros de ingresos en NA's

data$Income[data$Income == 0] <- NA

##Medidas de tendencia central y dispersión

mean(data$Income, na.rm = TRUE)


sd(data$Income, na.rm = TRUE)
