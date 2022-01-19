install.packages("vegan")
#học xem tính diversity, dùng đc vegan cho gbif k 
#nay học DCA detrended corespondence analysis
library(vegan)
setwd("/Users/buithuuyen/Desktop/lab")
load("biomes_multivar.rdata")

#list objects
ls()
#để xem tên các loài
head(biomes)
multivar<- decorana(biomes)
multivar #result: DCA1->4 , xem 2 cột nào có  Decorana values cao nhất
plot(multivar)
#result: cái plot 4 ô

#let's see if the species is grouped in the same biomes
ordiellipse(multivar)
#biomes names in the graphs
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3) #results chia đc nh biomes vào từng cái ellipse
ordispider(multivar, type, col=c("black","red","green","blue"), label=T) #results chọn, nối đc các loài trong 1 biomes+đưa tên biomes vào luôn 




#########Spatial distribution of individuals in Population ecology analysis###########
library(sdm)#spatial distribution modelling= distribution of species depends in envi conditions
# work với default sample của package, nên k cần setwd
library(rgdal)#species
library(raster) #predictors
file <- system.file("external/species.shp", package="sdm")

#excactly as raster function for raster files, dùng shapefile cho shp
species<- shapefile(file)
plot(species, pch=19)
points(species[species$Occurrence == 0,],col='red',pch=16)

# predictors: look at the path
path <- system.file("external", package="sdm") 

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# stack
preds <- stack(lst)

# plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# model

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)

# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

# make the raster output layer
p1 <- predict(m1, newdata=preds) 

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)

# Do you want to change names in the plot of the stack?
# Here your are!:
# choose a vector of names for the stack, looking at the previous graph, qhich are:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
# and then replot!:
plot(s1, col=cl)
# you are done, with one line of code (as usual!)
