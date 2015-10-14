require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "HexColors.csv"

HCDF <- read.csv(file_path)
HCDF
