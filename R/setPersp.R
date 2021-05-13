#' Custom perspective effect
#'
#' Allow to apply a perspective effect on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the persp should be applied.
#' @param direction Perspective direction: "X" or "Y".
#' @param angle Rotation intensity: numeric, 45 by default.
#' @param depth Perspective depth: numeric, 600 by default.
#' @param side Perspective side: "left" or "right".
#' @param hover Whether to apply the persp effect on hover. FALSE by default.
#'
#' @export
#'
#' @examples
#'  if (interactive()) {
#'
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'   library(shinyEffects)
#'
#'   boxTag <- box(
#'    id = "mybox",
#'    title = "A box",
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    p("Box Content")
#'   )
#'
#'   shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'
#'       setPersp(id = "mybox", angle = 45),
#'
#'       tags$h2("Add Perspective effects"),
#'       br(),
#'       boxTag
#'      ),
#'      controlbar = dashboardControlbar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setPersp <- function(id = NULL, class = NULL, direction = "Y",
                    angle = 45, depth = 600, side = "left",
                    hover = FALSE) {

  sign <- NULL
  if (side == "left") sign <- NULL else sign <- "-"

  cssPersp <- paste0("transform: perspective(", depth, "px) rotate",
                     direction, "(", sign, angle, "deg);")

  css <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, if (hover) ":hover .", class, if (hover) ":hover {", cssPersp, "}")
    } else {
      paste0("#", id, if (hover) ":hover", " {", cssPersp, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, if (hover) ":hover", " {", cssPersp, "}")
    } else {
      NULL
    }
  }

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}
