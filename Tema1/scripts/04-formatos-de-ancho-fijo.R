##Hay que poner los anchos del cada columna, se toma la más larga
students_data <- read.fwf("../Documents/CursoUdemyMLR/Sección 1/tema1/student-fwf.txt"
                          , widths = c(4,15,20,15,4),
                          col.names = c("ID", "Nombre", "email", "carrera", "año"))

##Fichero con cabecera, no respeta la anchura manejada

students_data <- read.fwf("../Documents/CursoUdemyMLR/Sección 1/tema1/student-fwf.txt"
                          , widths = c(4,15,20,15,4),
                          header = TRUE, sep = "\t",
                          skip = 2)

##Excluir columnas
students_data_no_email <- read.fwf("../Documents/CursoUdemyMLR/Sección 1/tema1/student-fwf.txt"
                          , widths = c(4,15,-20,15,4),
                          col.names = c("ID", "Nombre", "carrera", "año"))
