#gglot2 is packge for graphs 
library (raster)
library(RStoolbox)
library(ggplot2)
#set working directory
setwd("/Users/buithuuyen/Desktop/lab")

#brick
# import all the data together with the lapply function
rlist<-list.files(pattern="defor") #b1 để list hết các file ra với pattern là tên defor rlist
list_rast<-lapply(rlist, brick) #raster các file trong list này, từng file 1 => 2 dif raster brick
list_rast
#cái này k stack đc (k hiểu vì sao)
#plot thì phải plot singularly
plot(list_rast[[1]])
#defor: NIR 1, red 2, green 3 
#plotRGB thì chỉ để xem thôi chứ k để phân tích đc gì
l1992<-plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="lin")
l2006 <- plotRGB(list_rast[[2]], r=1, g=2, b=3,stretch="lin")

"từ bước này có thể áp dụng đc để làm cho 2006"
#gán lại l1992 về 1 image
l1992 <- list_rast[[1]]
#classification land cover in remote sensing (unsuperClass chỉ work with image but not with plot RGB)
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c
plot(l1992c$map)
#result value 2 is agriculture and water
#result value 1 is forest

#giờ đếm các pixel của từng value bằng frequencies freq function
freq(l1992c$map)
 #kết quả (có thể slightly change a bit from one to the other)
		value  count
[1,]     1 308820
[2,]     2  32472

#giờ calculate the propotion 
#total <- ở trong ncells of dimensions của l1992c



#build a data.frame 
result2006<-freq(l2006c$map)
rownames(result2006)<- c("Forest","Agri")
>result2006
       value  count
Forest     1 178873
Agri       2 163853
#1992c trc
 total_1992<- 341292
 forest_1992 <- 308820/total_1992
 agri_1992 <- 32472/total_1992
 #2006c
 total_2006<- 342726
 forest_2006 <- 178873/total_2006
 agri_2006 <- 163853/total_2006
 final_1992 <- c(forest_1992, agri_1992)
final_2006 <- c(forest_2006, agri_2006)
 data.frame(final_1992, final_2006)
dafr<-data.frame(final_1992, final_2006)
 colnames(dafr)<- c("1992", "2006")
rownames(dafr) <- c("Forest","Agriculture")
dafr
                  1992      2006
Forest      0.90485567 0.5219125
Agriculture 0.09514433 0.4780875
dafr_percent<- dafr*100
dafr_percent

prop1992<-dafr_percent[,1]
cover <- c("Forest", "Agriculture")
prop2006<-dafr_percent[,2]

data_frame1992<- data.frame(prop1992, cover)
data_frame2006<- data.frame(prop2006,cover)
#giờ plot với ggplot2
library(ggplot2)
ggplot1992<-ggplot(data_frame1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot2006<-ggplot(data_frame2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

#nhập 2 cái ggplot vs nhau, dùng package "gridExtra"
library(gridExtra)
grid.arrange(ggplot1992, ggplot2006, nrow=1, ylim(0,1))
#HOẶC
#plot 2 graphs with patchwok 
ggplot1992+ggplot2006
#forr on on top of the other
ggplot1992/ggplot2006

	#nếu muốn dùng patchwwork cho map thì phải plot bằng ggRGB
ggRGB(l1992, r=1, g=2, b=3,stretch="lin")
