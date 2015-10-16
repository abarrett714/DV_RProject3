require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

#setwd("~/DataVisualization/DV_RProject3/01 Data")

#file_path <- "SubClass.csv"

#SCDF <- read.csv(file_path, stringsAsFactors = FALSE)
#head(SCDF)

require("jsonlite")
require("RCurl")
SCDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from STARSUBCLASS10k"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_apb766', PASS='orcl_apb766', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

for(n in names(SCDF)) {
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="[\\( - \\)]",replacement= ""))
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="Hash",replacement= "#"))
}
head(SCDF)
