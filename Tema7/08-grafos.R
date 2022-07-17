'''Gráfico en forma de redes'''
##Sirven para relaciones entre cositas
library(igraph)

##Grafos dirigidos

dir.graph <- graph(edges = c(1,2,2,3,2,4,1,4,5,5,3,6,5,6),
                    n = 6)

non.dir.graph <- graph(edges = c(1,2,2,3,2,4,1,4,5,5,3,6,5,6),
                   n = 6, directed = F)
##Ploteamos
plot(dir.graph)
plot(non.dir.graph)

##Con vértices sueltos (aislados) y vértices etiquetados con nombres
isolated.graph <- graph(edges = c("Juan", "María", "María", "Ana", "Ana", "Juan", "Jose", "María"),
                        isolates = c("Carmen","Antonio", "Mario", "Vicente"))

plot(isolated.graph, edge.arrow.size = 1, vertex.color = "gold", vertex.size = 25, vertex.frame.color = "gray",
     vertex.lable.cex = 1.2, edge.curved = 0.1, vertex.label.dist = 2)

