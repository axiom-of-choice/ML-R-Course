auto <- read.csv("Documentos/CursoUdemyMLR/r-course-master/data/tema2/auto-mpg.csv")

##Transformar a vairable categórica los cilindros
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3cil", "4cil", "5cil","6cil", "8cil"))

##Función attach para que el data set forme parte del ambiente principal de R
attach(auto)
##Ahora podemos tratar las columnas como variables sin escribir $
head(cylinders)

##Histograma de frecuencias para variables numéricas
hist(acceleration, col = "blue", xlab = "Aceleración",
     ylab= "Frecuencias", main = "Histograma de aceleración",
     breaks = 16)

##Boxplots 
boxplot(mpg, xlab = "Millas por galón")
##Boxplot para representar una varable en función de otra
boxplot(mpg ~ model_year, xlab = "Millas por galón (por año)")
##Podemos ver tendencias en función de otras variables
boxplot(mpg ~ cylinders, xlab = "Consumo por número de cilindros")
##Cuidado cuando hay muchos valores outlines o la caja es muy pequeña




##Scatterplot para pintar dos variables numéricas
##Una se coloca sobre eje X, el otro sobre eje Y
plot(mpg ~ horsepower)
plot(horsepower, mpg)



##Matriz de Scatterplots para ver si variables tienen relación o no.
pairs(~mpg+displacement+horsepower+weight)




##Función rainbow para obtener un arcoiris en los colores
hist(acceleration, col = rainbow(16), xlab = "Aceleración",
     ylab= "Frecuencias", main = "Histograma de aceleración",
     breaks = 16)



##En los boxplots, podemos darle todo el data frame 
boxplot(auto)
##Podemos juntar dos o más plots encima
##Por ejemplo, la función de densidad y el histograma

hist(mpg,probability = TRUE)
lines(density(mpg))



##Crear un modelo de regresión lineal y pintar la recta de regresión sobre un scatter plot
plot(mpg~horsepower)
linearmodel <- lm(mpg~horsepower)
abline(linearmodel)
##Agregar colores para cada cilindrada
plot(mpg~horsepower, type = "n")
abline(linearmodel)
with(subset(auto, cylinders == "8cil"), 
     points(horsepower, mpg, col = "red"))
with(subset(auto, cylinders == "6cil"), 
     points(horsepower, mpg, col = "yellow"))
with(subset(auto, cylinders == "5cil"), 
     points(horsepower, mpg, col = "green"))
with(subset(auto, cylinders == "4cil"), 
     points(horsepower, mpg, col = "blue"))
with(subset(auto, cylinders == "3cil"), 
     points(horsepower, mpg, col = "black"))


##Combinación de plots con la función par()
old.par <- par()
old.par

par(mfrow = c(1,2)) ##UNa fila, dos columnas

with(auto,{
        plot(mpg~weight, main ="Peso vs Consumo")
        plot(mpg~acceleration, main = "Aceleración vs Consumo")
})
