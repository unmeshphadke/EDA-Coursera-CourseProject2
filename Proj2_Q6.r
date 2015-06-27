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
motor_data_LA<-subset(motor_data,motor_data$fips=="06037")

#Now take data for the individual years
mot_dat_Balt<-tapply(motor_data_Balt$Emissions,motor_data_Balt$year,sum)
mot_dat_LA<-tapply(motor_data_LA$Emissions,motor_data_LA$year,sum)

mot_data_Balt_df<-data.frame(mot_dat_Balt,as.numeric(names(mot_dat_Balt)))
names(mot_data_Balt_df)<-c("PM25","year")
mot_data_LA_df<-data.frame(mot_dat_LA,as.numeric(names(mot_dat_LA)))
names(mot_data_LA_df)<-c("PM25","year")

Balt_LA<-rbind(mot_data_Balt_df,mot_data_LA_df)
#A more elegant process involving the aggregate() function could be possible,
#to obtain a data frame for plotting. But the due to the approach used above
#we have got seperate data frames for baltimore and LA data. This could be 
#convenient in debugging or using diiferent type of plots such as seperate histograms
#to address the given question.

#Now plotting the data. We will plot two line graphs in a single plot.
png(file="plot7.png")
layout(rbind(1,2),heights=c(7,1))
plot(Balt_LA$year,Balt_LA$PM25,type="n",main="Comaprison between motor-pollution in Baltomore and LA",xlab="Year",ylab="PM25 Emission(in tonnes)")
with(Balt_LA[1:4,],lines(year,PM25,col="blue"))
with(Balt_LA[5:8,],lines(year,PM25,col="green"))
#lines(mot_data_Balt_df$year,mot_data_Balt_df$Emissions,col="blue",pch=19,cex=2)
#lines(mot_data_LA_df$year,mot_data_LA_df$Emissions,col="green",pch=19,cex=2)
legend("center",col=c("blue","green"),legend=c("Baltimore","Los Angeles"),pch=1)
dev.off()


#From the graph it is clearly seen that pollution levels due to motors are
#very high in LA compared to Baltimore. 
#In Baltimore , pollution reduces a bit from 1999-2002 and not a significant change from 2002-2008.

#Compared to this, the pollution variation in LA is more significant and more pronounced.
#Pollutant levels increases from 1999-2008 and reduces in 2008.