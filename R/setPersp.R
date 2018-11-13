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
#'   boxTag <- boxPlus(
#'    title = "Closable box, with label",
#'    closable = TRUE,
#'    enable_label = TRUE,
#'    label_text = 1,
#'    label_status = "danger",
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    p("Box Content")
#'   )
#'
#'   shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'        enable_rightsidebar = TRUE,
#'        rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'
#'       setPersp(id = "my-box-1", angle = 45),
#'       setPersp(id = "my-box-2", angle = 45, side = "right", hover = TRUE),
#'
#'       tags$h2("Add Perspective effects"),
#'       br(),
#'       fluidRow(
#'        tagAppendAttributes(boxTag[[2]], id = "my-box-1"),
#'        tagAppendAttributes(boxTag[[2]], id = "my-box-2")
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
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
