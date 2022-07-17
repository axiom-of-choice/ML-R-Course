##install.packages(c("OpenImageR", "ClusterR"))

library(OpenImageR)

library(ClusterR)

##Con esto, podemos leer im+agenes
img <- readImage("C:/Users/param/OneDrive/Documentos/WIN_20210414_17_31_16_Pro.jpg")
##Se puede hacer una reducción de la imagen
img.resize <- resizeImage(img, 350, 350, method = "bilinear")

imageShow(img.resize)

img.vector <- apply(img.resize, 3, as.vector)

dim(img.vector)


kmmb <- MiniBatchKmeans(img.vector, clusters = 10, batch_size = 20,
                        num_init = 5, max_iters = 100, 
                        init_fraction = 0.2, initializer = "kmeans++",
                        early_stop_iter = 10,
                        verbose = F)

kmmb
prmb <- predict_MBatchKMeans(img.vector, kmmb$centroids)
prmb

get.cent.mb <- kmmb$centroids

new.img <- get.cent.mb[prmb,]
dim(new.img) <- c(nrow((img)), ncol(img), 3)

imageShow(new.img)

