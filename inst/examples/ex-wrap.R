## Load data
data("iris")

## Compute principal components analysis
X <- pca(iris, scale = TRUE)

## Convex hull coordinates
hulls <- wrap_hull(X, margin = 1, group = iris$Species)

## Confidence ellipse coordinates
conf <- wrap_confidence(X, margin = 1, group = iris$Species,
                        level = c(0.68, 0.95))

## Tolerance ellipse coordinates
conf <- wrap_confidence(X, margin = 1, group = iris$Species, level = 0.95)

## Plot with convex hulls
col <- c("#004488", "#DDAA33", "#BB5566")
viz_rows(X, highlight = iris$Species, col = col)
viz_hull(X, group = iris$Species, border = col)
