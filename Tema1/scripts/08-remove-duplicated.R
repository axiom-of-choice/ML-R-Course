salarios_familia <- c(40000, 60000, 50000, 80000, 60000,70000,60000)

tamaño_familia <- c(4,3,2,2,3,4,3)

coche_familia <- c("Lujo", "Compacto", 
                   "Utilitario", "Lujo", 
                   "Compacto", "Compacto", "Compacto")

familia <- data.frame(salarios_familia, 
                      tamaño_familia,
                      coche_familia)

##Sacar un data frame con entradas no duplicadas
familia_unique <- unique(familia)

##Detectar las duplicadas sin eliminarlas

duplicated(familia)

familia[duplicated(familia), ]
