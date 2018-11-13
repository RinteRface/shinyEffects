# #' Tool for live CSS manipulation
# #'
# #' UI shiny module
# #'
# #' @export
# #'
# #' @examples
# #'  if (interactive()) {
# #' }
# manipulateCssUI <- function() {
#  htmltools::tags$head(
#    htmltools::tags$script(
#      "$(document).click(function(event) {
#         var selectedTag = $(event.target).parent();
#         console.log($selectedTag[0]);
#         Shiny.onInputChange('selectedTag', selectedTag[0]);
#       });
#      "
#    )
#  )
# }
#
#
# #' Tool for live CSS manipulation
# #'
# #' Server shiny module
# #'
# #' @export
# #'
# #' @examples
# #'  if (interactive()) {
# #' }
# manipulateCss <- function() {
#
# }
