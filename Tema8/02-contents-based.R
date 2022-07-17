'Filtros basados en el contenido'

library(recommenderlab)
movie_url <- 'http://files.grouplens.org/datasets/movielens/ml-100k/u.item'
users_url <- 'http://files.grouplens.org/datasets/movielens/ml-100k/u.data'

movie_title_df <- read.table(movie_url, header = F, sep = "|", quote = "\"")
users_df <- read.table(users_url, header = F, sep = "\t", quote = "\"")

'Los nombres los sacamos de aquí: https://grouplens.org/datasets/movielens/'

#Cambiamos los nombres de las columnas
names(movie_title_df) <- c("MovieID", "Title", "ReleaseDate","video_release_date","IMDb_URL", "unknown",
                           "Action","Adventure","Animation","Childrens","Comedy","Crime","Documentary",
                           "Drama","Fantasy", "FilmNoir","Horror","Musical","Mystery","Romance","SciFi",
                           "Thriller","War","Western")
#Eliminamos las variables que no interesan en nuestro análisis
movie_title_df$ReleaseDate <- NULL
movie_title_df$video_release_date <- NULL
movie_title_df$IMDb_URL <- NULL
#Eliminamos las filas con información repetida
movie_title_df <- unique(movie_title_df)
#Cambiamos el nombre de las columnas de users_df

names(users_df)<- c("UserID", "MovieID", "rating", "timestamp")
#De neuvo, eliminamos columnas inútiles
users_df$timestamp<-NULL


'Función que toma un dataframe como entrada y nos hace el clustering'
clusterMovies <- function(df, kclust = 10){
    #set.seed(2018)
    df <- df[,c(-1,-2)]
    mclust <- kmeans(df, centers = kclust, nstart = 20)
    return(mclust)
}
'Función que detecta las películas que un usuario ha visto y valorado'

getUserInfo <- function(df, id){
    myUser = subset(df, UserID==id, select = c(MovieID, rating))
    cluster <- 0 
    activeUser <- data.frame(myUser[order(myUser$MovieID),],cluster)
    return(activeUser)
}

'Asigna el número de CLuster a cada película que ha visto el usuario'

setUserMovieCluster <- function(m_title_df,mclust, activeUser){
    df_aux <- data.frame(cbind(m_title_df$MovieID, clustNum=mclust$cluster))
    names(df_aux)<-c("MovieID", "Cluster")
    activeUser$cluster <- df_aux[match(activeUser$MovieID, df_aux$MovieID),2]
    return(activeUser)
}

'Función para obetener el promedio de valoraciones por usuario de películas que ha visto en un mismo cluster'

getAverageClusterRating <- function(mclust,activeUser, minRating=3){
    like <- aggregate(activeUser$rating, by=list(cluster=activeUser$cluster), mean)
    if(max(like$x<minRating)){ #No hacer recomendaciones si no tiene películas con más de Minrating valoradas
        like <- as.vector(0)
    } else {
        like<-as.vector(t(max(subset(like, x>=minRating, select=cluster))))
    }
    return(like)
}

'Función que recomienda buenas películas basadas en sus gustos'

getRecommendedMovies <- function(like, mclust, m_title_df){
    df_aux <- data.frame(cbind(m_title_df$MovieID, clusterNum = mclust$cluster))
    names(df_aux) <- c("MovieID", "Cluster")
    if(like==0){
    recommend <- m_title_df[sample.int(n=nrow(m_title_df),size = 100),1]    
    }else{
    recommend <- as.vector(t(subset(df_aux, Cluster==like, select=MovieID)))
    }
}

'Función que utilice todas las demás funciones'
#Toma todas las películas, todos los usuarios y el usuario que quiere clasificar
getRecommendations <- function(movie_df, user_df, userID){
    mclust <- clusterMovies(movie_df)
    activeUser <- getUserInfo(user_df, userID)
    activeUser <- setUserMovieCluster(movie_df, mclust, activeUser)
    like <- getAverageClusterRating(mclust, activeUser)
    recomendation <- getRecommendedMovies(like, mclust, movie_df)
    #eliminamos las películas que el usuario ya ha visto
    recomendation <- recomendation[-activeUser$MovieID]
    #añadimos el título de la película
    movieTitle <- movie_df[match(recomendation, movie_df$MovieID),2]
    recomendation <- data.frame(recomendation, movieTitle)
    return(recomendation)
}

suggestMovies <- function(movie_df, user_df, user_id, num_movies){
    suggestions <- getRecommendations(movie_df, user_df, user_id)
    suggestions <- suggestions[1:num_movies,]
    writeLines("Tal vez te gustaría ver también las siguientes películas:")
    write.table(suggestions[2], row.names = F, col.names = F)
}

suggestMovies(movie_title_df,users_df,user_id = 196, 10)

