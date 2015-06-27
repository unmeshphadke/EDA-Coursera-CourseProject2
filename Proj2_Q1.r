library(reshape2)
library(ggplot2)
library(plyr)
library(dplyr)

#The files are assumed to b present in the current working directory in R.
#Reading in the files.
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
m<-tapply(NEI$Emissions,NEI$year,sum)
df<-data.frame(m,as.numeric(names(m)))
names(df)<-c("PM25","Year")
png(file="plot.png")
plot(df$Year,df$PM25,xlab="Year",ylab="PM25 emitted (in tonnes)",col="blue",pch=20,cex=3,main="Total PM25 Emissions in the US")
dev.off()

#From the plot , it is clearly seen that the PM25 Emission  has decreased significantly from 1999 to 2008
