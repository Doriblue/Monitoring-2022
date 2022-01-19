#R code for ecosystem monitoring 
install.packages()

#a function to assign value, gán tên cho vector thì không được để số
Viktoria<- c(2,10,20,40,100) 
Miriam <- c(90,80,70,50,10)

# histogram (là frequency graph của variable))
hist (Viktoria) #bọn này k assign tên như trên được.

#plot relationship
plot (Viktoria, Miriam) 
#đổi các thành phần của graph
	pch=3 #kí tự
	col="blue" # màu kí tự 
	cex=3 #size kí tự
#plot an arguement between x and y
plot (Viktoria, Miriam,pch=15, col="blue", cex=3)

#call out a data frame -> table
data.frame(x,y) #có thể gán tên cho table như trên
# ra bảng đẹp như excel
View (bảng)

#choose file/folder workplace
setwd("/Users/buithuuyen/Desktop/lab/")
# dùng "" cho call các files outside R cho cả import lẫn export để BẢO VỆ R
#export file 
write.table (streams, file="my_monitoring.txt")
#import a table sent by a colleage 
read.table("my_monitoring.txt")
dori <- read.table("my_monitoring.txt")

#first statistic for lazy people-SUMMARY of table/figure/anything
summary(dori)
#link table to variable # kí hiệ $ chỉ quan hệ sở hữu
summary (dori$fishes)
#mean
mean(c(a,b,c,d))
#median
median(c(a,b,c,d))
