##Line charts para observar las relaciones entre 2 variables continuas (aunque también funciona con discretas en ele eje X)
library(ggplot2)
mtcars <- read.csv("Tema7/data/mtcars.csv", stringsAsFactors = F)
head(mtcars)

plot <- ggplot(data = mtcars, mapping = aes(wt, mpg))
plot + geom_line() + geom_line(color = "red") +
    geom_line(aes(color = as.factor(carb))) ##Se puede segmentar la información x2

