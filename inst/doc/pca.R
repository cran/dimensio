## ----include = FALSE----------------------------------------------------------
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
X <- pca(iris, center = TRUE, scale = TRUE, sup_quali = "Species")

## ----eigenvalues, fig.show='hold', out.width='50%'----------------------------
## Get eigenvalues
get_eigenvalues(X)

## Scree plot
screeplot(X, cumulative = TRUE)

## Plot variable contributions to the definition of the first two axes
viz_contributions(X, margin = 2, axes = c(1, 2))

## ----biplot-rows--------------------------------------------------------------
biplot(X, type = "form", labels = "variables")

## ----biplot-columns-----------------------------------------------------------
biplot(X, type = "covariance", labels = "variables")

## ----plot-var-----------------------------------------------------------------
## Plot variables factor map
viz_variables(X)

## ----plot-var-contribution----------------------------------------------------
## Highlight contribution
viz_variables(
  x = X, 
  extra_quanti = "contribution", 
  color = c("#FB9A29", "#E1640E", "#AA3C03", "#662506"),
  legend = list(x = "bottomleft")
)

## ----plot-ind-species---------------------------------------------------------
## Plot individuals and color by species
viz_individuals(
  x = X,
  extra_quali = iris$Species,
  color = c("#4477AA", "#EE6677", "#228833"), # Custom color scheme
  symbol = c(15, 16, 17), # Custom symbols
  legend = list(x = "bottomright")
)

## ----plot-ind-highligh--------------------------------------------------------
## Highlight one species
viz_individuals(
  x = X,
  extra_quali = iris$Species,
  color = c(versicolor = "black"), # Named vector
  symbol = c(15, 16, 17), # Custom symbols
  legend = list(x = "bottomright")
)

## ----plot-ind-lab-------------------------------------------------------------
## Label the 10 individuals with highest cos2
viz_individuals(
  x = X,
  labels = list(filter = "cos2", n = 10),
  extra_quali = iris$Species,
  color = c("#4477AA", "#EE6677", "#228833"),
  symbol = c(15, 16, 17),
  legend = list(x = "bottomright")
)

## ----plot-wrap, fig.show='hold', out.width='50%'------------------------------
## Add ellipses
viz_individuals(
  x = X, 
  extra_quali = iris$Species,
  ellipse = list(type = "tolerance", level = 0.95),
  color = c("#004488", "#DDAA33", "#BB5566")
)

## Add convex hull
viz_individuals(
  x = X,
  extra_quali = iris$Species,
  hull = TRUE,
  color = c("#004488", "#DDAA33", "#BB5566")
)

## ----plot-ind-petal-----------------------------------------------------------
## Highlight petal length
viz_individuals(
  x = X, 
  extra_quanti = iris$Petal.Length,
  color = color("YlOrBr")(12), # Custom color scale
  size = c(1, 2), # Custom size scale
  legend = list(x = "bottomleft")
)

## ----plot-ind-cos2------------------------------------------------------------
## Highlight contributions
viz_individuals(
  x = X, 
  extra_quanti = "cos2",
  color = color("iridescent")(12), # Custom color scale
  size = c(1, 2), # Custom size scale
  legend = list(x = "bottomleft")
)

## ----tidy---------------------------------------------------------------------
iris_tidy <- tidy(X, margin = 2)
head(iris_tidy)

iris_augment <- augment(X, margin = 1)
head(iris_augment)

## ----ggplot2, eval=FALSE------------------------------------------------------
# ## Custom plot with ggplot2
# ggplot2::ggplot(data = iris_augment) +
#   ggplot2::aes(x = F1, y = F2, colour = contribution) +
#   ggplot2::geom_vline(xintercept = 0, linewidth = 0.5, linetype = "dashed") +
#   ggplot2::geom_hline(yintercept = 0, linewidth = 0.5, linetype = "dashed") +
#   ggplot2::geom_point() +
#   ggplot2::coord_fixed() + # /!\
#   ggplot2::theme_bw() +
#   khroma::scale_color_iridescent()

