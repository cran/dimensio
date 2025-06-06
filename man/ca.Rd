% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/ca.R
\docType{methods}
\name{ca}
\alias{ca}
\alias{ca-method}
\alias{ca,data.frame-method}
\alias{ca,matrix-method}
\title{Correspondence Analysis}
\usage{
ca(object, ...)

\S4method{ca}{data.frame}(
  object,
  rank = NULL,
  sup_row = NULL,
  sup_col = NULL,
  sup_quali = NULL,
  autodetect = FALSE
)

\S4method{ca}{matrix}(object, rank = NULL, sup_row = NULL, sup_col = NULL)
}
\arguments{
\item{object}{A \eqn{m \times p}{m x p} \code{numeric} \code{\link{matrix}} or a
\code{\link{data.frame}}.}

\item{...}{Currently not used.}

\item{rank}{An \code{\link{integer}} value specifying the maximal number of
components to be kept in the results. If \code{NULL} (the default),
\eqn{min(m, p) - 1} components will be returned.}

\item{sup_row}{A \code{vector} specifying the indices of the supplementary rows.}

\item{sup_col}{A \code{vector} specifying the indices of the supplementary columns.}

\item{sup_quali}{A \code{vector} specifying the indices of the supplementary
qualitative columns.}

\item{autodetect}{A \code{\link{logical}} scalar: should non-numeric variables be
automatically removed?}
}
\value{
A \code{\linkS4class{CA}} object.
}
\description{
Computes a simple correspondence analysis based on the singular value
decomposition.
}
\examples{
## Data from Lebart et al. 2006, p. 170-172
data("colours")

## The chi square of independence between the two variables
stats::chisq.test(colours)

## Compute correspondence analysis
X <- ca(colours)

## Plot rows
viz_rows(X, labels = TRUE)

## Plot columns
viz_columns(X, labels = TRUE)

## Get row coordinates
get_coordinates(X, margin = 1)

## Get column coordinates
get_coordinates(X, margin = 2)

## Get total inertia
sum(get_inertia(X))

## Get row contributions
get_contributions(X, margin = 1)
}
\references{
Greenacre, M. J. \emph{Theory and Applications of Correspondence Analysis}.
London: Academic Press, 1984.

Greenacre, M. J. \emph{Correspondence Analysis in Practice}. Seconde edition.
Interdisciplinary Statistics Series. Boca Raton: Chapman & Hall/CRC, 2007.

Lebart, L., Piron, M. and Morineau, A. \emph{Statistique exploratoire
multidimensionnelle: visualisation et inférence en fouille de données}.
Paris: Dunod, 2006.
}
\seealso{
\code{\link[=svd]{svd()}}

Other multivariate analysis: 
\code{\link{mca}()},
\code{\link{pca}()},
\code{\link{pcoa}()},
\code{\link{predict}()}
}
\author{
N. Frerebeau
}
\concept{multivariate analysis}
