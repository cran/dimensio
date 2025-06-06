% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/viz_ellipse.R,
%   R/wrap_ellipses.R
\docType{methods}
\name{viz_tolerance}
\alias{viz_tolerance}
\alias{viz_tolerance-method}
\alias{wrap_tolerance}
\alias{wrap_tolerance-method}
\alias{viz_tolerance,numeric,numeric-method}
\alias{viz_tolerance,MultivariateAnalysis,missing-method}
\alias{viz_tolerance,MultivariateBootstrap,missing-method}
\alias{viz_tolerance,PCOA,missing-method}
\alias{wrap_tolerance,numeric,numeric-method}
\alias{wrap_tolerance,MultivariateAnalysis,missing-method}
\alias{wrap_tolerance,PCOA,missing-method}
\title{Tolerance Ellipses}
\usage{
viz_tolerance(x, y, ...)

wrap_tolerance(x, y, ...)

\S4method{viz_tolerance}{numeric,numeric}(
  x,
  y,
  ...,
  group = NULL,
  level = 0.95,
  color = NULL,
  fill = FALSE,
  symbol = FALSE
)

\S4method{viz_tolerance}{MultivariateAnalysis,missing}(
  x,
  ...,
  group = NULL,
  level = 0.95,
  color = NULL,
  fill = FALSE,
  symbol = FALSE
)

\S4method{viz_tolerance}{MultivariateBootstrap,missing}(
  x,
  ...,
  level = 0.95,
  color = FALSE,
  fill = FALSE,
  symbol = FALSE
)

\S4method{viz_tolerance}{PCOA,missing}(
  x,
  ...,
  group = NULL,
  level = 0.95,
  color = NULL,
  fill = FALSE,
  symbol = FALSE
)

\S4method{wrap_tolerance}{numeric,numeric}(x, y, group = NULL, level = 0.95)

\S4method{wrap_tolerance}{MultivariateAnalysis,missing}(
  x,
  margin = 1,
  axes = c(1, 2),
  group = NULL,
  level = 0.95,
  principal = TRUE
)

\S4method{wrap_tolerance}{PCOA,missing}(x, axes = c(1, 2), group = NULL, level = 0.95)
}
\arguments{
\item{x, y}{A \code{\link{numeric}} vector. If \code{y} is missing, \code{x} must be an object
from which to wrap observations (a \code{\linkS4class{CA}}, \code{\linkS4class{MCA}} or
\code{\linkS4class{PCA}} object).}

\item{...}{Further \link[graphics:par]{graphical parameters} to be passed to
\code{\link[graphics:polygon]{graphics::polygon()}}.}

\item{group}{A vector specifying the group an observation belongs to.}

\item{level}{A \code{\link{numeric}} vector specifying the confidence/tolerance level.}

\item{color}{The colors for borders (will be mapped to \code{group}).
Ignored if set to \code{FALSE}. If \code{NULL}, the default color scheme will be used.}

\item{fill}{The background colors (will be mapped to \code{group}).
Ignored if set to \code{FALSE}.}

\item{symbol}{A vector of symbols (will be mapped to \code{group}).
Ignored if set to \code{FALSE}.}

\item{margin}{A length-one \code{\link{numeric}} vector giving the subscript which the
data will be returned: \code{1} indicates individuals/rows (the default), \code{2}
indicates variables/columns.}

\item{axes}{A length-two \code{\link{numeric}} vector giving the dimensions
for which to compute results.}

\item{principal}{A \code{\link{logical}} scalar: should principal coordinates be
used? If \code{FALSE}, standard coordinates are returned.}
}
\value{
\code{wrap_tolerance()} returns a \code{\link{data.frame}} of envelope \code{x} and \code{y}
coordinates. An extra column named \code{group} is added specifying the group an
observation belongs to.

\code{viz_tolerance()}is called for its side-effects: it results in a graphic
being displayed. Invisibly returns \code{x}.
}
\description{
Plots tolerance ellipses.
}
\examples{
## Load data
data("iris")

## Compute principal components analysis
X <- pca(iris, scale = TRUE, sup_quali = "Species")

## Compute tolerance ellipse coordinates
conf <- wrap_confidence(X, margin = 1, group = "Species", level = 0.95)

## Plot tolerance ellipses
col <- c("#004488", "#DDAA33", "#BB5566")
viz_rows(X, extra_quali = iris$Species, color = col)
viz_tolerance(X, group = iris$Species, color = col, level = 0.95)
}
\seealso{
Other envelopes: 
\code{\link{viz_confidence}()},
\code{\link{viz_ellipses}()},
\code{\link{viz_hull}()}
}
\author{
N. Frerebeau
}
\concept{envelopes}
