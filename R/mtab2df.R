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
#' @description Convert table from `sjPlot::tab_model` to R data.frame or
#'   `knitr::kable`
#'
#' @param mtab A model table, created with `sjPlot::tab_model`.
#'
#' @param n_models An integer, specifiying the number of models in the table.
#'
#' @inheritParams xtab2df
#'
#' @return The table is returned as an R object of the type specified with
#'   the `output` argument.
#'
#' @examples
#' \donttest{
#' if (requireNamespace("sjPlot", quietly = TRUE)) {
#'   set.seed(1)
#'   dataset <- data.table::data.table(
#'     "var1" = factor(sample(
#'       x = c("yes", "no"),
#'       size = 100,
#'       replace = TRUE,
#'       prob = c(.3, .7)
#'     )),
#'     "var2" = factor(sample(
#'       x = c("yes", "no"),
#'       size = 100,
#'       replace = TRUE
#'     )),
#'     "var3" = rnorm(100)
#'   )
#'
#'   # models
#'   m0 <- stats::glm(
#'     var1 ~ 1,
#'     data = dataset,
#'     family = binomial(link = "logit")
#'   )
#'   m1 <- stats::glm(
#'     var1 ~ var2,
#'     data = dataset,
#'     family = binomial(link = "logit")
#'   )
#'   m2 <- stats::glm(
#'     var1 ~ var2 + var3,
#'     data = dataset,
#'     family = binomial(link = "logit")
#'   )
#'
#'   m_table <- sjPlot::tab_model(m0, m1, m2, show.aic = TRUE)
#'
#'   final_tab <- sjtable2df::mtab2df(mtab = m_table, n_models = 3)
#'
#' }}
#' @export
#'
mtab2df <- function(mtab, n_models, output = "data.table", ...) {
  stopifnot(
    "`mtab` must be a `sjTable` object as produced \
    by `sjPlot::tab_model`" = inherits(mtab, "sjTable"),
    "`n_models` must be a integer" = is.integer(as.integer(n_models))
  )

  # create statistics table
  stats_table <- get_html_table(tab = mtab)

  # test if all models have the same dependent variable
  stopifnot(
    "All provided models must have the same dependent variable" = length(
      unique(colnames(stats_table)[2:ncol(stats_table)])
    ) ==
      1
  )

  # headline for kable
  kbl_headline <- colnames(stats_table)[2]

  colnames(stats_table) <- stats_table[1, ] |> as.character()
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
  ) |>
    unlist()

  # get rows to suppress
  values_col_one <- stats_table[, 1] |> unlist()
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
        stats_table[
          (which(stats_table[, 1] == suppress_term) + 1):nrow(
            stats_table
          ),
        ]
      )
    )
  } else if ("Observations" %in% values_col_one) {
    suppress_term <- "Observations"
  }

  suppress_rows <- which(
    stats_table[, 1] == suppress_term
  ):nrow(stats_table)

  # suppress info
  for (colnum in suppress_cols) {
    stats_table[suppress_rows, (colnum) := ""]
  }

  # check for duplicates in last row
  first_col_dupl <- vapply(
    X = stats_table[nrow(stats_table), 2:ncol(stats_table)],
    FUN = function(x) {
      # has column >1 same value as col 1?
      stats_table[nrow(stats_table), 1] == x
    },
    FUN.VALUE = logical(1)
  )

  # check for empty values in other cols
  empty_other_cols <- vapply(
    X = stats_table[nrow(stats_table), 2:ncol(stats_table)],
    FUN = function(x) {
      # has column >1 empty string?
      "" == x
    },
    FUN.VALUE = logical(1)
  )

  if (sum(first_col_dupl) > 0) {
    # if other values are an empty string
    if (
      sum(first_col_dupl) == ncol(stats_table) ||
        identical(
          first_col_dupl,
          stats::setNames(
            object = as.logical(abs(empty_other_cols - 1)),
            nm = names(empty_other_cols)
          )
        )
    ) {
      # replace with empty string
      # keep significance level information only in the first column:
      stats_table[nrow(stats_table), 2:ncol(stats_table) := ""]
    }
  }

  # data.table output
  if (output %in% c("data.table", "data.frame")) {
    if (output == "data.frame") {
      ret <- stats_table |>
        as.data.frame()
      return(ret)
    } else {
      return(stats_table)
    }
  } else if (output == "kable") {
    # utf8 replacements for kable
    first_col <- colnames(stats_table)[1]
    stats_table[,
      (first_col) := utf_replacements(
        vec = get(first_col),
        kable_mtab = TRUE
      )
    ]

    final_table <- stats_table |>
      kableExtra::kbl(...)

    kbl_header <- c(
      " " = 1,
      kbl_headline = ncol(stats_table) - 1
    )
    names(kbl_header) <- c(" ", kbl_headline)

    ret <- final_table |>
      kableExtra::add_header_above(
        header = kbl_header
      )
    return(ret)
  }
}
