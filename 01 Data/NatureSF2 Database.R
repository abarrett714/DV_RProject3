require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "nature12762-sf2.csv - nature12762-sf2.csv.csv"
NASF <- read.csv(file_path)
NASF
