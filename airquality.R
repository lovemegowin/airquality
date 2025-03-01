# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 
```r

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(openair)
library(latticeExtra)
# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory
# Any results you write to the current directory are saved as output.
airqual <- read.csv("C:/Users/lovemegowin/Documents/kaggle data/air-quality-in-northern-taiwan/2015_Air_quality_in_northern_Taiwan.csv", stringsAsFactors = FALSE)

str(airqual)

# Formatting time
airqual$time <- as.POSIXct(airqual$time, tz = "Asia/Taipei")
# Station as Factor
airqual$station <- factor(airqual$station)
# Handling NAs and invalid values, varibales 3 to 23 should be numeric
for(i in 3:23) {
  airqual[,i] <- as.numeric(airqual[,i])
}
# Rename columns for use with "openair" package
colnames(airqual)[1] <- "date"
colnames(airqual)[21] <- "wd"
colnames(airqual)[22] <- "ws"

# Windrose
windRose(airqual, type= "PM10", layout = c(4,1))
# pollution rose SO2,NOx
pollutionRose(airqual, pollutant = "NOx", type = "SO2", layout = c(4, 1))
# pollution Rose NOx day & Night
pollutionRose(airqual,pollutant = "NOx", type = "daylight")
# percentile Rose : season, daylight for NOx
percentileRose(airqual, type = c("season", "daylight"), pollutant = "NOx",col = "Set3", mean.col = "black")
# polar Annulus
polarAnnulus(airqual, pollutant = "NOx", type = "month", local.tz = "Asia/Taipeh", resolution = "fine")
# Correlation
corPlot(airqual, cluster = TRUE,dendrogram = TRUE)
# timePlot
timePlot(selectByDate(airqual, month = "jan"), pollutant = c("NOx", "O3", "PM2.5", "PM10"))
```
