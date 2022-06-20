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

xtab_colnames <- function(tab) {
  stopifnot(inherits(tab, "data.table"))

  last_var_col <- ncol(tab) - 1

  # add levels to colnames of 'cardio variable'
  colnames(tab)[2:last_var_col] <-
    tab[1, c(2:last_var_col), with = FALSE] %>%
    as.character() %>%
    paste(colnames(tab)[2], .)
  return(tab[-1, ])
}
