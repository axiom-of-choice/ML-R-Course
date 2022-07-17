data <- read.csv(file = "Documentos/CursoUdemyMLR/r-course-master/data/tema2/auto-mpg.csv",
                 stringsAsFactors = F)

##Queremos el modelo (año) del coche, y el nombre para los 5 primeros

data[1:5, 8:9]
data[1:5, c(8,9)]

##Poniendo el índice por nombre

data[1:5, c("model_year", "car_name")]


##Buscar el mínimo y máximo de MPG

data[data$mpg == max(data$mpg) | data$mpg== min(data$mpg),]


####Filtros con condiciones

##Que hagan mas de 30 millas por galon y de 6 cilindros
data[data$mpg >30 & data$cylinders == 6,]
##Podemos poner cyl en lugar de cylinders
data[data$mpg>30 & data$cyl==6, ]

##Usango la función in
data[data$mpg %in% c(15,20), c("mpg", "car_name")]


####Usamos la función subset 

subset(data, mpg>30 & cylinders ==6, 
       select = c("car_name", "mpg")) ##Select para idnicar las columnas que queremos

####Excluir columnas


#Seleccionar 5 filas, todas las columnas excepto la 1 y la 9
data[1:5, c(-1,-9)]
data[1:5, -c(1,9)] ##Solo funciona con las POSICIONES de las columnas

##Excluir columnas por nombre, usando la función names() e %in%
data[1:5, !names(data) %in% c("No", "car_name")]




