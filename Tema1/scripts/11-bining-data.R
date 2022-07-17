students <- read.csv("CursoUdemyMLR/Sección 1/data/data-conversion.csv")

##Creando una variable categórica para resumir el nivel de ingresos
##Breakpoints
bp <- c(-Inf, 10000, 31000, Inf)
##nombre de las categorías
names <- c("Low", "Average", "High")
##Creamos la nueva variable categórica
##Se incluye la frontera superior pero no la inferior, observe 10000
students$Income.cat <- cut(x = students$Income, breaks = bp,
                            labels = names)
##Se le asigna de nombre el intervalo donde cae.
students$Income.cat2 <- cut (x = students$Income, breaks = bp)

##Podemos dejar que cut() gestione la mejor forma de cortar los datos
##Solo le decimos cuántos intervalos queremos

students$Income.cat3 <- cut(students$Income, breaks = 4,
                            labels = c("Level 1", "Level 2", 
                                       "Level 3", "Level 4"))

##Dummy variables (ficticias)
##Crea variable categóricas para variables no numéricas
install.packages("dummies")
library(dummies)
##Todo el data frame
students.dummy <- dummy.data.frame(students, sep = ".")
##Solo una columna
students.dummy.state <- dummy(students$State, sep=".")
##Ojo
students.dummy.state_gender <-
  dummy.data.frame(students, names = c("State", "Gender"), 
                   sep =".")
