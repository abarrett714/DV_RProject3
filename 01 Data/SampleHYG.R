require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "hygdata_v3.reformatted.csv"

hygdf <- read.csv(file_path, stringsAsFactors = FALSE)
hygdf <- sample_n(hygdf, 10000, replace = TRUE)

write.csv(hygdf, paste(gsub(".csv", "", file_path), ".reformatted10k.csv", sep=""), row.names=FALSE, na = "")
