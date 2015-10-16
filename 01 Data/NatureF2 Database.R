require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "nature12762-f2.csv - nature12762-f2.csv.csv"

NAF <- read.csv(file_path)
NAF
