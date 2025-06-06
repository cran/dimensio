## Options for snapshot tests
options(tinysnapshot_os = "Linux")
options(tinysnapshot_device = "svglite")
options(tinysnapshot_height = 7) # inches
options(tinysnapshot_width = 7)
options(tinysnapshot_tol = 250) # pixels
options(tinysnapshot_device_args = list(user_fonts = fontquiver::font_families("Liberation")))

## Set the seed for just a code block
## https://stackoverflow.com/questions/56191862/where-do-i-specify-random-seed-for-tests-in-r-package
with_seed <- function(seed, code) {
  code <- substitute(code)
  ## Save and restore the random number generator (RNG) state
  if (exists(".Random.seed", mode = "numeric")) {
    orig.seed <- .Random.seed
    on.exit(.Random.seed <<- orig.seed)
  }
  ## Keep the results the same for R versions prior to 3.6
  if (getRversion() >= "3.6") {
    ## Set sample.kind = "Rounding" to reproduce the old sampling
    ## Suppress warning "non-uniform 'Rounding' sampler used"
    suppressWarnings(set.seed(seed, sample.kind = "Rounding"))
  } else {
    set.seed(seed)
  }
  eval.parent(code)
}

