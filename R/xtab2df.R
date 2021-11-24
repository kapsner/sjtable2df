# Convert 'sjPlot' HTML-tables to R data.frame
# Copyright (C) 2021  Lorenz A. Kapsner
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' @title xtab2df
#'
#' @description Convert `sjPlot::tab_xtab`-objects to R data.frame or
#'   `knitr::kable`
#'
#' @param xtab A contingency table, created with `sjPlot::tab_xtab`.
#'
#' @param output A character vector. Allowed values are: "data.table" (default),
#'   "data.frame" or "kable". The function's return value is of the respective
#'   type.
#'
#' @param ... Further arguments to be passed to `kableExtra::kbl`.
#'
#' @return An object of the type specified with the `output` argument.
#'
#' @import data.table
#' @importFrom magrittr "%>%"

#' @examples
#' set.seed(1)
#' dataset <- data.table::data.table(
#'   "var1" = sample(
#'     x = c("yes", "no"),
#'     size = 100,
#'     replace = TRUE,
#'     prob = c(.3, .7)
#'   ),
#'   "var2" = sample(
#'     x = c("yes", "no"),
#'     size = 100,
#'     replace = TRUE
#'   )
#' )
#'
#' xtab <- sjPlot::tab_xtab(
#'   var.row = dataset$var1,
#'   var.col = dataset$var2,
#'   show.summary = TRUE,
#'   use.viewer = FALSE
#' )
#'
#' sjtable2df::xtab2df(xtab = xtab)
#'
#' @export
#'
xtab2df <- function(xtab, output = "data.table", ...) {
  stopifnot(inherits(xtab, "sjtxtab"))

  # create statistics table
  stats_table <- get_html_table(tab = xtab)
  stats_table <- xtab_colnames(tab = stats_table)

  # get summary statistics
  stats_summary <- get_xtab_summary(xtab = xtab)

  # data.table output
  if (output %in% c("data.table", "data.frame")) {
    if (length(stats_summary) == 1) {
      append_row <- invisible(lapply(
        X = c(rep("", times = (ncol(stats_table) - 1)), stats_summary),
        FUN = function(x) {
          return(x)
        }
      ))
      final_table <- data.table::rbindlist(
        l = list(
          stats_table,
          append_row
        ),
        use.names = FALSE
      )
    } else {
      final_table <- stats_table
    }
    if (output == "data.frame") {
      final_table %>%
        as.data.frame() %>%
        return()
    } else {
      return(final_table)
    }
  } else if (output == "kable") {
    final_table <- stats_table %>%
      kableExtra::kbl(...)

    if (length(stats_summary) == 1) {
      final_table %>%
        kableExtra::add_footnote(
          label = paste0("$", stats_summary, "$"),
          notation = "none",
          escape = FALSE
        ) %>%
        return()
    } else {
      return(final_table)
    }
  }
}

