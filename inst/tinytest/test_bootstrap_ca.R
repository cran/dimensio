Sys.setenv(LANGUAGE = "en") # Force locale

if (at_home() && Sys.info()["sysname"] == "Linux") {
  using("tinysnapshot")
  source("helpers.R")

  data("colours")

  X <- ca(colours)
  Y <- with_seed(12345, bootstrap(X, n = 30))

  expect_equal_to_reference(get_coordinates(Y, margin = 1), file = "_snaps/ca_row_bootstrap.rds")
  expect_equal(dim(get_replications(Y, margin = 1)), c(4L, 3L, 30L))

  expect_equal_to_reference(get_coordinates(Y, margin = 2), file = "_snaps/ca_col_bootstrap.rds")
  expect_equal(dim(get_replications(Y, margin = 2)), c(4L, 3L, 30L))

  expect_true(dimensio:::has_groups(Y, margin = 1))
  expect_true(dimensio:::has_groups(Y, margin = 2))

  plot_boot_row <- function() {
    viz_rows(Y, axes = c(1, 2), color = NULL, legend = list(x = "topleft"))
    viz_hull(Y, color = NULL)
  }
  expect_snapshot_plot(plot_boot_row, "CA_boot_row")

  plot_boot_col <- function() {
    viz_columns(Y, axes = c(1, 2), color = NULL, legend = list(x = "topleft"))
    viz_hull(Y, color = NULL)
  }
  expect_snapshot_plot(plot_boot_col, "CA_boot_col")
}
