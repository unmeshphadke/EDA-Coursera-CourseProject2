library(reshape2)
library(ggplot2)
library(plyr)
library(dplyr)

#The files are assumed to b present in the current working directory in R.
#Reading in the files.
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

#Now obtain the data related to motor vehicles.
#Look for "Mobile-On-road" in the EI.SEctor column
e<-subset(SCC, grepl("Mobile - On-Road",EI.Sector,ignore.case=TRUE))

#Filter the NEI data fraeme to ensure only the motor vehicle data
motor_data<-filter(NEI,SCC %in% e$SCC)

#Now take the data only for Baltimore county.
motor_data_Balt<-subset(motor_data, motor_data$fips== "24510")

#Now take data for the individual years
mot_dat<-tapply(motor_data_Balt$Emissions,motor_data_Balt$year,sum)

mot_data_df<-data.frame(mot_dat,as.numeric(names(mot_dat)))
names(mot_data_df)<-c("PM25","year")
#now plotting the data
png(file="plot5.png")
qplot(year,PM25,data=mot_data_df)
dev.off()

#The emissions from motor vehicles in baltimore decrease by large amount from 1999-2002, 
#followed by a very small decrease till 2005 followed by a notable reduction by 2008.
