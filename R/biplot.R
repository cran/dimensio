# BIPLOT
#' @include AllGenerics.R
NULL

# CA ===========================================================================
#' @export
#' @method biplot CA
biplot.CA <- function(x, ..., axes = c(1, 2),
                      type = c("symetric", "rows", "columns", "contributions"),
                      active = TRUE, sup = TRUE, labels = NULL,
                      col.rows = c("#E69F00", "#E69F00"),
                      col.columns = c("#56B4E9", "#56B4E9"),
                      pch.rows = c(16, 1), pch.columns = c(17, 2),
                      size = c(1, 3),
                      xlim = NULL, ylim = NULL, main = NULL, sub = NULL,
                      legend = list(x = "topleft")) {
  ## Validation
  type <- match.arg(type, several.ok = FALSE)

  ## Type of biplot
  if (type == "symetric") {
    princ_row <- TRUE
    princ_col <- TRUE
  }
  if (type == "rows") {
    princ_row <- TRUE
    princ_col <- FALSE
  }
  if (type == "columns") {
    princ_row <- FALSE
    princ_col <- TRUE
  }
  if (type == "contributions") {
    princ_row <- FALSE
    princ_col <- TRUE
    sup <- FALSE # Override
  }

  ## Get data
  coord_col <-  prepare_plot(x, margin = 2, axes = axes, active = active, sup = sup,
                             principal = princ_col, extra_quali = "observation",
                             color = col.columns, symbol = pch.columns, line_type = 0)
  coord_row <-  prepare_plot(x, margin = 1, axes = axes, active = active, sup = sup,
                             principal = princ_row, extra_quali = "observation",
                             color = col.rows, symbol = pch.rows, line_type = 0)

  ## Graphical parameters
  if (type == "contributions") {
    mass_row <- get_masses(x, margin = 1)
    mass_col <- get_masses(x, margin = 2)

    coord_row$x <- coord_row$x * sqrt(mass_row)
    coord_row$y <- coord_row$y * sqrt(mass_row)

    coord_row$cex <- khroma::palette_size_sequential(size)(mass_row)
    coord_col$cex <- khroma::palette_size_sequential(size)(mass_col)
  }

  coord <- viz_biplot(
    coord_row, coord_col,
    rows = TRUE, columns = TRUE,
    labels = labels,
    xlim = xlim, ylim = ylim,
    main = main, sub = sub,
    xlab = print_variance(x, axes[[1]]),
    ylab = print_variance(x, axes[[2]]),
    legend = legend,
    ...
  )

  ## Add legend
  prepare_legend(coord, legend, points = TRUE, lines = FALSE)

  invisible(x)
}

#' @export
#' @rdname biplot
#' @aliases biplot,CA-method
setMethod("biplot", c(x = "CA"), biplot.CA)

# PCA ==========================================================================
#' @export
#' @method biplot PCA
biplot.PCA <- function(x, ..., axes = c(1, 2), type = c("form", "covariance"),
                       active = TRUE, sup = TRUE, labels = "variables",
                       col.rows = c("#E69F00", "#E69F00"),
                       col.columns = c("#56B4E9", "#56B4E9"),
                       pch.rows = c(16, 1), lty.columns = c(1, 3),
                       xlim = NULL, ylim = NULL, main = NULL, sub = NULL,
                       legend = list(x = "topleft")) {
  ## Validation
  type <- match.arg(type, several.ok = FALSE)

  ## Type of biplot
  if (type == "form") {
    princ_row <- TRUE
    princ_col <- FALSE
  }
  if (type == "covariance") {
    princ_row <- FALSE
    princ_col <- TRUE
  }

  ## Get data
  coord_col <-  prepare_plot(x, margin = 2, axes = axes, active = active, sup = sup,
                             principal = princ_col, extra_quali = "observation",
                             color = col.columns, symbol = NA,
                             line_type = lty.columns, ...)
  coord_row <-  prepare_plot(x, margin = 1, axes = axes, active = active, sup = sup,
                             principal = princ_row, extra_quali = "observation",
                             color = col.rows, symbol = pch.rows,
                             line_type = NA, ...)

  arrows_col <- function() {
    graphics::arrows(
      x0 = 0, y0 = 0,
      x1 = coord_col$x, y1 = coord_col$y,
      length = 0.10, angle = 30,
      col = coord_col$col, lty = coord_col$lty, lwd = coord_col$lwd
    )
  }

  coord <- viz_biplot(
    coord_row, coord_col,
    rows = TRUE, columns = FALSE, labels = labels,
    xlim = xlim, ylim = ylim,
    main = main, sub = sub,
    xlab = print_variance(x, axes[[1]]),
    ylab = print_variance(x, axes[[2]]),
    panel.first = arrows_col(),
    legend = legend,
    ...
  )

  ## Add legend
  prepare_legend(coord, legend, points = TRUE, lines = TRUE)

  invisible(x)
}

