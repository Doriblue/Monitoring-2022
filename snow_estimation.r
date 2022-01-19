#R code for uploading and visualizing Copernicus data in R
library(ncdf4)
library(raster)
library(viridis)
library(RStoolbox)
library(ggplot2)
setwd("/Users/buithuuyen/Desktop/lab/copernicus")

snow20211214 <- raster("c_gls_SCE500_202112140000_CEURO_MODIS_V1.0.1.nc")
#xem tông tin của file
snow20211214
plot(snow20211214)
cl <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(snow20211214, col=cl)

ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))+scale_fill_viridis() +
ggtitle("SNOW!!!!")

#PLOT ONE DATE'S DATA ON TOP OF THE OTHER-T˚
rlist<-list.files(pattern="c_gls_SCE500") #b1 để list hết các file ra với pattern là tên c_gls_SCE500
rlist
list_raster<-lapply(rlist, raster) #raster các file trong list này, từng dfile 1
list_raster

snowstack<- stack(list_raster)
snowstack
summersnow<-snowstack$Snow.Cover.Extent.1
wintersnow<-snowstack$Snow.Cover.Extent.2
#stack and unstack again để lấy cái đầu vs cái cuối thui. analyzing processes thì thường hay lấy mỗi cái đầu vs cái cuối 
ggplot() +
geom_raster(summersnow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1))+scale_fill_viridis() +
ggtitle("summer SNOW!!!!")
ggplot() +
geom_raster(wintersnow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2))+scale_fill_viridis() +
ggtitle("winter SNOW!!!!")

#use  patchwork  
library(patchwork)
p1<- ggplot() +
geom_raster(summersnow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1))+scale_fill_viridis() +
ggtitle("summer SNOW!!!!")

p2 <- ggplot() +
geom_raster(wintersnow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2))+scale_fill_viridis() +
ggtitle("winter SNOW!!!!")

p1/p2
#crop image to certain  areaa
#longtitude  from  0 to  20
#lat  from 30-50

ext <- c(0,20,30,50)
ssummer_italy <- crop(summersnow, ext)
swinter_italy  <- crop(wintersnow, ext)
