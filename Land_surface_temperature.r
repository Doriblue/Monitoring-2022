#dataset lấy ở section LST corpenicus
#seems like có thể dùng đc cho primary forest in europe
#tif thì dùng raster
setwd("/Users/buithuuyen/Desktop/lab/greenland_data")

# install.packages("raster")
#install.packages("rasterVis") #
library(raster)
#library(rasterVis) 
library(patchwork)
# library(rgdal)
library (ggplot2)
library (RStoolbox)
library(viridis)


rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist, raster) 
tgr <- stack (import)
tgr
cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(tgr, col=cl)

#ggplot of first and final images 2000 vs 2015
p1 <- ggplot()+
geom_raster(tgr$lst_2000, mapping = aes (x=x, y=y, fill=lst_2000))+
scale_fill_viridis()

p2 <- ggplot()+
geom_raster(tgr$lst_2015, mapping = aes (x=x, y=y, fill=lst_2015))+
scale_fill_viridis()

#plotting fred distribution of data
par(mfrow=c(2,2))
hist (tgr$lst_2000)
hist (tgr$lst_2005)
hist (tgr$lst_2010)
hist (tgr$lst_2015)
#hist mà bị tách ra như hist 2015 thì có anomaly 
dev.off()

#so sáng tsự thay đổi qua 2 năm
plot(tgr$lst_2010, tgr$lst_2015)
abline(0,1, col="red", xlim=c(12500, 15000), ylim=c(12500, 15000))

par(frow=c(3,2)) #để plot hết figures for 1 cục  hist và plot từng cái 1 thủ công 
pairs(tgr) #cách ngắn gọn 
abline(0,1, col="red")
