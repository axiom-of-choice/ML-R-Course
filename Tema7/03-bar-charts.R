##Diagrama de barras para contar número de ocurrrencias de cada vairbale tipo categórico

bike <- read.csv("r-course-master/data/tema7/daily-bike-rentals.csv")

##Trandformamos a factor la season, workingday y weathersit

bike$season <- factor(bike$season, levels = c(1,2,3,4), labels = c("Invierno", "Primavera", "Verano", "Otoño"))
bike$workingday <- factor(bike$workingday, levels = c(0,1), labels = c("Descanso", "Laboral"))
bike$weathersit <- factor(bike$weathersit, levels = c(1,2,3), labels = c("Buen tiempo", "Nublado", "Mal tiempo"))

##Número total de alquileres de bicicleta por estación con la biblioteca dplyr

##install.packages("dplyr")
library(dplyr)

bike.sum <-  bike %>% 
    group_by(season, workingday) %>%
    summarize(rental = sum(cnt))

##Ahora hacemos una barchart
library(ggplot2)
ggplot(bike.sum, aes(x=season, y = rental, fill = workingday, label = scales::comma(rental))) + 
    geom_bar(show.legend = T, stat = "identity") + ##Stat = identity es para decir que la "y" ya es parte de la info resultdo
    labs(title = "Alquileres de bicicletas por estación y día") +
    scale_y_continuous(labels = scales::comma) + ##Esto para obtener mejores cotas superiores de valores
    geom_text(size = 3, position = position_stack(vjust = 0.5)) ##Esto para poner los números en el gráfico


