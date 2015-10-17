require("jsonlite")
require("RCurl")
require("ggplot2")
require("dplyr")

NASF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from SF2data"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_mew2795', PASS='orcl_mew2795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
NAF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from SF2data"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_mew2795', PASS='orcl_mew2795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

dfNAF <- dplyr::anti_join(NAF, NASF, by="chi2")
dfNAF

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Stars') +
  labs(x="Chi squared", y=paste("ID of the system")) +
  theme(axis.text.x = element_text(angle = 90)) +
  theme(legend.position="none") +
  layer(data=dfNAF, 
        mapping=aes(as.character(CHI2), y=as.numeric(as.numeric(ID)), color=CHI2), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list()
        #position=position_identity()
  )