#set working directory
setwd("/Users/buithuuyen/Desktop/lab/EN")
library(raster)

# dùng raster function Create a RasterLayer object
EN01 <- raster("EN0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png") #march- xem ở trong ảnh

#color
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN01,col=cl) 

# plot all the data together
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

#hoặc nhẹ nhàng hơn
EN <- stack (EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)
plot(EN, col=cl)
#nếu plot 1 map của stack này thì phải lấyoriginal name chứ kp tên gán
plot (EN$EN_0001, col=cl)

#plot RGB
plotRGB(EN, r=1, g=7, b=13, stretch ="Lin")
#red= high value of NO2 in Jan nhưng những khoảng tgian khác thì k có 
#green=                    Feb
#các màu hybrid = hybrid của màu nào thì là tổ hợp giá trị NO2 cao của thời gian tương ứng theo tổ hợp màu này        



# import all the data together with the lapply function
rlist<-list.files(pattern="EN") #b1 để list hết các file ra với pattern là tên EN
rlist
list_raster<-lapply(rlist, raster) #raster các file trong list này, từng dfile 1
list_raster
ENstack <- stack(list_raster) #nhóm các file đã đc rastered vào vs nahau 
plot(EN_stack)

#plot only the first image of the stack
plot(EN_stack$EN_0001, col=cl)

#different
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100) # 
plot(ENdif, col=cldif)
#result, more change, more red



#automated processing Source function
source("name of the file")
