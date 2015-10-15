require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "SubClass.csv"

SCDF <- read.csv(file_path, stringsAsFactors = FALSE)
head(SCDF)

for(n in names(SCDF)) {
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="[\\( - \\)]",replacement= ""))
}
head(SCDF)
