# PLOT ELLIPSE
#' @include AllGenerics.R
NULL

#' @export
#' @rdname viz_wrap
#' @aliases viz_tolerance,MultivariateAnalysis-method
setMethod(
  f = "viz_tolerance",
  signature = c(x = "MultivariateAnalysis"),
  definition = function(x, ..., margin = 1, axes = c(1, 2), group = NULL, level = 0.95) {
    .viz_ellipse(x, ..., type = "tolerance", level = level,
                 margin = margin, axes = axes, group = group)
  }
)

#' @export
#' @rdname viz_wrap
#' @aliases viz_tolerance,BootstrapCA-method
setMethod(
  f = "viz_tolerance",
  signature = c(x = "BootstrapCA"),
  definition = function(x, ..., margin = 1, axes = c(1, 2), level = 0.95) {
    group <- get_groups(x, margin = margin)
    methods::callNextMethod(x, margin = margin, axes = axes, group = group,
                            level = level, ...)
    invisible(x)
  }
)

#' @export
#' @rdname viz_wrap
#' @aliases viz_confidence,MultivariateAnalysis-method
setMethod(
  f = "viz_confidence",
  signature = c(x = "MultivariateAnalysis"),
  definition = function(x, ..., margin = 1, axes = c(1, 2), group = NULL, level = 0.95) {
    .viz_ellipse(x, ..., type = "confidence", level = level,
                 margin = margin, axes = axes, group = group)
  }
)

#' @export
#' @rdname viz_wrap
#' @aliases viz_confidence,BootstrapCA-method
setMethod(
  f = "viz_confidence",
  signature = c(x = "BootstrapCA"),
  definition = function(x, ..., margin = 1, axes = c(1, 2), level = 0.95) {
    group <- get_groups(x, margin = margin)
    methods::callNextMethod(x, margin = margin, axes = axes, group = group,
                            level = level, ...)
    invisible(x)
  }
)

.viz_ellipse <- function(x, ..., type = c("tolerance", "confidence"),
                         level = 0.95, margin = 1, axes = c(1, 2),
                         group = NULL, border = graphics::par("col"),
                         col = NA, lty = graphics::par("lty"),
                         lwd = graphics::par("lwd")) {
  fun <- switch(
    type,
    tolerance = wrap_tolerance,
    confidence = wrap_confidence
  )
  ell <- fun(x, margin = margin, axes = axes, group = group, level = level)
  n <- length(ell)

  ## Graphical parameters
  if (length(border) != n) border <- rep(border, length.out = n)
  if (length(col) != n) col <- rep(col, length.out = n)
  if (length(lty) != n) lty <- rep(lty, length.out = n)
  if (length(lwd) != n) lwd <- rep(lwd, length.out = n)

  for (i in seq_along(ell)) {
    lvl <- ell[[i]]
    for (j in seq_along(lvl)) {
      graphics::polygon(x = lvl[[j]], border = border[i],
                        col = col[i], lty = lty[i], lwd = lwd[i])
    }
  }

  invisible(x)
}
