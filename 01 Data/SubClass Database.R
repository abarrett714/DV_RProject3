require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "SubClass.csv"

SCDF <- read.csv(file_path, stringsAsFactors = FALSE)
SCDF

for(n in names(SCDF)) {
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="[\\( - \\)]",replacement= ""))
}
SCDF
