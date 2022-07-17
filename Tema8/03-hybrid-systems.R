'Sistemas de recomendaciones híbridos: UBCF + Random Selection'
'Se usa cuando tenemos nuevos ítems sin valoraciones'

library(recommenderlab)

data("MovieLense")

#filtro de información significativa

data_frame <- MovieLense[rowCounts(MovieLense)>50,]

train <- data_frame[1:100]
test <- data_frame[101:110]

hybrid_recom <- HybridRecommender(Recommender(train, method = "UBCF"), Recommender(train, method="RANDOM"),
                                  weights = c(0.75,0.25))

#validación del modelo con la info de test
as(predict(hybrid_recom,test,3), "list")


hybrid_recom2 <- HybridRecommender(Recommender(train, method = "UBCF"), Recommender(train, method="RANDOM"),
                                  weights = c(0.25,0.75))

as(predict(hybrid_recom2,test,3), "list")
