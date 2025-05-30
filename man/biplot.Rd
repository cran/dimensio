% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/biplot.R
\docType{methods}
\name{biplot}
\alias{biplot}
\alias{biplot,CA-method}
\alias{biplot,PCA-method}
\title{Biplot}
\usage{
\S4method{biplot}{CA}(
  x,
  ...,
  axes = c(1, 2),
  type = c("symetric", "rows", "columns", "contributions"),
  active = TRUE,
  sup = TRUE,
  labels = NULL,
  col.rows = c("#E69F00", "#E69F00"),
  col.columns = c("#56B4E9", "#56B4E9"),
  pch.rows = c(16, 1),
  pch.columns = c(17, 2),
  size = c(1, 3),
  xlim = NULL,
  ylim = NULL,
  main = NULL,
  sub = NULL,
  legend = list(x = "topleft")
)

\S4method{biplot}{PCA}(
  x,
  ...,
  axes = c(1, 2),
  type = c("form", "covariance"),
  active = TRUE,
  sup = TRUE,
  labels = "variables",
  col.rows = c("#E69F00", "#E69F00"),
  col.columns = c("#56B4E9", "#56B4E9"),
  pch.rows = c(16, 1),
  lty.columns = c(1, 3),
  xlim = NULL,
  ylim = NULL,
  main = NULL,
  sub = NULL,
  legend = list(x = "topleft")
)
}
\arguments{
\item{x}{A \code{\linkS4class{CA}}, \code{\linkS4class{MCA}} or \code{\linkS4class{PCA}} object.}

\item{...}{Currently not used.}

\item{axes}{A length-two \code{\link{numeric}} vector giving the dimensions to be
plotted.}

\item{type}{A \code{\link{character}} string specifying the biplot to be plotted
(see below). It must be one of "\code{rows}", "\code{columns}", "\code{contribution}" (CA),
"\code{form}" or "\code{covariance}" (PCA). Any unambiguous substring can be given.}

\item{active}{A \code{\link{logical}} scalar: should the active observations be
plotted?}

\item{sup}{A \code{\link{logical}} scalar: should the supplementary observations be
plotted?}

\item{labels}{A \code{\link{character}} vector specifying whether
"\code{rows}"/"\code{individuals}" and/or "\code{columns}"/"\code{variables}" names must be
drawn. Any unambiguous substring can be given.}

\item{col.rows, col.columns}{A length-two \code{vector} of color specification for
the active and supplementary rows/columns.}

\item{pch.rows, pch.columns}{A length-two \code{vector} of symbol specification for
the active and supplementary rows/columns.}

\item{size}{A length-two \code{\link{numeric}} vector giving range of possible sizes
(greater than 0). Only used if \code{type} is "\code{contribution}" (CA).}

\item{xlim}{A length-two \code{\link{numeric}} vector giving the x limits of the plot.
The default value, \code{NULL}, indicates that the range of the
\link[=is.finite]{finite} values to be plotted should be used.}

\item{ylim}{A length-two \code{\link{numeric}} vector giving the y limits of the plot.
The default value, \code{NULL}, indicates that the range of the
\link[=is.finite]{finite} values to be plotted should be used.}

\item{main}{A \code{\link{character}} string giving a main title for the plot.}

\item{sub}{A \code{\link{character}} string giving a subtitle for the plot.}

\item{legend}{A \code{\link{list}} of additional arguments to be passed to
\code{\link[graphics:legend]{graphics::legend()}}; names of the list are used as argument names.
If \code{NULL}, no legend is displayed.}

\item{lty.columns}{A length-two \code{vector} of line type specification for
the active and supplementary columns.}
}
\value{
\code{biplot()} is called for its side-effects: it results in a graphic being
displayed. Invisibly returns \code{x}.
}
\description{
Biplot
}
\details{
A biplot is the simultaneous representation of rows and columns of a
rectangular dataset. It is the generalization of a scatterplot to the case
of mutlivariate data: it allows to visualize as much information as possible
in a single graph (Greenacre 2010).

Biplots have the drawbacks of their advantages: they can quickly become
difficult to read as they display a lot of information at once. It may then
be preferable to visualize the results for individuals and variables
separately.
}
\section{PCA Biplots}{

\describe{
\item{\code{form} (row-metric-preserving)}{The form biplot favors the
representation of the individuals: the distance between the individuals
approximates the Euclidean distance between rows. In the form biplot the
length of a vector approximates the quality of the representation of the
variable.}
\item{\code{covariance} (column-metric-preserving)}{The covariance biplot favors
the representation of the variables: the length of a vector approximates
the standard deviation of the variable and the cosine of the angle formed
by two vectors approximates the correlation between the two variables. In
the covariance biplot the distance between the individuals approximates the
Mahalanobis distance between rows.}
}
}

\section{CA Biplots}{

\describe{
\item{\code{symetric} (symetric biplot)}{Represents the row and column profiles
simultaneously in a common space: rows and columns are in standard
coordinates. Note that the the inter-distance between any row and column
items is not meaningful (i.e. the proximity between rows and columns cannot
be directly interpreted).}
\item{\code{rows} (asymetric biplot)}{Row principal biplot (row-metric-preserving)
with rows in principal coordinates and columns in standard coordinates.}
\item{\code{columns} (asymetric biplot)}{Column principal biplot
(column-metric-preserving) with rows in standard coordinates and columns in
principal coordinates.}
\item{\code{contribution} (asymetric biplot)}{Contribution biplot with rows in
principal coordinates and columns in standard coordinates multiplied by the
square roots of their masses.}
}
}

\examples{
## Replicate examples from Greenacre 2007, p. 59-68
data("iris")

## Compute principal components analysis
## All rows and all columns obtain the same weight
row_w <- rep(1 / nrow(countries), nrow(countries)) # 1/13
col_w <- rep(1 / ncol(countries), ncol(countries)) # 1/6
Y <- pca(iris, scale = FALSE, sup_quali = "Species")

## Row-metric-preserving biplot (form biplot)
biplot(Y, type = "form")

## Column-metric-preserving biplot (covariance biplot)
biplot(Y, type = "covariance", legend = list(x = "bottomright"))

## Replicate examples from Greenacre 2007, p. 79-88
data("benthos")

## Compute correspondence analysis
X <- ca(benthos)

## Symetric CA biplot
biplot(X, labels = "columns", legend = list(x = "bottomright"))

## Row principal CA biplot
biplot(X, type = "row", labels = "columns", legend = list(x = "bottomright"))

## Column principal CA biplot
biplot(X, type = "column", labels = "columns", legend = list(x = "bottomright"))

## Contribution CA biplot
biplot(X, type = "contrib", labels = NULL, legend = list(x = "bottomright"))
}
\references{
Aitchison, J. and Greenacre, M. J. (2002). Biplots of Compositional Data.
\emph{Journal of the Royal Statistical Society: Series C (Applied Statistics)},
51(4): 375-92. \doi{10.1111/1467-9876.00275}.

Greenacre, M. J. (2010). \emph{Biplots in Practice}. Bilbao: Fundación BBVA.
}
\seealso{
Other plot methods: 
\code{\link{plot}()},
\code{\link{screeplot}()},
\code{\link{viz_contributions}()},
\code{\link{viz_individuals}()},
\code{\link{viz_variables}()}
}
\author{
N. Frerebeau
}
\concept{plot methods}
