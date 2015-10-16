require("jsonlite")
require("RCurl")
require("ggplot2")
require("dplyr")

dfNAF <- dplyr::anti_join(NAF, NASF, by="chi2")
dfNAF

dfNAF <- dfNAF %>% select(chi2, ID)

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Stars') +
  labs(x="Chi squared", y=paste("ID (relative to vega)")) +
  theme(axis.text.x = element_text(angle = 90)) +
  theme(legend.position="none") +
  layer(data=dfNAF, 
        mapping=aes(as.character(chi2), y=as.numeric(as.numeric(ID)), color=chi2), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list()
        #position=position_identity()
  )