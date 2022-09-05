
d<-read.csv("amazonia_deforestation.csv", sep = ";")

library(ggplot2)
library(png)
library(patchwork)

png(file = "amazonia_plot.png", width = 1000, height = 700)
my_image <- readPNG("mapa-amazonia.png", native = TRUE)
p <- ggplot(data = d,
            mapping = aes(x = year, y = km))
p <- p + scale_x_continuous(breaks=seq(1988,2021,by=1))
p <- p + theme(axis.text.x =
                 element_text(size  = 10,
                              angle = 45,
                              hjust = 1,
                              vjust = 1))
p <- p + scale_y_continuous(breaks=seq(0,30000,by=5000))
p + geom_area( fill="red", alpha=0.4)+

  geom_line(color = "red", size=2) +
  geom_point(color="red", size=3) +
    
  geom_vline(xintercept = 1990, color = "blue", linetype = "longdash") +
  annotate("text", x = 1988.5, y = 0.14, colour = "blue",
           label = "Sarney", size = 5) +
  geom_vline(xintercept = 1992, color = "blue", linetype = "longdash") +   
  annotate("text", x = 1991, y = 0.44,  colour = "blue",
           label = "Collor", size = 5) +  
  geom_vline(xintercept = 1995, color = "blue", linetype = "longdash") +
  annotate("text", x = 1993.5, y = 0.44,  colour = "blue",
           label = "Itamar", size = 5) +
  geom_vline(xintercept = 2003, color = "blue", linetype = "longdash") +
  annotate("text", x = 1999, y = 0.44, colour = "blue",
           label = "FHC", size = 5) +
  geom_vline(xintercept = 2011, color = "blue", linetype = "longdash") +         
  annotate("text", x = 2007, y = 0.44,  colour = "blue",
           label = "Lula", size = 5) +        
  geom_vline(xintercept = 2016, color = "blue", linetype = "longdash") +    
  annotate("text", x = 2013.5, y = 0.44,  colour = "blue",
           label = "Dilma", size = 5) +  
  geom_vline(xintercept = 2019, color = "blue", linetype = "longdash") +  
  annotate("text", x = 2017.5, y = 0.44,  colour = "blue",
           label = "Temer", size = 5) +    
  annotate("text", x = 2020.9, y = 0.44,  colour = "blue",
           label = "Bolsonaro", size = 5) +
  labs(x = "Data",
       y = "Área (km2)",
       title = "") +
  scale_color_discrete(name = "") +
  scale_colour_grey(name = "") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 25, vjust = 0.5, hjust=1))+
  theme (panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) + 
  theme (panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())+
  labs(title = "Taxa de desmatamento na Amazônia brasileira durante os períodos de mandato dos presidentes da República (de 1988 a 2021)", caption="Fonte: INPE (http://terrabrasilis.dpi.inpe.br)
       Visualização produzida por @fblpalmeira") +
  inset_element(p = my_image,left = 0.7, bottom = 0.6, right =.975, top = .975)

dev.off()

library(magick)
library(magrittr) 

# Call back the plot
plot <- image_read("amazonia_plot.png")

# And bring in a logo
sarney <- image_read("sarney.png") 
out1<-image_composite(plot,image_scale(sarney,"x40"), gravity="south", offset = "-390+110")

collor <- image_read("collor.png") 
out2<-image_composite(out1,image_scale(collor,"x40"), gravity="south", offset = "-325+110")

itamar <- image_read("itamar.png") 
out3<-image_composite(out2,image_scale(itamar,"x40"), gravity="south", offset = "-260+110")

fhc<- image_read("fhc.png") 
out4<-image_composite(out3,image_scale(fhc,"x40"), gravity="south", offset = "-120+110")

lula<- image_read("lula.png") 
out5<-image_composite(out4,image_scale(lula,"x40"), gravity="south", offset = "+90+110")

dilma<- image_read("dilma.png") 
out6<-image_composite(out5,image_scale(dilma,"x40"), gravity="south", offset = "+250+110")

temer<- image_read("temer.png") 
out7<-image_composite(out6,image_scale(temer,"x40"), gravity="south", offset = "+355+110")

bolsonaro<- image_read("bolsonaro.png") 
out8<-image_composite(out7,image_scale(bolsonaro,"x40"), gravity="south", offset = "+440+110")

image_browse(out8)

# And overwrite the plot without a logo
image_write(out8, "amazonia_desmatamento2.png")

