#cái này cũng dùng raster package
library(raster)
#setting working directory
setwd("/Users/buithuuyen/Desktop/lab/")
# gọi file -> gán tên
l1992 <- brick("defor1_.jpeg")
l2006 <- brick("defor2_.jpeg")
# rules nhận diện band của layer: assign infared vào vị trí nào mà kết quả là màu nào thì band là màu đó
#defor1_.1 = Near Infared (NIR)
#defor1_.2 = red
#defor1_.3 = blue

#DVI for vegetatin (different vegetation index)
 
#calculate energy in 1992 
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color schem 
plot(dvi1992, col=cl) 
#black, red = high div value 

#calculate energy in 2006 
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color schem 
plot(dvi2006, col=cl)
#yellow laf energy lost 

#difering 2 images of energy in 2 dif times
dvi <- dvi1992 - dvi2006
#plot the results
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvi, col=cld) 
#red = khac nhau lon hon => the hien nhung cho mat nh energy 

#final plot
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvi, col=cld)

#save pdf 
pdf("energy.pdf") 
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvi, col=cld)
