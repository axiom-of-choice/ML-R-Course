cp <- read.csv("r-course-master/data/tema3/college-perf.csv")
##La columna perf es su perfomance real
##La columna Pred es una predicción con un modelo
##Vamos a "ordenar" 
cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))
cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))
                
##Creamos una tabla de doble entrada
##Nos da información acerca de la precisión del modelo
tabl <- table(cp$Perf,cp$Pred, dnn = c("Actual","Predicho"))
tabl

##Podemos usar la función prop.table para la probabilidad de la precisión del modelo.

prop.table(tabl)

##Podemos ver con esto en qué porcentaje de los casos acierta el modelo

round(prop.table(tabl, 1)*100, 2)


##Podemos hacer una barplot para ver todo esto gráficamente

barplot(tabl, legend=TRUE, xlab="Nota predicho por el modelo")

##Diagrama ÚTIL CON LAS MATRICES DE CONFUSIÓN
##Diagrama en forma de mosaico
##Observe que la anchura da información sobre las frecuencias de las categorías
mosaicplot(tabl, main = "Eficiencia del modelo")


summary(tabl)
##Observe los 3 parámetros importantes: Chisq (Xi cuadrada),
##Número de grados de libertad
##p-value: Un p-valor bajo indica que el modelo es eficiente (la independencia entre el valor actual y el predicho)

