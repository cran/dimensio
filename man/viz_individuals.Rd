% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/viz_coordinates.R
\docType{methods}
\name{viz_individuals}
\alias{viz_individuals}
\alias{viz_individuals-method}
\alias{viz_rows}
\alias{viz_rows-method}
\alias{viz_rows,MultivariateAnalysis-method}
\alias{viz_rows,BootstrapCA-method}
\alias{viz_individuals,PCA-method}
\title{Visualize Individuals Factor Map}
\usage{
viz_individuals(x, ...)

viz_rows(x, ...)

\S4method{viz_rows}{MultivariateAnalysis}(
  x,
  ...,
  axes = c(1, 2),
  active = TRUE,
  sup = TRUE,
  labels = FALSE,
  highlight = NULL,
  xlim = NULL,
  ylim = NULL,
  main = NULL,
  sub = NULL,
  panel.first = NULL,
  panel.last = NULL,
  legend = list(x = "topleft")
)

\S4method{viz_rows}{BootstrapCA}(x, ..., axes = c(1, 2))

\S4method{viz_individuals}{PCA}(
  x,
  ...,
  axes = c(1, 2),
  active = TRUE,
  sup = TRUE,
  labels = FALSE,
  highlight = NULL,
  xlim = NULL,
  ylim = NULL,
  main = NULL,
  sub = NULL,
  panel.first = NULL,
  panel.last = NULL,
  legend = list(x = "topleft")
)
}
\arguments{
\item{x}{A \code{\linkS4class{CA}}, \code{\linkS4class{MCA}} or \code{\linkS4class{PCA}} object.}

\item{...}{Further \link[graphics:par]{graphical parameters} (see details).}

\item{axes}{A length-two \code{\link{numeric}} vector giving the dimensions to be
plotted.}

\item{active}{A \code{\link{logical}} scalar: should the active observations be
plotted?}

\item{sup}{A \code{\link{logical}} scalar: should the supplementary observations be
plotted?}

\item{labels}{A \code{\link{logical}} scalar: should labels be drawn?}

\item{highlight}{A vector specifying the information to be highlighted.
If \code{NULL} (the default), no highlighting is applied. If a single \code{character}
string is passed, it must be one of "\code{observation}", "\code{mass}", "\code{sum}",
"\code{contribution}" or "\code{cos2}" (see \code{\link[=augment]{augment()}}). Any unambiguous substring
can be given.}

\item{xlim}{A length-two \code{\link{numeric}} vector giving the x limits of the plot.
The default value, \code{NULL}, indicates that the range of the
\link[=is.finite]{finite} values to be plotted should be used.}

\item{ylim}{A length-two \code{\link{numeric}} vector giving the y limits of the plot.
The default value, \code{NULL}, indicates that the range of the
\link[=is.finite]{finite} values to be plotted should be used.}

\item{main}{A \code{\link{character}} string giving a main title for the plot.}

\item{sub}{A \code{\link{character}} string giving a subtitle for the plot.}

\item{panel.first}{An \code{expression} to be evaluated after the plot axes are
set up but before any plotting takes place. This can be useful for drawing
background grids.}

\item{panel.last}{An \code{expression} to be evaluated after plotting has taken
place but before the axes, title and box are added.}

\item{legend}{A \code{\link{list}} of additional arguments to be passed to
\code{\link[graphics:legend]{graphics::legend()}}; names of the list are used as argument names.
If \code{NULL}, no legend is displayed.}
}
\value{
\verb{viz_*()} is called for its side-effects: it results in a graphic
being displayed. Invisibly returns \code{x}.
}
\description{
Plots row/individual principal coordinates.
}
\details{
Commonly used \link[graphics:par]{graphical parameters} are:
\describe{
\item{\code{pch}}{A vector of plotting characters or symbols. This can either be
a single character or an integer code for one of a set of
graphics symbols.}
\item{\code{cex}}{A numerical vector giving the amount by which plotting
characters and symbols should be scaled relative to the
default.}
\item{\code{col}}{The colors for lines and points. Multiple colors can be
specified so that each point can be given its own color.}
\item{\code{bg}}{The background color for the open plot symbols given by
\code{pch = 21:25}.}
}
}
\note{
Be careful: graphical parameters are silently recycled.
}
\examples{
## Load data
data("iris")

## Compute principal components analysis
X <- pca(iris, scale = TRUE)

## Plot individuals
viz_individuals(X, panel.last = graphics::grid())

## Plot variables
viz_variables(X, panel.last = graphics::grid())

## Graphical parameters
## Continuous values
viz_individuals(X, highlight = iris$Petal.Length, pch = 16)
viz_individuals(X, highlight = iris$Petal.Length, pch = 16,
                col = grDevices::hcl.colors(12, "RdPu"))
viz_individuals(X, highlight = iris$Petal.Length, pch = 16,
                col = grDevices::hcl.colors(12, "RdPu"),
                cex = c(1, 2))

viz_variables(X, highlight = "contribution",
              col = grDevices::hcl.colors(12, "BluGrn", rev = TRUE),
              lwd = c(1, 5))

## Discrete values
viz_individuals(X, highlight = iris$Species, pch = 21:23)
viz_individuals(X, highlight = iris$Species, pch = 21:23,
                bg = c("#004488", "#DDAA33", "#BB5566"),
                col = "black")

viz_variables(X, highlight = c("Petal", "Petal", "Sepal", "Sepal"),
              col = c("#EE7733", "#0077BB"),
              lty = c(1, 3))
}
\seealso{
Other plot methods: 
\code{\link{biplot}()},
\code{\link{screeplot}()},
\code{\link{viz_contributions}()},
\code{\link{viz_variables}()},
\code{\link{viz_wrap}},
\code{\link{wrap}}
}
\author{
N. Frerebeau
}
\concept{plot methods}
