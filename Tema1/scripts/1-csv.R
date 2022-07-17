setwd("C:/Users/Leo/Documents/CursoUdemyMLR/Sección 1/tema1")
auto <- read.csv(file = "auto-mpg.csv", header = TRUE)
names(auto)
auto_no_cabecera <- read.csv("auto-mpg-noheader.csv",header = FALSE)
names(auto_no_cabecera)
##names(auto_no_cabecera) <- names(auto)
##Read from URL web
who_from_internet <- read.csv("https://frogames.es/course-contents/r/intro/tema1/WHO.csv")
