## Clearing Variables and Close Windows
rm(list = ls(all = TRUE))
graphics.off()

## Loading Libraries
libraries = c("mlbench", "alphahull", "igraph", "tripack", "spatstat")

lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})

lapply(libraries, library, quietly = TRUE, character.only = TRUE)

set.seed(1234)

x            = runif(150)
y            = runif(150)
x            = cbind(x,y)
x            = unique(x)

png("mst_alphas.png", width=900, height=600, bg = "transparent")

par(mfrow=c(1,3))

#minimum spanning tree
graph        = graph.adjacency(as.matrix(dist(x)), weighted=TRUE)
mst          = as.undirected(minimum.spanning.tree(graph))
idx          = get.edges(mst, E(mst))
plot(x, axes=F, pch=19, cex=1)
for (i in seq(nrow(idx))) {
  ft         = idx[i,]
  lines(x[ft,1], x[ft,2], col ='red',lwd=2)
}

hull         = chull(x)
shape        = ashape(x, alpha=0.123)
hull         = c(hull, hull[1])

plot(x, axes=F, pch=19, cex=0.5, labels=FALSE)
plot(shape, add=T, wpoints=F, col = 'red')


plot(x, axes=F, pch=19, cex=0.5, labels=FALSE)
lines(x[hull, ], col='red',lwd=2)

dev.off()



