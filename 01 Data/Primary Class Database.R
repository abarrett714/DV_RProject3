require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "PrimaryClass.csv"

PCDF <- read.csv(file_path, stringsAsFactors = FALSE)
PCDF
