require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "hygdata_v3.reformatted10k.csv"

MainDF <- read.csv(file_path, stringsAsFactors = FALSE)

head(MainDF)

df <- select(MainDF, id, spect)

# Eliminate Extra Sepctrum data
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="(/[A-Z][0-9]I*)",replacement= ""))
}
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="(-I*)|(-V)|(-IV)",replacement= ""))
}
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="(/I*)|(/V)|(/IV)",replacement= ""))
}

for(n in df("spect")) {}

head(df)




head(SCDF)
SCDF <- rename(SCDF, spect = Class)
head(SCDF)
SCDF <- select(SCDF, spect, Hex)
head(SCDF)
jdf <- left_join(df, SCDF, by = "spect")
head(jdf)
