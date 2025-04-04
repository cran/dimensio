% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/viz_ellipse.R
\docType{methods}
\name{viz_ellipses}
\alias{viz_ellipses}
\alias{viz_ellipses-method}
\alias{viz_ellipses,MultivariateAnalysis-method}
\alias{viz_ellipses,PCOA-method}
\title{Ellipses}
\usage{
viz_ellipses(x, ...)

\S4method{viz_ellipses}{MultivariateAnalysis}(
  x,
  ...,
  group = NULL,
  type = c("tolerance", "confidence"),
  level = 0.95,
  margin = 1,
  axes = c(1, 2),
  color = NULL,
  fill = FALSE,
  symbol = FALSE
)

\S4method{viz_ellipses}{PCOA}(
  x,
  ...,
  group = NULL,
  type = c("tolerance", "confidence"),
  level = 0.95,
  axes = c(1, 2),
  color = NULL,
  fill = FALSE,
  symbol = FALSE
)
}
\arguments{
\item{x}{An object from which to wrap observations (a \code{\linkS4class{CA}},
\code{\linkS4class{MCA}} or \code{\linkS4class{PCA}} object).}

\item{...}{Further \link[graphics:par]{graphical parameters} to be passed to
\code{\link[graphics:polygon]{graphics::polygon()}}.}

\item{group}{A vector specifying the group an observation belongs to.}

\item{type}{A \code{\link{character}} string specifying the ellipse to draw.
It must be one of "\code{tolerance}" or "\code{confidence}").
Any unambiguous substring can be given.}

\item{level}{A \code{\link{numeric}} vector specifying the confidence/tolerance level.}

\item{margin}{A length-one \code{\link{numeric}} vector giving the subscript which the
data will be returned: \code{1} indicates individuals/rows (the default), \code{2}
indicates variables/columns.}

\item{axes}{A length-two \code{\link{numeric}} vector giving the dimensions
for which to compute results.}

\item{color}{The colors for borders (will be mapped to \code{group}).
Ignored if set to \code{FALSE}. If \code{NULL}, the default color scheme will be used.}

\item{fill}{The background colors (will be mapped to \code{group}).
Ignored if set to \code{FALSE}.}

\item{symbol}{A vector of symbols (will be mapped to \code{group}).
Ignored if set to \code{FALSE}.}
}
\value{
\code{viz_ellipses()}is called for its side-effects: it results in a graphic
being displayed. Invisibly returns \code{x}.
}
\description{
Plots ellipses.
}
\examples{
## Load data
data("iris")

## Compute principal components analysis
X <- pca(iris, scale = TRUE, sup_quali = "Species")

## Plot with tolerance ellipses
col <- c("#004488", "#DDAA33", "#BB5566")
viz_rows(X, extra_quali = iris$Species, color = col)
viz_ellipses(
  x = X,
  type = "tolerance",
  level = c(0.68, 0.95),
  group = iris$Species,
  color = col
)
}
\seealso{
Other envelopes: 
\code{\link{viz_confidence}()},
\code{\link{viz_hull}()},
\code{\link{viz_tolerance}()}
}
\author{
N. Frerebeau
}
\concept{envelopes}
