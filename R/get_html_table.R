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

get_html_table_elements <- function(tab) {
  tab$page.content %>%
    rvest::read_html() %>%
    rvest::html_element(css = "table") %>%
    return()
}

parse_html_table <- function(tab_content) {
  tab_content %>%
    rvest::html_table() %>%
    data.table::data.table() %>%
    return()
}

get_html_table <- function(tab) {
  tab %>%
    get_html_table_elements() %>%
    parse_html_table() %>%
    return()
}

get_xtab_html_table <- function(tab) {

  tab_content <- get_html_table_elements(tab)
  out_tab <- parse_html_table(tab_content)

  out_tab <- xtab_colnames(tab = out_tab)

  tab_ncol <- ncol(out_tab)
  tab_nrow <- nrow(out_tab)

  rows <- xml2::xml_find_all(tab_content, ".//tr")
  cells <- lapply(rows, xml2::xml_find_all, ".//td|.//th")

  # extract values from span parts and combine them again with parentheses
  replacement_rows <- lapply(
    X = 3:(tab_nrow + 2),
    FUN = function(xtab_row) {
      cell_values <- xml2::xml_find_all(
        cells[[xtab_row]],
        xpath = ".//span[contains(@class, 'td_n')]"
      )
      cell_addons <- xml2::xml_find_all(
        cells[[xtab_row]],
        xpath = paste0(
          ".//span[contains(@class, 'td_c') or ", # col / cell percentages
          "contains(@class, 'td_rw') or ", # row percentages
          "contains(@class, 'td_ex')]" # expected values
        )
      )

      if (length(cell_addons) == 0) {
        rvest::html_text(cell_values) %>%
          return()
      } else {
        paste0(
          rvest::html_text(cell_values),
          paste0(
            " (",
            rvest::html_text(cell_addons),
            ")"
          )
        )
      } %>%
        return()
    }
  ) %>%
    data.table::as.data.table() %>%
    data.table::transpose()

  colnames(replacement_rows) <- colnames(out_tab)[2:tab_ncol]

  cbind(
    out_tab[, 1],
    replacement_rows
  ) %>%
    return()
}
