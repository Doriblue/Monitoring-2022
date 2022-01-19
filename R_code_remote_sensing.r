# REMOTE SENSING WITH R
#R code for ecosystem monitoring
#install packages 
install.packages("")
#template link for package description https://cran.r-project.org/web/packages/raster/index.html
#in the packages description, có các lệnh riêng
#packages đi kèm library và phải recall packages bằng library trước khi dùng
library(raster)

#import "map" data in R #đuôi .grd
#function "brick" Create a RasterBrick object (có thể mở đc đuôi .grd, .gri)
#gán tên
l_1988 <- brick("p224r63_1988.grd")
l_2011 <- brick("p224r63_2011.grd")
lm_2011 <- brick("p224r63_2011_masked.grd")
lm_1988 <- brick("p224r63_1988_masked.grd")
#show map
plot (l_2011)
# sau đó ra 7 bands (trong đó 3 bands đầu là visible)
	#B1 is reflectant in blue band
	#B2                  green              #thành phần của RGB
  #B3                  red
  #B4                  NIR band
#thay đổi dải màu của map bằng 1 dải màu(~tập hợp màu => phải dùng c(...)) có thể tìm tên dải màu pallete ở đây
colorRampPalette(c("black","grey","light grey")) (100) #100 là range của dải màu mới, có thể thay đổi
# gán bọn này cho tên khác để dễ đưa vào setting plot 
cl<- colorRampPalette(c("black","grey","light grey")) (100)
#function gọi plot và đổi màu theo ý mình
plot(l_2011,col=cl)

#plot  band trong 7 bands
plot(l_2011$B1_sre) 

#par funtion: set ot query graphical parameter. Ghép 2 hay nhiều bands/maps đã chọn cạnh nhau mf = multiframe
par(mfrow=c(1,2)) #c(n.row,n.columne) #sau đó phải nhập lại function gọi plot của các map đó ra
 

#funtion gọi plot và để màu default human's vision (RGB) = natural  color
plotRGB(l_2011,r=3, g=2, b=1, stretch="Lin") #strecht  = giãn  dải  màu  as  much  as  it  can  to  let  us  see  the  color  better 
#funtion gọi plot và để màu đc phản xạ lại theo healthy  của vegetation, cần  dùng  đến  near  infared  trong  các  band (B4) = false  colorr
plotRGB(l_2011,r=4, g=3, b=2, stretch="Lin")
# đặt  infared  band  vào  Redd, Blue  hay  Green  thì  sẽ  trả  kqua  khác  nhauu
	#vd: Infared  band  -> Red (r=4, g=3, b=2) => độ  healthy  của  vegetation 
	#.                  -> green (r=3, g=4, b=2) => humidity  khác  nhau, phần  đậm  nhất  có  thể  thấy  dòng  nước  phân  phối  ở  trong  rừng  
  #                   -> blue  (r=3, g=2 , b=4)  => bare  soil  sẽ  chuyển  vàng  (land  usee??)

#shutdown graphic design
dev.off()
