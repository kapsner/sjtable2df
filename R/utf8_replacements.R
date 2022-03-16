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


utf_replacement_list <- list(
  "\u03c400" = "$\u03c4_{00}$",
  "Marginal R2 / Conditional R2" = "Marginal $R^2$ / Conditional $R^2$",
  "\u03c32" = "$\u03c3^2$",
  "R2 Tjur" = "$R^2$ Tjur",
  "R2 / R2 adjusted" = "$R^2$ / $R^2$ adjusted"
)

utf_replacements <- function(vec, kable_mtab = FALSE) {
  for (item in names(utf_replacement_list)) {
    row <- which(grepl(item, vec))
    if (length(row) > 0) {
      vec[row] <- utf_replacement_list[[item]]
    }
  }
  return(vec)
}
