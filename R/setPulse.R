#' Custom pulse animation: UI side
#'
#' Allow to apply a pulse animation on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the pulse should be applied.
#' For example, class is set to box. All elements having the box class
#' will be affected.
#' @param duration Pulse frequency. 1s by default.
#' @param iteration Pulse iteration. 5 by default.
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
#'       setPulse(class = "box", duration = 1, iteration = 100),
#'       setPulse(id = "my-progress", duration = 1, iteration = 100),
#'
#'       tags$h2("Add pulse animation to the box class"),
#'       fluidRow(boxTag, boxTag),
#'       tags$h2("Add pulse animation only to the first element using id"),
#'       tagAppendAttributes(
#'        verticalProgress(
#'         value = 10,
#'         striped = TRUE,
#'         active = TRUE
#'        ),
#'        id = "my-progress"
#'       ),
#'       verticalProgress(
#'         value = 50,
#'         active = TRUE,
#'         status = "warning",
#'         size = "xs"
#'       ),
#'       verticalProgress(
#'         value = 20,
#'         status = "danger",
#'         size = "sm",
#'         height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setPulse <- function(id = NULL, class = NULL, duration = 1, iteration = 5) {

  # pulse css
  cssPulse <- paste0(
    "animation: pulse ", duration, "s;
     animation-iteration-count: ", iteration, ";
    "
  )

  cssPulse <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, " .", class, " {", cssPulse, "}")
    } else {
      paste0("#", id, " {", cssPulse, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, " {", cssPulse, "}")
    } else {
      NULL
    }
  }

  # other CSS elements
  extracss <- paste0(
    "@-webkit-keyframes pulse {
      0% {
        -webkit-box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
      }
      70% {
        -webkit-box-shadow: 0 0 0 10px rgba(204,169,44, 0);
      }
      100% {
        -webkit-box-shadow: 0 0 0 0 rgba(204,169,44, 0);
      }
     }
     @keyframes pulse {
      0% {
        -moz-box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
        box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
      }
      70% {
        -moz-box-shadow: 0 0 0 10px rgba(204,169,44, 0);
        box-shadow: 0 0 0 10px rgba(204,169,44, 0);
      }
      100% {
        -moz-box-shadow: 0 0 0 0 rgba(204,169,44, 0);
        box-shadow: 0 0 0 0 rgba(204,169,44, 0);
      }
     }
    "
  )

  css <- paste(cssPulse, extracss)

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}





#' Custom pulse animation: Server side
#'
#' Allow to apply a pulse animation on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the pulse should be applied.
#' For example, class is set to box. All elements having the box class
#' will be affected.
#' @param duration Pulse frequency. 1s by default.
#' @param iteration Pulse iteration. 5 by default.
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
#'       use_effects(),
#'       actionButton("goPulse", "Trigger pulse effect"),
#'       tags$h2("Add pulse animation to the box class"),
#'       fluidRow(boxTag, boxTag),
#'       tags$h2("Add pulse animation only to the first element using id"),
#'       tagAppendAttributes(
#'        verticalProgress(
#'         value = 10,
#'         striped = TRUE,
#'         active = TRUE
#'        ),
#'        id = "my-progress"
#'       ),
#'       verticalProgress(
#'         value = 50,
#'         active = TRUE,
#'         status = "warning",
#'         size = "xs"
#'       ),
#'       verticalProgress(
#'         value = 20,
#'         status = "danger",
#'         size = "sm",
#'         height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output, session) {
#'     observeEvent(input$goPulse, {
#'      set_pulse(class = "box", duration = 1, iteration = 100)
#'      set_pulse(id = "my-progress", duration = 1, iteration = 100)
#'     })
#'    }
#'   )
#' }
set_pulse <- function(session = shiny::getDefaultReactiveDomain(), id = NULL,
                      class = NULL, duration = 1, iteration = 5) {

  if (!is.null(id) & !is.null(class)) stop("Only 1 selector allowed: choose either id or class.")
  if (is.null(id) & is.null(class)) stop("Choose at least one selector: id or class.")
  cssSelector <- if (!is.null(id)) paste0("#", id) else paste0(".", class)

  message <- dropNulls(
    list(
      selector = cssSelector,
      cl = class,
      timeout = duration,
      n = iteration
    )
  )

  session$sendCustomMessage(type = "set-pulse", message)
}
