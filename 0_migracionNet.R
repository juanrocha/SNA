## 


rm(list=ls())

library (tidyr)
library (dplyr)
library (ggplot2)
library (igraph)
library (sna)
library (sp)

# library ()

#data

dat <- read.csv(file='~/Box Sync/PROYECTO MIGRACIÓN/data/edges.csv', encoding = 'latin1')
str(dat)
summary(dat)
dat <- mutate(dat, w.norm = Weight / max(Weight))

e <- select(dat, Source, Target, Weight)
v <- dat %>% 
    select(Source, Label) %>%
    unique()
    
# network with igraph
net <- graph_from_data_frame(d = dat, directed = TRUE)

# community detection
c <- cluster_louvain(net, weights = E(net)$Weight) # Error  multi-level community detection works for undirected graphs only, Unimplemented function call
c <- cluster_infomap(net, e.weights = E(net)$Weight ) # It identifies 12 clusters

range(dat$w.norm)

# plot
quartz(width=7, height = 7, pointsize = 6)
plot(net, edge.arrow.size = 0.2, vertex.size = 4, 
     edge.width = E(net)$w.norm * 4, 
     vertex.label = NULL, vertex.color = 'orange',
     mark.groups = communities (c)
     )

membership (c)

# map it
col <- readRDS(file = '~/Box Sync/PROYECTO MIGRACIÓN/data/COL_adm2.rds')
d <- col@data

sort(col@data$NAME_2 [v$Label %in% col@data$NAME_2 == FALSE])
sort(v$Label [col@data$NAME_2 %in% v$Label == F] )





plot(col)
