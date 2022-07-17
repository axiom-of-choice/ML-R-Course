library(caret)

auto <- read.csv("Tema4/data/auto-mpg.csv")

auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3c","4c","5c","6c","8c"))

set.seed(2018)
##Intentaremos predecir el consumo del auto en función de todas las demás
t.ids <- createDataPartition(auto$mpg, p=0.7, list = F)
names(auto)
##Ojo con las variables que no nos dan información relevante
##Por eso quitamos la columna 1, 8 y 9
##Construimos el linear model
mod <- lm(mpg ~., data = auto[t.ids, -c(1,8,9)])

mod

##En este caso el modelo elabora lo siguiente para predecir mpg

#mpg = 37.284202 + 6.231475 *4c +  8.248195*5c + 2.131026*2c
#    + 4.568171*8c + 0.002245*displacement - 0.057543*horsepower
#    - 0.004665* weight + 0.050745*acceleration

summary(mod)
##Los residuos son los errores de la estimación 
boxplot(mod$residuals)
##Nos interesan p valores bajos
##Adjusted R-Squared nos dice qué porcentaje de los valores explicamos con el modelo



##Podemos calcular el rmse

sqrt(mean((mod$fitted.values - auto[t.ids,]$mpg)^2))


pred <- predict(mod, auto[-t.ids,-c(1,8,9)])
###El error cuadrático medio de las prediccioes es este:
sqrt(mean((pred - auto[-t.ids,]$mpg)^2))

##Podemos hacer un plot del propio modelo 
par(mfrow = c(2,2))
plot(mod)

##Podemos tomar diferentes factores de referencia, por ejemplo con la función within
##Ya que tenemos más autos de 4 cilindros que de 3 cilindros
auto <- within(auto, cylinders <- relevel(cylinders, ref = "4c"))

mod2 <- lm(mpg ~., data = auto[t.ids,-c(1,8,9)])
##Observe los cambios en los valores 
mod2


pred2 <- predict(mod2, auto[-t.ids, -c(1,8,9)])
sqrt(mean((pred2 -auto[-t.ids,]$mpg)^2))
plot(mod2)
summary(mod2)


##Podemos usar la función step para simplificar el modelo
library(MASS)

##Con esto, el modelo quita variables de un modelo completo para simplificarlo
step.model <- stepAIC(mod2, direction = "backward")
##Con esto vemos las variables que va quitando que no aportan significatividad y el modelo sigue siendo eficiente
summary(step.model)



