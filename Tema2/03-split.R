##Función split y unsplit

data <- read.csv(file = "Documentos/CursoUdemyMLR/r-course-master/data/tema2/auto-mpg.csv",
                 stringsAsFactors = F)


##Dividimos el dataframe según variables categóricas, como cilindros
##Nos crea una lista de dataframes
carslist <- split(x = data, f = data$cylinders)

##Accediendo a un data frame en concreto
carslist[1] ##Te regresa el objeto de la lista, es una lsita

carslist[[1]] ##Te regresa ya el dataframe
carslist$`3`


str(carslist[1])
str(carslist[[1]])
str(carslist$`3`)


names(carslist[1])
names(carslist[[1]])
names(carslist$`3`)



