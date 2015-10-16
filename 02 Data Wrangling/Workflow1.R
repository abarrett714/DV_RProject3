require("jsonlite")
require("RCurl")
require("ggplot2")
require("dplyr")

dfhab <- dplyr::full_join(HAB, hygdf, by="hip")

dfhab <- dfhab %>% select(hip, dist, con, mag) %>% mutate(dist_percent = cume_dist(dist)) %>% filter(dist != 0, dist_percent < .01, hip != 0, con != "")

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Stars') +
  labs(x="Constellation", y=paste("Magnitude (relative to vega)")) +
  theme(axis.text.x = element_text(angle = 90)) +
  theme(legend.position="none") +
  layer(data=dfhab, 
        mapping=aes(as.character(con), y=as.numeric(as.numeric(mag)), color=con), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list()
        #position=position_identity()
        #position=position_jitter(width=0.1, height=0)
  )