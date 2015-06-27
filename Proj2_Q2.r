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
df_total<-tapply(df_Balt$Emissions,df_Balt$year,sum)
df1<-data.frame(df_total,as.numeric(names(df_total)))
names(df1)<-c("PM25","Year")
png(file="plot2.png")
plot(df1$Year,df1$PM25,xlab="Year",ylab="PM25 emitted(in tonnes)",col="red",pch=20,cex=3,main  ="PM25 Emissions in Baltimore City")
dev.off()

#On observing the plot2.png file we can see that the emission decreased from 1999 to 2002
#But increased significantly in 2005 but then decreased significantly again in 2008.