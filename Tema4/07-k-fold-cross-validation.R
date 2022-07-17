##Es una técnica para elegir o cruzar validaciones

bh <- read.csv("Tema4/data/BostonHousing.csv")

##Creamos dos funciones

##Esta se utiliza para crear un muestreo desde uno hasta el número de divisiones
##Para obtener 5 subconjuntos del conjunto de partida original
kfold.crossval.reg <- function(df, nfolds){
    fold <- sample(1:nfolds, nrow(df), replace = T)##Hacemos divisiones
    mean.sqr.errs <- sapply(1:nfolds, kfold.cval.reg.iter,
                            df, fold)
    list("MSE" = mean.sqr.errs,
         "Overall_Mean_Sqr_Error" = mean(mean.sqr.errs),
         "Std_dev_Mean_Sqr_Error" = sd(mean.sqr.errs))
    
}

kfold.cval.reg.iter <- function(k, df, fold){
    tr.ids <- !fold %in% c(k)
    test.ids <- fold %in% c(k)
    mod <- lm(MEDV~., data = df[tr.ids,]) ##Podemos usar otro tipo de modelo también, no solo lm
    pred <- predict(mod, df[test.ids,])
    sqrt.errs <- (pred -df[test.ids,"MEDV"])^2
    mean(sqrt.errs)
}

 res <- kfold.crossval.reg(bh, 5)
 
 res
 
 
 ##Lo podemos hacer con leave one out cross validation

 loocv.reg <- function(df){
     mean.sqr.errors <- sapply(1:nrow(df), loocv.reg.iter,
                               df)
     list("MSE" = mean.sqr.errors,
          "Overall_mean_square_errors" = mean(mean.sqr.errors),
          "sd_mean_sqr_errors" = sd(mean.sqr.errors))
 }
 
 loocv.reg.iter <- function(k, df){
     mod <- lm(MEDV~., data = df[-k,])
     pred <- predict(mod, df[k,])
     sqrt.error <- (pred-df[k,"MEDV"])^2
     sqrt.error
 }
 
 
 
 res <- loocv.reg(bh)
 