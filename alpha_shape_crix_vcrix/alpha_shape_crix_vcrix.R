## Clearing Variables and Close Windows
rm(list = ls(all = TRUE))
graphics.off()

## Loading Libraries
libraries = c("mlbench", "alphahull", "igraph", "spatstat")

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

png("crix_vcrix_alphashape.png", width=900, height=600, bg = "transparent")

par(mfrow=c(2,3))

hull    = chull(x)
shape   = ashape(x, alpha=10)
hull    = c(hull, hull[1])

plot(x,  axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
plot(shape, add=T, wpoints=F, col = 'red')

shape   = ashape(x, alpha=100)

plot(x, axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
plot(shape, add=T, wpoints=F, col = 'red')

shape   = ashape(x, alpha=1000)

plot(x, axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
plot(shape, add=T, wpoints=F, col = 'red')

shape   = ashape(x, alpha=10000)

plot(x, axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
plot(shape, add=T, wpoints=F, col = 'red')

shape   = ashape(x, alpha=50000)

plot(x, axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
plot(shape, add=T, wpoints=F, col = 'red')


plot(x,  axes=T, pch=19, cex=0.5,xlab="CRIX", ylab="VCRIX")
lines(x[hull, ], col='red',lwd=2)

dev.off()








