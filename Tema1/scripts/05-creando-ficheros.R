clientes <- c("J.G", "Ric", "Ped")
fechas <- c("2017-12-27", "2017-11-1", "2018-1-1")
fechas <- as.Date(fechas)
pagos <- c(315, 192.55, 40.15)

pedidos <- data.frame(clientes, fechas, pagos)

##guardar un objeto

save(pedidos, file = "CursoUdemyMLR/SecciÃ³n 1/tema1/mi_fichero_pedidos.Rdata")
saveRDS(pedidos, file = "CursoUdemyMLR/SecciÃ³n 1/tema1/pedidos.rds")



load("../Documents/CursoUdemyMLR/Sección 1/data/pedidos.Rdata")

orders <- readRDS("../Documents/CursoUdemyMLR/Sección 1/data/pedidos.rds")


data("iris")
data("cars")

save.image(file = "../Documents/CursoUdemyMLR/Sección 1/data/alldata.Rdata")
 
 