##
'Sistema de recomendaciones colaborativo'
##


##install.packages("recommenderlab")
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

##
'Filtrado colaborativo basado en los items (IBCF)'
##

##Con este modelo, comparamos a las películas y con base en eso si su similitud es "grande" les recomendamos las películas a ciertos usuarios
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

##
'Filtrado colabortavito basado en usuarios (UBCF)'
##

ubcf <- Recommender(data = data_train, method = 'UBCF')     

ubcf.mod <- getModel(ubcf)
ubcf.mod

#DE nuevo, top ten recomendaciones para cada nuevo usuario
##Con este modelo, comparamos a los usuarios y con base en eso si su similitud es "grande" les recomendamos películas
ubcf.pred <- predict(object = ubcf, newdata = data_test, n = n_recom)

ubcf.pred

ubcf.rec.matrix <- sapply(ubcf.pred@items, function(x){
    colnames(rating_movies)[x]
})

View(ubcf.rec.matrix[,1:3])
head(ubcf.pred@items)

##Modelos de recomendación del paquete
recommender_models <- recommenderlab::recommenderRegistry$get_entries(dataType = 'realRatingMatrix')


'Visualización de la matriz de recomendaciones'

recommenderlab::image(MovieLense, main = 'Mapa de calor de la matriz de valoraciones de películas')


##Hay que usar un análisis sobre cuantiles


min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
min_n_users <- quantile(colCounts(MovieLense), 0.99)
##¿Cuántas películas tienen de 440 valoraciones en adelante?
min_n_movies
##¿Cuántas usarios tienen de 371 valoraciones en adelante?
min_n_users

#Por columnas tenemos a las películas más top
#Por filas vemos a los usuarios que valoran con mejor califación
image(MovieLense[rowCounts(MovieLense)>min_n_movies, colCounts(MovieLense)>min_n_users])

#Podemos ahcer un filtrado para quedarnos con las películas con suficiente rating, usuarios tambn

min_r_movies <- quantile(rowCounts(rating_movies),0.98)
min_r_users <- quantile(colCounts(rating_movies), 0.98)

image(rating_movies[rowCounts(rating_movies)>min_r_movies,
                    colCounts(rating_movies)>min_r_users], 
      main = 'Mapa de calor del top de películas y usuarios')


##
'Recomendaciones basadas en datos binarios'
##

#Función para binarizar si existe valoración, sino un cero

rating_movies_bin <- binarize(rating_movies, minRating = 1)

image(rating_movies_bin)

##Sistema de recomendaciones

##Conjunto de entrenamiento
t.ids <- sample(x = c(T,F), replace = TRUE, size = nrow(rating_movies_bin), prob = c(0.8,0.2))

b_data_train <- rating_movies_bin[t.ids,]
b_data_tes <- rating_movies_bin[!t.ids,]

#métrica para sistema de recomendaciones binario

#d(i,j) = (i & j) / (i | j)

#MODELO BASADO EN ÍTEMS 
b_model <- Recommender(data = b_data_train, method = 'IBCF', parameter = list(method = 'Jaccard'))
b_details <- getModel(b_model)
b_details

b_pred <- predict(object = b_model, newdata = b_data_tes, n = n_recom)
b_rec_matrix <- sapply(b_pred@items, function(x){
                                    colnames(rating_movies)[x]
})

View(b_rec_matrix[,1:3])
