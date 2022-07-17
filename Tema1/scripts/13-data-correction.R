install.packages("tidyr")

library(tidyr)


crime.data <- read.csv("CursoUdemyMLR/Sección 3/data/USArrests.csv",
                       stringsAsFactors = FALSE)

##Añadir una columna
crime.data <- cbind(state= rownames(crime.data), 
                    crime.data)


##Variante

crime.data.1 <- gather(crime.data, key = "crime_type",
                       value = "arrest_estimate",
                       Murder : UrbanPop)

##Toda las variables se traducen a la columna
##Clave-valor excepto state
crime.data.2 <- gather(crime.data, key="crime_type",
                       value = "arrest_estimate",
                       -state)

##De nuevo pero con columnas específicas: Murder y ASsault

crime.data.3 <- gather(crime.data, key="crime_type",
                        value="arrest_estimate",
                        Murder, Assault)

##Podemos revertir el proceso siempre que le demos el nombre de la columna clave
##Y el nombre de la columna con las valores que resumimos antes
crime.data.4 <- spread(crime.data.2, key = "crime_type",
                       value = "arrest_estimate")

##Para juntar información separa en dos columnas
##En una sola, como el nombre y apellidos, o correo, etc.
##Ojo con los spearadores que debemos usar
crime.data.5 <- unite(crime.data, col = "Murder_Assault",
                      Murder, Assault, sep = "_")

##Podemos separar algo que unimos con algún separador concreto como con UNITE()

crime.data.6 <- separate(crime.data.5, col = "Murder_Assault",
                         into = c("Murder", "Assault"), 
                         sep = "_")
