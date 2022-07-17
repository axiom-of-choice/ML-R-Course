install.packages("XML")
library(XML)
url <- "cd_catalog.xml"
##crear apuntador, posición de memoir 
##que localiza el documento
xmldoc <- xmlParse(url)
##Localizarte en el orgien del fichero
rootnode <- xmlRoot(xmldoc)
rootnode[1]
##Hay que extraer los datos de un XML
cds_data <- xmlSApply(rootnode, function(x) xmlSApply(x, xmlValue))
##Transponer la data y hacerla data frame
cds.catalago <- data.frame(t(cds_data), row.names = NULL )


##UTILES
##XpathSAPPLY
##getNodeSet


##define tus url
population_url <- "WorldPopulation-wiki.htm"
##sacar las tablas
tables <- readHTMLTable(population_url)
##Ojo que tables es una lista de listas
##Sacamos una de las tablas de la lista
most_populated <- tables[[6]]
##Podemos sacar una que queremos en particular

custom_table <- readHTMLTable(population_url, which = 6)



