## Clearing Variables and Close Windows
rm(list = ls(all = TRUE))
graphics.off()

## Loading Libraries
libraries = c("mlbench", "alphahull", "igraph", "tripack", "spatstat")

lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})

lapply(libraries, library, quietly = TRUE, character.only = TRUE)

crix    = read.csv("crix.csv")
vcrix   = read.csv("vcrix.csv")

vcrix   = vcrix[vcrix$date>'2016-05-01',]

crix    = crix[crix$date>'2016-05-01',]

x       = cbind(crix$price,vcrix$vcrix)
x       = unique(x)

png("dt_mst_bp_crix_vcrix.png", width=900, height=600, bg = "transparent")

par(mfrow=c(1,3))

## Delaunay triangulation

my.triangles = tri.mesh(x[,1], x[,2])
plot(my.triangles, do.points=FALSE, lwd=0.2, col='red')
points(x[,1], x[,2], col = "black", pch=20, cex = 1.5)

## Minimum spanning tree

graph   = graph.adjacency(as.matrix(dist(x)), weighted=TRUE)
mst     = as.undirected(minimum.spanning.tree(graph))
idx     = get.edges(mst, E(mst))
plot(x, axes=T, pch=19, cex=0.5,xlab="Crix", ylab="VCRIX ")
for (i in seq(nrow(idx))) {
  ft    = idx[i,]
  lines(x[ft,1], x[ft,2], col ='red',lwd=2)
}

## MST edge lenght boxplot

boxplot(idx[,1],border = 'red', ylim= c(0,max(idx[,1]))) 

dev.off()
