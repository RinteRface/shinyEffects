# #' shinyEffects
# #'
# #' Use only if you need shinyEffects on the server side
# #'
# #' @examples
# #' library(shiny)
# #'
# #' ui <- fluidPage(
# #'   use_effects(), # dependencies
# #'
# #'   actionButton("show", "Show loading for 5 seconds")
# #' )
# #'
# #' server <- function(input, output, session){
# #'   waiter_hide() # will hide *on_load waiter
# #'
# #'   observeEvent(input$show, {
# #'
# #'   })
# #' }
# #'
# #' if(interactive()) shinyApp(ui, server)
# #'
# #' @import shiny
# #' @export
# use_effects <- function() {
#   singleton(
#     tags$head(
#       tags$script(
#         src = "shinyeffects-assets/js/shinyeffects.js"
#       ),
#       tags$link(
#         href = "shinyeffects-assets/css/shinyeffects.css",
#         rel = "stylesheet",
#         type = "text/css"
#       )
#     )
#   )
# }
