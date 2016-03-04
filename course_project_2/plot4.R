library(ggplot2)

# Read in data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
png(filename = "plot4.png", width = 480, height = 480)

# Get sum of emissions for each year
# get the scc numbers of coal sources then extract nei data with matching scc numbers
scc_num <- scc$SCC[grep("Coal", scc$EI.Sector)]
nei_coal <- nei[nei$SCC %in% scc_num,]
yearly_coal_sum <- aggregate(Emissions ~ year, nei_coal, sum)

ggplot(yearly_coal_sum, aes(x=year,y=Emissions)) + geom_line() + geom_point() + scale_x_continuous(breaks=yearly_coal_sum$year) + ylab("PM2.5 Level") + xlab("Year") + ggtitle("U.S. Coal Source PM2.5 Emissions")


dev.off().