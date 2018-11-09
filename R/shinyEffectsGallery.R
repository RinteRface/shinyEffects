#' @title Launch the shinyEffects Gallery
#'
#' @description
#' A gallery of all components available in shinyEffects.
#'
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'
#'  shinyEffectsGallery()
#'
#' }
shinyEffectsGallery <- function() { # nocov start
  if (!requireNamespace(package = "shinydashboardPlus"))
    message("Package 'shinydashboardPlus' is required to run this function")
  if (!requireNamespace(package = "bs4Dash"))
    message("Package 'bs4Dash' is required to run this function")

  shiny::shinyAppFile(system.file('examples/app.R', package = 'shinyEffects', mustWork = TRUE))
}
