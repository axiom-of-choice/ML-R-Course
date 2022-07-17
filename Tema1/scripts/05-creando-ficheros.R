path = getwd()
#path = paste(path,, sep = "")
setwd(path)
clientes <- c("J.G", "Ric", "Ped")
fechas <- c("2017-12-27", "2017-11-1", "2018-1-1")
fechas <- as.Date(fechas)
pagos <- c(315, 192.55, 40.15)

pedidos <- data.frame(clientes, fechas, pagos)

##guardar un objeto

save(pedidos, file = "./mi_fichero_pedidos.Rdata")
saveRDS(pedidos, file = "./pedidos.rds")



load("data/pedidos.Rdata")

orders <- readRDS("data/pedidos.rds")


data("iris")
data("cars")

save.image(file = "data/alldata.Rdata")
 
 