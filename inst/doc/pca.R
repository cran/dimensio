## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7, 
  fig.height = 7,
  out.width = NULL
)

## ----setup--------------------------------------------------------------------
library(dimensio)

## ----pca----------------------------------------------------------------------
## Load data
data(iris)
head(iris)

## Compute PCA
## (non numeric variables are automatically removed)
X <- pca(iris, center = TRUE, scale = TRUE)

## ----eigenvalues, fig.show='hold', out.width='50%'----------------------------
## Get eigenvalues
get_eigenvalues(X)

## Scree plot
screeplot(X, cumulative = TRUE)

## Plot variable contributions to the definition of the first two axes
viz_contributions(X, margin = 2, axes = c(1, 2))

## ----biplot-rows--------------------------------------------------------------
biplot(X, type = "form", label = "variables")

## ----biplot-columns-----------------------------------------------------------
biplot(X, type = "covariance", label = "variables")

## ----plot-var-----------------------------------------------------------------
## Plot variables factor map
viz_variables(X)

## ----plot-var-cos2------------------------------------------------------------
## Highlight cos2
viz_variables(
  x = X, 
  highlight = "cos2", 
  col = khroma::color("YlOrBr")(4, range = c(0.5, 1))
)

## ----plot-ind-species---------------------------------------------------------
## Plot individuals and color by species
viz_individuals(
  x = X,
  highlight = iris$Species,
  col = khroma::color("bright")(3), # Custom color scale
  pch = c(15, 16, 17) # Custom symbols
)

## ----plot-wrap, fig.show='hold', out.width='50%'------------------------------
## Add ellipses
viz_individuals(x = X)
viz_tolerance(x = X, group = iris$Species, level = 0.95,
              border = khroma::color("high contrast")(3))

## Add convex hull
viz_individuals(x = X)
viz_hull(x = X, group = iris$Species, level = 0.95,
         border = khroma::color("high contrast")(3))

## ----plot-ind-petal-----------------------------------------------------------
## Highlight petal length
viz_individuals(
  x = X, 
  highlight = iris$Petal.Length,
  col = khroma::color("YlOrBr")(12), # Custom color scale
  cex = c(1, 2), # Custom size scale
  pch = 16
)

## ----plot-ind-contrib---------------------------------------------------------
## Highlight contributions
viz_individuals(
  x = X, 
  highlight = "contrib",
  col = khroma::color("iridescent")(12), # Custom color scale
  cex = c(1, 2), # Custom size scale
  pch = 16
)

## ----tidy---------------------------------------------------------------------
iris_tidy <- tidy(X, margin = 2)
head(iris_tidy)

iris_augment <- augment(X, margin = 1)
head(iris_augment)

## ----ggplot2, eval=FALSE------------------------------------------------------
#  ## Custom plot with ggplot2
#  ggplot2::ggplot(data = iris_augment) +
#    ggplot2::aes(x = F1, y = F2, colour = contribution) +
#    ggplot2::geom_vline(xintercept = 0, linewidth = 0.5, linetype = "dashed") +
#    ggplot2::geom_hline(yintercept = 0, linewidth = 0.5, linetype = "dashed") +
#    ggplot2::geom_point() +
#    ggplot2::coord_fixed() + # /!\
#    ggplot2::theme_bw() +
#    khroma::scale_color_iridescent()

