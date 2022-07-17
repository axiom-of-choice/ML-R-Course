path = getwd()
path = paste(path,"/Tema1", sep = "")
setwd(path)
library(jsonlite)
##Leer datos de un JSOn
dat.1 <- fromJSON("data/students.json")
dat.2 <- fromJSON("data/student-courses.json")
##Se pueden cargar datos de internet
url_json <- "http://www.floatrates.com/daily/usd.json"
currencies <- fromJSON(url_json)
##Se puede extraer con el doble corchete
currencies[["eur"]]
##Se puede extraer con el $$
currencies$eur$rate
dat.1$Email
dat.2$Major
dat.2$courses

###To json
data_json <- toJSON("")

