require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "APJ-HABCAT2.csv"

HAB <- read.csv(file_path)
HAB
