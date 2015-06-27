library(reshape2)
library(ggplot2)
library(plyr)
library(dplyr)

#The files are assumed to b present in the current working directory in R.
#Reading in the files.
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

#Obtain a subset of the dataframe for Baltimore City(fips=24510)
df_Balt<-subset(NEI,fips=="24510")
df_test<-aggregate(df_Balt$Emissions,by=list(df_Balt$type,df_Balt$year),FUN=sum)
names(df_test)<-c("Type","Year","PM25")
df_test$Type<-factor(df_test$Type)
#df_test<-group_by(df_test,Type)

#Getting the data in a good format. Somehow, I couldnt find a
#way to use the group_by function for this task.
df_point<-subset(df_test,df_test$Type=="POINT")
df_onroad<-subset(df_test,df_test$Type=="ON-ROAD")
df_nonpoint<-subset(df_test,df_test$Type=="NONPOINT")
df_nonroad<-subset(df_test,df_test$Type=="NON-ROAD")
data<-rbind(df_point,df_onroad)
data<-rbind(data,df_nonpoint)
data<-rbind(data,df_nonroad)

#Got the data in the required format. Now we plot!!

#Any suggestions as to how to increase the spacing between adjacent plots? 
#Equivalent of a par(mar=c(1,1,1,1)) function in ggplot2??
png(file="plot3.png")
qplot(Year,PM25,data=data,facets=Type~.)
dev.off()

#Conclusions fro the plot
#1.The emission due to non-road type sources is decreasing every 3 years though not significantly.
#2.The non-point type sources have a high contribution to the emission. Almost 4 times as much as the non-road.
#But their emission too decreases every year.
#3.On-road type source emission is small and decreases.
#4.Emission from point type sources had increased significantly in the period 1999-2005 but there has been notable decrease
#in the emmission in the period 2005-2008.