#' @export
#' @rdname biplot
#' @aliases biplot,PCA-method
setMethod("biplot", c(x = "PCA"), biplot.PCA)

# Helpers ======================================================================
#' Build a Biplot
#'
#' @param coord_row A [`data.frame`] returned by [prepare_plot()].
#' @param coord_col A [`data.frame`] returned by [prepare_plot()].
#' @param rows A [`logical`] scalar: should the rows be drawn?
#' @param columns A [`logical`] scalar: should the columns be drawn?
#' @param labels A [`character`] vector specifying whether
#'  "`rows`"/"`individuals`" and/or "`columns`"/"`variables`" names must be
#'  drawn. Any unambiguous substring can be given.
#' @param xlim A length-two [`numeric`] vector giving the x limits of the plot.
#'  The default value, `NULL`, indicates that the range of the
#'  [finite][is.finite()] values to be plotted should be used.
#' @param ylim A length-two [`numeric`] vector giving the y limits of the plot.
#'  The default value, `NULL`, indicates that the range of the
#'  [finite][is.finite()] values to be plotted should be used.
#' @param main A [`character`] string giving a main title for the plot.
#' @param sub A [`character`] string giving a subtitle for the plot.
#' @param xlab,ylab A [`character`] vector giving the x and y axis labels.
#' @param axes A [`logical`] scalar: should axes be drawn on the plot?
#' @param frame.plot A [`logical`] scalar: should a box be drawn around the
#'  plot?
#' @param ann A [`logical`] scalar: should the default annotation (title and x
#'  and y axis labels) appear on the plot?
#' @param panel.first An `expression` to be evaluated after the plot axes are
#'  set up but before any plotting takes place. This can be useful for drawing
#'  background grids.
#' @param panel.last An `expression` to be evaluated after plotting has taken
#'  place but before the axes, title and box are added.
#' @return A [`data.frame`] to be passed to [prepare_legend()].
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
viz_biplot <- function(coord_row, coord_col, ..., rows = TRUE, columns = TRUE,
                       labels = c("rows", "columns", "individuals", "variables"),
                       xlim = NULL, ylim = NULL, main = NULL, sub = NULL,
                       xlab = NULL, ylab = NULL, axes = TRUE, frame.plot = axes,
                       ann = graphics::par("ann"),
                       panel.first = NULL, panel.last = NULL) {

  ## Save and restore graphical parameters
  ## pty: square plotting region, independent of device size
  old_par <- graphics::par(pty = "s", no.readonly = TRUE)
  on.exit(graphics::par(old_par), add = TRUE)

  ## Open new window
  grDevices::dev.hold()
  on.exit(grDevices::dev.flush(), add = TRUE)
  graphics::plot.new()

  ## Set plotting coordinates
  xlim <- xlim %||% range(coord_row$x, coord_col$x, na.rm = TRUE, finite = TRUE)
  ylim <- ylim %||% range(coord_row$y, coord_col$y, na.rm = TRUE, finite = TRUE)
  graphics::plot.window(xlim = xlim, ylim = ylim, asp = 1)

  ## Evaluate pre-plot expressions
  panel.first

  ## Plot
  graphics::abline(h = 0, lty = "dashed", lwd = 1, col = graphics::par("fg"))
  graphics::abline(v = 0, lty = "dashed", lwd = 1, col = graphics::par("fg"))
  if (rows) {
    graphics::points(x = coord_row$x, y = coord_row$y, col = coord_row$col,
                     pch = coord_row$pch, cex = coord_row$cex)
  }
  if (columns) {
    graphics::points(x = coord_col$x, y = coord_col$y, col = coord_col$col,
                     pch = coord_col$pch, cex = coord_col$cex)
  }

  ## Labels
  if (!is.null(labels)) {
    labels <- match.arg(labels, several.ok = TRUE)
    if (any(labels == "rows") | any(labels == "individuals")) {
      viz_labels(coord_row, filter = NULL)
    }
    if (any(labels == "columns") | any(labels == "variables")) {
      viz_labels(coord_col, filter = NULL)
    }
  }

  ## Evaluate post-plot and pre-axis expressions
  panel.last

  ## Construct axis
  if (axes) {
    graphics::axis(side = 1, las = 1)
    graphics::axis(side = 2, las = 1)
  }

  ## Plot frame
  if (frame.plot) {
    graphics::box()
  }

  ## Add annotation
  if (ann) {
    graphics::title(main = main, sub = sub, xlab = xlab, ylab = ylab)
  }

  ## Legend
  coord_row$extra_quali <- paste(coord_row$extra_quali, "ind.", sep = " ")
  coord_col$extra_quali <- paste(coord_col$extra_quali, "var.", sep = " ")
  rbind(coord_row, coord_col)
}
