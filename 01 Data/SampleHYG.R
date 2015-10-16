require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "hygdata_v3.reformatted10k.csv"


#hygdf <- sample_n(hygdf, 10000, replace = TRUE)

#write.csv(hygdf, paste(gsub(".csv", "", file_path), ".reformatted10k.csv", sep=""), row.names=FALSE, na = "")

hygdf <- read.csv(file_path, stringsAsFactors = FALSE)
measures <- c("id", "hip", "hd", "hr", "ra", "dec", "dist", "pmra", "pmdec", "rv", "mag", "absmag", "ci", "x", "y", "z", "vx", "vy", "vz", "rarad", "decrad", "pmrarad", "pmdecrad", "flam", "comp", "comp_primary", "lum", "var_min", "var_max")
dimensions <- setdiff(names(hygdf), measures)
library(lubridate)

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(measures) > 1 || ! is.na(measures)) {
  for(m in measures) {
    if(m != tail(measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)
