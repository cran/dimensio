# Rescale continuous vector ====================================================
expect_identical(scale_range(5:10), c(0, 0.2, 0.4, 0.6, 0.8, 1))
expect_identical(scale_midpoint(5:10, to = c(0, 5)), c(3.75, 4, 4.25, 4.5, 4.75, 5))


bw <- c("black", "white")
bgw <- c("black", "grey", "white")
lvl <- c("A", "A", "C", "B", "A", "B")

# Colors =======================================================================
## Continuous ------------------------------------------------------------------
expect_identical(palette_color()(c(1, 2, 3)),
                 c("#FFFFC8", "#F39200", "#7D0025"), )
expect_identical(palette_color(bw)(c(0, 0.5, 1)),
                 c("#000000", "#7F7F7F", "#FFFFFF"))
expect_identical(palette_color(bw)(c(1, 2, 3)),
                 c("#000000", "#7F7F7F", "#FFFFFF"))
expect_identical(palette_color(bw)(c(1, NA, 3)),
                 c("#000000", "#DDDDDD", "#FFFFFF"))

expect_identical(palette_color(bw, c(1, 2, 10))(c(1, 2, 3)),
                 c("#000000", "#1C1C1C", "#383838"))
expect_identical(palette_color(rev(bw))(c(1, 2, 3)),
                 rev(c("#000000", "#7F7F7F", "#FFFFFF")))

expect_error(palette_color_continuous()(LETTERS))
expect_warning(palette_color(bw, c(1, 2))(c(1, 2, 3)))
expect_identical(suppressWarnings(palette_color(bw, c(1, 2))(c(1, 2, 3))),
                 c("#000000", "#FFFFFF", "#DDDDDD"))

## Discrete --------------------------------------------------------------------
expect_identical(palette_color(NULL, LETTERS)(lvl),
                 c("#4B0055", "#4B0055", "#462169", "#4A0E5F", "#4B0055", "#4A0E5F"))
expect_identical(palette_color(c("#4477AA", "#EE6677", "#228833"), domain = c("A", "B", "C"))(lvl),
                 c("#4477AA", "#4477AA", "#228833", "#EE6677", "#4477AA", "#EE6677"))
expect_identical(palette_color(c("#4477AA", "#EE6677", "#228833"), domain = c("D", "E", "F"))(lvl),
                 c("#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD"))
expect_identical(palette_color(bgw, c("A", "B", "C"))(c(NA, NA, NA, NA, NA, NA)),
                 c("#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD", "#DDDDDD"))
expect_identical(palette_color(bgw, c("C", "B", "A"), ordered = FALSE)(lvl),
                 c("black", "black", "white", "grey", "black", "grey"))
expect_identical(palette_color(bgw, c("C", "B", "A"), ordered = TRUE)(lvl),
                 c("white", "white", "black", "grey", "white", "grey"))

named_colors <- c(B = "#4477AA", C = "#EE6677", A = "#228833")
expect_identical(palette_color(named_colors)(lvl),
                 c(A = "#228833", A = "#228833", C = "#EE6677",
                   B = "#4477AA", A = "#228833", B = "#4477AA"))

expect_warning(palette_color_discrete()(seq(0.1, 0.5, by = 0.1)))
expect_warning(palette_color(bw, LETTERS)(lvl))
expect_identical(suppressWarnings(palette_color(bw, LETTERS)(lvl)),
                 c("black", "black", NA, "white", "black", "white"))

# Symbols ======================================================================
expect_warning(palette_shape(NULL)(LETTERS))

expect_identical(palette_shape()(lvl),
                 c(16, 16, 15, 17, 16, 17))
expect_identical(palette_shape(c(1, 2, 3))(lvl),
                 c(1, 1, 3, 2, 1, 2))
expect_identical(palette_shape(c(1, 1, 1))(lvl),
                 c(1, 1, 1, 1, 1, 1))
expect_identical(palette_shape(c(1, 2))(lvl),
                 c(1, 1, NA, 2, 1, 2))
expect_identical(palette_shape(c(1))(lvl),
                 c(1, 1, NA, NA, 1, NA))

expect_identical(palette_shape(NULL, c("C", "B", "A"), ordered = FALSE)(lvl),
                 c(16, 16, 15, 17, 16, 17))
expect_identical(palette_shape(NULL, c("C", "B", "A"), ordered = TRUE)(lvl),
                 c(15, 15, 16, 17, 15, 17))

named_symbols <- c(B = 17, C = 15, A = 16)
expect_identical(palette_shape(named_symbols)(lvl),
                 c(A = 16, A = 16, C = 15, B = 17, A = 16, B = 17))

# Size =========================================================================
expect_error(palette_size_range()(lvl))
expect_error(palette_size_max(max = 1)(lvl))

# expect_equal(palette_size_range()(c(1, 2, 3)), c(1/3, 2/3, 3/3))
expect_identical(palette_size_range(4)(c(1, 2, 3)), c(4, 4, 4))
# expect_identical(palette_size_range(c(4, 5))(c(1, 2, 3)), c(4, 4.5, 5))
# expect_identical(palette_size_range(c(4, 5))(c(1, NA, 3)), c(4, NA, 5))
