AMZN <- read.csv("r-course-master/data/tema6/AMZN.csv", stringsAsFactors = F)

head(AMZN)

AAPL <- read.csv("r-course-master/data/tema6/AAPL.csv", stringsAsFactors = F)

FB <- read.csv("r-course-master/data/tema6/FB.csv", stringsAsFactors = F)

GOOG <- read.csv("r-course-master/data/tema6/GOOG.csv", stringsAsFactors = F)

##Quitamos la fecha del 2007

AMZN <- AMZN[AMZN$Date>='2008-01-01',]

AAPL <- AAPL[AAPL$Date>='2008-01-01',]

GOOG <- GOOG[GOOG$Date>='2008-01-01',]

str(AAPL)


##OJO, CUANDO TENEMOS UNA SERIE TEMPORAL, CAMBIAMOS LA COLUMNA DE FECHA A DATE

AAPL$Date <- as.Date(AAPL$Date)

AMZN$Date <- as.Date(AMZN$Date)

GOOG$Date <- as.Date(GOOG$Date)

FB$Date <- as.Date(FB$Date)


library(ggplot2)

##Aes() sirve para hacer un mapping de qué variables se van a representar en el plot

ggplot(AAPL, aes(Date, Close)) + geom_line(aes(color = "Apple")) +
    geom_line(data = AMZN, aes(color = "Amazon")) +
    geom_line(data = FB, aes(color = "Facebook")) +
    geom_line(data = GOOG, aes(color  = "Google")) +
    labs(color = "Legend") + 
    scale_color_manual("", breaks = c("Apple", "Amazon", "Facebook", "Google"),
                       values = c("gray", "yellow", "blue", "red")) +
    ggtitle("Coomparaciones de cierre de stocks") + 
    theme(plot.title = element_text(lineheight = 0.7))


##PODEMOS EXTRAER DATOS EN TIEMPO REAL A TRAVÉS DE LA API

install.packages("quantmod")

library(quantmod)          

##Cargar datos en tiempo real

##Debemos poner un el nombre con el cual cotiza en bolsa
getSymbols("AAPL")

barChart(AAPL)

chartSeries(AAPL, TA = "NULL")

head(AAPL)


chartSeries(AAPL[,4], TA = "addMACD()")


getSymbols("BTC-USD")

barChart(`BTC-USD`)
