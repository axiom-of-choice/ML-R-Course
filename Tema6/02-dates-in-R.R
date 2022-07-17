##EPOCH: 1 DE ENERO DE 1970

##Para saber la fecha de hoy

Sys.Date()


##El formato de la fecha
as.Date("1/1/80", format = "%m/%d/%y")


##Año en dos dígitos o año en cuatro dígitos
as.Date("1/1/1980", format =  "%m/%d/%Y")


##SI NO USAMOS FORMAT, SE DEBE DE USAR LOS FORMATOS

as.Date("2021-04-26")


nac <- as.Date("1999/05/26")


##PODEMOS TRANSFORMAR DE FECHA A NÚMERO
##El número de días que pasaron del EPOCH a mi nacimiento
as.numeric(nac)
##El número de días que han pasado desde el EPOCH a hoy

as.numeric(Sys.Date())


##FORMATO PARA DAR NOMBRE A LOS MESES

as.Date("ene. 6, 2020", format = "%b %d, %Y")
as.Date("enero 6, 2020", format = "%B %d, %Y")

##Creamos fechas desde días de EPOCH

dt <- 2021

class(dt) <- "Date"

dt 


dt <- -2021
class(dt) <- "Date"
dt


##Fechas desde un determinado día

dt <- as.Date(2021, origin = as.Date("1999-05-26"))
dt


##Componentes de las fechas
dt

format(dt, "%Y")

##Como número en lugar de string

as.numeric(format(dt, "%Y"))

##Dos dígitos
format(dt, "%y")

as.numeric(format(dt, "%y"))

##Mes como string

format(dt, "%b")

format(dt, "%B")

months(dt)

weekdays(dt)

quarters(dt)

julian(dt)



dt <- as.Date("2001-01-01")
##Sumando 100 días
dt + 100
dt-100
dt+31


dt2 <- as.Date("2001/01/02")

##Podemos restar dos fechas

dt2 -dt
dt-dt2
dt-dt

##O como en número
as.numeric(dt2-dt)

##Comparaciones

dt<dt2

dt2<dt

dt==dt2

##Se pueden hacer sequencias de fecha

##Mes a mes
seq(dt, dt+365, "month")

##Día a día
seq(dt, dt+10, "day")

##Bimestrales
seq(dt, dt+365, "2 month")

##Una secuencia con punto inicial cada cuatro meses y longitud 6
seq(from = dt, by = "4 months", length.out = 6)


seq( from = dt, by = "3 weeks", length.out = 6)
