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

#' @title mtab2df
#'
#' @description Convert `sjPlot::tab_model`-objects to R data.frame or
#'   `knitr::kable`
#'
#' @param mtab A model table, created with `sjPlot::tab_model`.
#'
#' @param n_models An integer, specifiying the number of models in the table.
#'
#' @inheritParams xtab2df
#'
#' @return An object of the type specified with the `output` argument.
#'
#' @import data.table
#' @importFrom magrittr "%>%"

#' @examples
#' set.seed(1)
#' dataset <- data.table::data.table(
#'   "var1" = factor(sample(
#'     x = c("yes", "no"),
#'     size = 100,
#'     replace = TRUE,
#'     prob = c(.3, .7)
#'   )),
#'   "var2" = factor(sample(
#'     x = c("yes", "no"),
#'     size = 100,
#'     replace = TRUE
#'   )),
#'   "var3" = rnorm(100)
#' )
#'
#' # models
#' m0 <- stats::glm(
#'   var1 ~ 1,
#'   data = dataset,
#'   family = binomial(link = "logit")
#' )
#' m1 <- stats::glm(
#'   var1 ~ var2,
#'   data = dataset,
#'   family = binomial(link = "logit")
#' )
#' m2 <- stats::glm(
#'   var1 ~ var2 + var3,
#'   data = dataset,
#'   family = binomial(link = "logit")
#' )
#'
#' m_table <- sjPlot::tab_model(m0, m1, m2, show.aic = TRUE)
#'
#' final_tab <- sjtable2df::mtab2df(mtab = m_table, n_models = 3)
#'
#' @export
#'
mtab2df <- function(mtab, n_models, output = "data.table", ...) {
  stopifnot(inherits(mtab, "sjTable"))
  stopifnot(is.integer(as.integer(n_models)))

  # create statistics table
  stats_table <- get_html_table(tab = mtab)

  # test if all models have the same dependent variable
  stopifnot(
    stats_table %>%
      colnames() %>%
      .[2:ncol(stats_table)] %>%
      unique() %>%
      length() == 1
  )

  # headline for kable
  kbl_headline <- colnames(stats_table)[2]

  colnames(stats_table) <- stats_table[1, ] %>% as.character()
  stats_table <- stats_table[-1, ]

  # get columns to suppress
  suppress_cols <- lapply(
    X = c(1:n_models),
    FUN = function(x) {
      # columns of statistics to suppress
      start_col <- x * 3
      end_col <- start_col + 1
      return(c(start_col, end_col))
    }
  ) %>% unlist()

  # get rows to suppress
  values_col_one <- stats_table[, 1] %>% unlist()
  if ("Random Effects" %in% values_col_one) {
    suppress_term <- "Random Effects"
    # remove multiple occurence of "Random Effects"
    append_row <- invisible(lapply(
      X = c(
        suppress_term,
        rep("", times = (ncol(stats_table) - 1))
      ),
      FUN = function(x) {
        return(x)
      }
    ))
    stats_table <- data.table::rbindlist(
      l = list(
        stats_table[1:(which(stats_table[, 1] == suppress_term) - 1), ],
        append_row,
        stats_table[(which(stats_table[, 1] == suppress_term) + 1):nrow(
          stats_table
        ), ]
      )
    )
  } else if ("Observations" %in% values_col_one){
    suppress_term <- "Observations"
  }

  suppress_rows <- which(
    stats_table[, 1] == suppress_term):nrow(stats_table)

  # suprress info
  for (colnum in suppress_cols) {
    stats_table[suppress_rows, (colnum) := ""]
  }

  # data.table output
  if (output %in% c("data.table", "data.frame")) {

    if (output == "data.frame") {
      stats_table %>%
        as.data.frame() %>%
        return()
    } else {
      return(stats_table)
    }
  } else if (output == "kable") {
    # utf8 replacements for kable
    first_col <- colnames(stats_table)[1]
    stats_table[, (first_col) := utf_replacements(
      vec = get(first_col),
      kable_mtab = TRUE
    )]

    final_table <- stats_table %>%
      kableExtra::kbl(...)

    kbl_header <- c(
      " " = 1,
      kbl_headline = ncol(stats_table) - 1
    )
    names(kbl_header) <- c(" ", kbl_headline)

    final_table %>%
      kableExtra::add_header_above(
        header = kbl_header
      ) %>%
      return()
  }
}

