require("jsonlite")
require("RCurl")
require("ggplot2")
require("dplyr")

MainDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from HYGSTARDATA"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_apb766', PASS='orcl_apb766', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))


SCDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from STARSUBCLASS10k"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_apb766', PASS='orcl_apb766', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

for(n in names(SCDF)) {
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="[\\( - \\)]",replacement= ""))
  SCDF[n] <- data.frame(lapply(SCDF[n], gsub, pattern="Hash",replacement= "#"))
}

df <- select(MainDF, ID, SPECT, CON)

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

SCDF <- rename(SCDF, SPECT = CLASS)

SCDF2 <- select(SCDF, SPECT, HEX)

HABdf <- full_join(df, SCDF2, by = "SPECT")

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Distribution across Color Spectrum within Constellations') +
  labs(x="Constellation", y=paste("Spectrum")) +
  theme(axis.text.x = element_text(angle = 90)) +
  theme(legend.position="none") +
  layer(data=HABdf, 
        mapping=aes(as.character(CON), y=as.numeric(as.numeric(ID)), color=CON), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list()
        #position=position_identity()
        #position=position_jitter(width=0.1, height=0)
  )