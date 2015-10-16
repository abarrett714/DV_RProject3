require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)

require("jsonlite")
require("RCurl")
MainDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from HYGSTARDATA"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_apb766', PASS='orcl_apb766', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

#setwd("~/DataVisualization/DV_RProject3/01 Data")

#file_path <- "hygdata_v3.reformatted10k.csv"

#MainDF <- read.csv(file_path, stringsAsFactors = FALSE)
SCDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from STARSUBCLASS10k"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_apb766', PASS='orcl_apb766', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

for(n in names(SCDF)) {
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="[\\( - \\)]",replacement= ""))
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="Hash",replacement= "#"))
}
#head(SCDF)

#head(MainDF)

df <- select(MainDF, id, spect, con)

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
#for(n in names(df)) {
#  df[n] <- data.frame(lapply(df[n], gsub, pattern="([A-Z]{1}[0-9]{1}I?!)",replacement= ""))
#}

head(df)




head(SCDF)
SCDF <- rename(SCDF, spect = Class)
head(SCDF)
SCDF2 <- select(SCDF, spect, Hex)
head(SCDF2)

#the Join!
jdf <- left_join(df, SCDF2, by = "spect")
head(jdf)


jdf <- filter(jdf, spect != "", !is.na(Hex) )
jdf <- arrange(jdf, spect)
jdf <- distinct(jdf)

head(jdf)

hexdf <- jdf['Hex']

head(hexdf)
hexdf <-distinct(hexdf)
hexdf <- hexdf[,"Hex"]
head(hexdf)
hexdf


require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  scale_color_manual(values=c(as.character(hexdf)))+
  labs(title='Color Spectrum by Constellation') +
  labs(x="Color", y=paste("Constellation")) +
  theme(axis.title.x = element_text(vjust=-0.35))+
  theme(axis.text.x=element_text(size=0))+
  theme(panel.background = element_rect(fill = 'black'),
        panel.grid.major = element_line(colour = "black"),
        panel.grid.minor = element_line(colour = "black"))+
  theme(legend.position = "none")+
  layer(data=jdf, 
        mapping=aes(as.character(Hex), y=as.character(con), color=Hex), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.5, height=0)
  )





