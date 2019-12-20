.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "shinyeffects-assets",
    system.file("assets", package = "shinyEffects")
  )
}
