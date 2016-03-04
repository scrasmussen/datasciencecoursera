library(ggplot2)

# Read in data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


png(filename = "plot6.png", width = 480, height = 480)

# Baltimore and L.A.'s fips numbers
baltimore <- 24510
la <- "06037"
# get Baltimore and LA data
baltimore_nei <- nei[nei$fips==baltimore,]
la_nei <- nei[nei$fips==la,]

# Get sum of emissions for each year
# get the scc numbers of vehicle sources then extract nei data with matching scc numbers
scc_num <- scc$SCC[grep("Vehicle", scc$EI.Sector)]
baltimore_vehicle <- baltimore_nei[baltimore_nei$SCC %in% scc_num,]
la_vehicle <- la_nei[la_nei$SCC %in% scc_num,]

baltimore_vehicle_sum <- aggregate(Emissions ~ year, baltimore_vehicle, sum)
la_vehicle_sum <- aggregate(Emissions ~ year, la_vehicle, sum)

vehicle_sum <- merge(la_vehicle_sum,baltimore_vehicle_sum, by="year")
change <- vehicle_sum[4,2:3] - vehicle_sum[1,2:3]
change <- data.frame(value=c(change[,1],change[,2]), city=c("LA","Balt"))

ggplot(data=change, aes(x=city, y=value)) + geom_bar(stat="identity") + ylab("PM2.5 Levels") + xlab("City") + ggtitle("PM2.5 from Vehicle Change from 1999-2008")
dev.off()