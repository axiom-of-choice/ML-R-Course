##install.packages("GGally")
library(ggplot2)
library(GGally)
'Plots multivariantes'

bike <- read.csv("Tema7/data/daily-bike-rentals.csv")
head(bike)

##Transform variables into factor
bike$season <- factor(bike$season, levels = c(1,2,3,4), labels = c("Invierno", "Primavera", "Verano", "Otoño"))
bike$weathersit <- factor(bike$weathersit, levels = c(1,2,3), labels = c("Despejado", "Nublado", "Mal tiempo"))
bike$weekday <- factor(bike$weekday, levels = 0:6, labels = c("D", "L", "M", "X", "J", "V","S"))
##Obseve esta vriable
hist(bike$windspeed)
##Podemos cortarla en valores categóricas
bike$windspeed.fac <- cut(bike$windspeed, breaks = 3, labels = c("Poco", "Medio", "Elevado"))
head(bike)

#Ahora sí el análisis multivariante
##Observe eje x temperatura, eje y count, color como tipo de viento
ggplot(bike, aes(x = temp, y = cnt)) +
    geom_point(size = 3, aes(colour = windspeed.fac)) +theme(legend.position = "bottom") + 
    xlab(label = "Temperatura") + ylab("Count") + geom_smooth(method = "lm", se = F, col = "brown") + ##Recta de regresión
    facet_grid(weekday ~ season) ##gráfico dividido por estación y por día de la semana


##Gráficos multivariantes con GGALLY

auto <- read.csv("Tema7/data/auto-mpg.csv", stringsAsFactors = F)
head(auto)
auto$cylinders <- as.factor(auto$cylinders)
levels(auto$cylinders) <- c("3c", "4c", "5c", "6c", "8c")
auto$cylinders
#Hacemos un gráfico multivariante cruzando dos a dos las variables y se colorea con respecto a los cilindros
##Luego podemos modificar este mapa para que aparezcan otro tipo de gráficos
ggpairs(auto[,2:5], aes(colour = cylinders, alpha = 0.4), title = "Análisis multivariante de coches") + 
    theme(plot.title = element_text(hjust = 0.5))


'''Para guardar una imagen de R en código'''

##En formato pdf
##pdf(file = "Multivariante.pdf")
png(filename = "Multivariante.png", width = 3000, height = 3000, res = 72)

##Luego podemos modificar este mapa para que aparezcan otro tipo de gráficos
ggpairs(auto[,2:7], aes(colour = cylinders, alpha = 0.4), title = "Análisis multivariante de coches",
        upper = list(continuous = "density"), lower = list(combo = "denstrip")) + 
    theme(plot.title = element_text(hjust = 0.5))

dev.off()
