'Sistema de recomendaciones colaborativo'

install.packages("recommenderlab")
library(recommenderlab)

data("MovieLense")
head(MovieLense)

'Revisar con detalle realRatingMatrix'

##rowCounts(r) ## number of ratings per user
##colCounts(r) ## number of ratings per item
##colMeans(r) ## average item rating

##Nos quedamos con una muestra de de usuarios con más de 50 valoraciones y pelis con más de 100
rating_movies <- MovieLense[rowCounts(MovieLense)>50, colCounts(MovieLense)>100]

#3Observe cómo se guarda el data frame
rating_movies@data
#La información de toda la primera fila es del primer usuario valorando todas las películas
rating_movies@data[1,]
#La información de toda la primera columna guarda las valoracioens de la priemra película
rating_movies@data[,1]
#La valoración del primer usuario a la primera película
rating_movies@data[1,1]


head(rownames(rating_movies))
head(colnames((rating_movies)))
##Ids de conjunto de entrenamiento
t.ids <- sample(x = c(T,F), size = nrow(rating_movies), replace = T, prob = c(0.8,0.2))

data_train <- rating_movies[t.ids,]
data_test <- rating_movies[!t.ids,]

'Filtrado colaborativo basado en los items (IBCF)'

ibcf <- Recommender(data = data_train, method = "IBCF", parameter = list(k=30))

##Podemos observar la estructura del modelo como sigue
ibcf.mod <- getModel(ibcf)
ibcf.mod

n_recom = 10
##Hacemos la predicción de las n_recom películas recomendadas sobre el conjunto de testing
ibcf.pred <- predict(object = ibcf, newdata=data_test, n= n_recom)

ibcf.pred

##Hora hacemos uuna función que nos muestre para algún usuario, el nombre de las películas que le recomienda

ibcf.rec.matrix <- sapply(ibcf.pred@items, function(x){
    colnames(rating_movies)[x]
})

View(ibcf.rec.matrix[,1:3])

     