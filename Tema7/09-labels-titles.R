'Etiquetas y leyendas'
library(ggplot2)

#ggtitle("título")

##Cargamso data set
tooth <- read.csv("r-course-master/data/tema7/ToothGrowth.csv")
head(tooth)

ggplot(data = tooth, aes(dose, len)) + geom_boxplot() + 
    ggtitle("Crecimiento dental en función de una dósis de vitamina C mg/día") +
    xlab("Dósis en miligramos/día de vitamina C") + ylab("Crecimiento dental en milímetros") +
    aes(fill = as.factor(dose)) + ##Ponemos los boxplots separados or dósis 
    labs(fill = "Dósis en miligramos/día") + ##Le ponemos la etiqueta al fill
    theme(legend.position = "bottom") + ##Cambiamos la posición de la leyenda del fill
    guides(fill = F) ##También podemos quitar simplemente la leyenda para que no estorbe, ya que está muy organizado

'Temas'
ggplot(data = tooth, aes(dose,len)) + geom_boxplot() +  aes(fill=as.factor(dose)) +
    theme_bw() + 
    #theme(plot.background = element_rect(fill = "red")) para cambiar el fondo
    theme(axis.text.x = element_text(face = "bold",
                                     size = 14, angle=45, color = "#993091"), ##Modificamos los textos del eje X
          axis.text.y = element_text(face = "italic", size = 16, angle = 30, color = "#449955"))+ ##Modificas textos eje Y
    theme(panel.border = element_blank()) + ##Borramos el panel 
    theme(panel.grid.major = element_blank()) + ##Eliminas las líneas princiapales
    theme(panel.grid.minor = element_blank()) ##Eliminas las líneas secundarias 




