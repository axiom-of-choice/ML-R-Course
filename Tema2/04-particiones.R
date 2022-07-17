install.packages("caret")
library(caret)
data <- read.csv("Documentos/CursoUdemyMLR/r-course-master/data/tema2/BostonHousing.csv")

##Hacer particiones de un data frame con variables numéricas para las dos fases de machine learning
##HAcemos particiones de los datos, con un 80% para la fase de entrenamiento
##Conjunto de entrenamiento
training.ids <- createDataPartition(data$MEDV, p = 0.8, 
                                    list = F)
data.training <- data[training.ids, ]
##Conjunto de validación 
data.validation <- data[-training.ids,]


##HAcemos particiones de los datos, con un 70% para la fase de entrenamiento
##Generamos conjunto de índices
training.ids.2 <- createDataPartition(data$MEDV, p = 0.7, list = F)
data.training.2 <- data[training.ids.2,]
##Creamos una variable temporal
temp <- data[-training.ids.2,]
##Partimos a temp
validation.ids.2 <- createDataPartition(temp$MEDV, p= 0.5, list = F)
#La mitad de temp para validación
data.validation.2 <- temp[validation.ids.2,]
##La otra mitad para testing
data.testing <- temp[-validation.ids.2,]










###Particiones por variables categóricas

data2 <- read.csv("Documentos/CursoUdemyMLR/r-course-master/data/tema2/boston-housing-classification.csv")

training.ids3 <- createDataPartition(data2$MEDV_CAT,p=0.7,
                                     list = F)

data.training.3 <- data2[training.ids3,]
data.validation.3 <- data2[-training.ids3,]



#####Podemos automatizar todo este proceso
##dataframe es la data, tagert.index la cposición del índice sobre el qu queremos hacer la partición
##prob para cargar la prbabilidad de hacer la partición.
particion2 <- function(dataframe, target.index, prob) {
    library(caret) ##Cargamos la librería
    training.ids <- createDataPartition(dataframe[,target.index], p = prob, list=FALSE) ##índices 
    list(training = dataframe[training.ids,], validation = dataframe[-training.ids,])
}

###Con 3 particiones

particion3 <- function(dataframe, target.index,
                       prob.training, prob.validation){
    training.ids <- createDataPartition(dataframe[,target.index],
                                        p= prob.training, list=F)
    training.data <- dataframe[training.ids,]
    temp <- dataframe[-training.ids,]
    validation.ids <- createDataPartition(temp[,target.index], 
                                          p = prob.validation, list=F)
    list(training =  training.data , validation = temp[validation.ids,], 
         testing =  temp[-validation.ids,])
}

##Partimos data en 2, con función en la columna 14,  probabilidad 0.8
data1 <- particion2(data, 14, 0.8 )
##Partimos data en 3, con función en la columna 14,  probabilidad 0.7 para la primera, luego partimos en 2 el restante
data2 <- particion3(data, 14, 0.7, 0.5)

##Acedemos a la propiedad de las lista
head(data1$training)
head(data1$validation)
head(data2$training)
head(data2$validation)
head(data2$testing)
##Muestra aleatoria del primer dataframe
