'''Treemaps'''
##install.packages("treemap")
library(treemap)
##Creamos unas ramas, subramas y valores
branch <- c(rep("branch-1", 4), rep("branch-2", 2), rep("branch-3", 3))
subbranch <- paste("subbranch", c(1,2,3,4,1,2,1,2,3), sep = "-")
values = c(15,4,22,13,11,8,6,1,25)

data <- data.frame(branch, subbranch,values)
View(data)

##Ahora hacemos el gráfico de árbol
treemap(data, index = c("branch", "subbranch"), vSize = "values",type = "index" )
##Se representan con área dependiendo de qué tan "grandes" son los values

posts <- read.csv("r-course-master/data/tema7/post-data.csv")
head(posts)

##Dividimos el treemap por categoría y por comentarios, donde el tamaño del área viene dado por las views
treemap(posts, index = c("category", "comments"), vSize = "views", type = "index")


logical <- c()
for (i in 1:length(posts$category)) {
    if (posts$category[i] == "Mistaken Data"){
    logical[i] = T
    } else {
        logical[i] = F
    }
}

