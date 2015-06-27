library(reshape2)
library(ggplot2)
library(plyr)
library(dplyr)

#The files are assumed to b present in the current working directory in R.
#Reading in the files.
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

#Take only those measurement s related to coal and combustion.
d<-subset(SCC, grepl("Coal",EI.Sector,ignore.case=TRUE))
f<-subset(SCC, grepl("Coal",Short.Name,ignore.case=TRUE))
#Filter the NEI data frame to ensure only coal and combustion related variables.
coal_comb<-filter(NEI, SCC %in% f$SCC)
dat<-tapply(coal_comb$Emissions,coal_comb$year,sum)

df<-data.frame(dat,as.numeric(names(dat)))
names(df)<-c("PM25","year")
#now plotting the data
png(file="plot4.png")
qplot(year,PM25,data=df)
dev.off()

#From the graph emission is reducing from 1999-2002 followed by
#slight increase in the period 2002-2005 followed by a signinficant decrease
#in the period 2005-2008.