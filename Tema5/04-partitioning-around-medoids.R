protein <- read.csv("Tema5/data/protein.csv")
rownames(protein) <- protein$Country
protein$Country <- NULL
protein.scaled <- as.data.frame(scale(protein))

library(cluster)
library(factoextra)

##Clusters con k medoids
##partinioning around medoids
km <- pam(protein.scaled, 4)
km

fviz_cluster(km)


##Clustering large application funciona para arrays grandes
##Funciona con muestreos de el data set y aplicando PAM 

clarafit <- clara(protein.scaled, 4, samples = 5)
clarafit

fviz_cluster(clarafit)
