path = getwd()
path = paste(path,"/Tema1", sep = "")
setwd(path)
auto <- read.csv(file = "data/auto-mpg.csv", header = TRUE)
names(auto)
auto_no_cabecera <- read.csv("data/auto-mpg-noheader.csv",header = FALSE)
names(auto_no_cabecera)
##names(auto_no_cabecera) <- names(auto)
##Read from URL web
who_from_internet <- read.csv("https://frogames.es/course-contents/r/intro/tema1/WHO.csv")

