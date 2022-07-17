library(ggplot2)

geiser <- read.csv("Tema7/data/geiser.csv")
##Mediciones sobre erupciones de geiser
head(geiser)

##Hacemos un histograma para observar los datos

plot <- ggplot(data = geiser, aes(waiting))
plot + geom_histogram()
plot + geom_histogram(binwidth = 5, fill = "white", colour = "black")


##Con el argumento y = ..densitiy.. escalamos las variables
ggplot(geiser, aes(x = waiting, y = ..density..)) + geom_histogram(fill = "cornsilk", colour = "grey "
                                                                   ,size=0.2) + geom_density() + 
    xlim(c(30,110))

##Com geom_density, comparamos la distribución teórica vs los datos que tenemos


##Ahora lo hacemos para la otra columna

ggplot(geiser, aes(x = eruptions, y = ..density..)) + geom_histogram(fill = "cornsilk", colour = "grey "
                                                                   ,size=0.2) + geom_density() + 
    xlim(c(0,7))
