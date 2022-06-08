# sjtable2df

<!-- badges begin -->
[![R build status](https://github.com/kapsner/sjtable2df/workflows/R CMD Check via {tic}/badge.svg?branch=main)](https://github.com/kapsner/sjtable2df/actions)
[![linting](https://github.com/kapsner/sjtable2df/workflows/lint/badge.svg?branch=main)](https://github.com/kapsner/sjtable2df/actions)
[![test-coverage](https://github.com/kapsner/sjtable2df/workflows/test-coverage/badge.svg?branch=main)](https://github.com/kapsner/sjtable2df/actions)
[![codecov](https://codecov.io/gh/kapsner/sjtable2df/branch/main/graph/badge.svg?branch=main)](https://app.codecov.io/gh/kapsner/sjtable2df)
<!-- badges end -->

The [`sjPlot`](https://CRAN.R-project.org/package=sjPlot) R package is a great package for visualizing results.

However, the tables created using the functions [`sjPlot::tab_model`](https://www.rdocumentation.org/packages/sjPlot/versions/2.8.4/topics/tab_model) or [`sjPlot::tab_xtab`](https://www.rdocumentation.org/packages/sjPlot/versions/2.8.4/topics/tab_xtab) return HTML tables and are not straightforward to use in R, especially when trying to integrate them into pdf- or word-documents using Rmarkdown.

The `sjtable2df` R package's goal is to overcome this and to provide an easy interface for converting `sjPlot`'s HTML tables to `data.frame`, `data.table`, or `kable` objects for further usage in R or Rmarkdown.

Currently, `sjtable2df` provides two functions to convert tables created from `sjPlot`'s functions [`tab_model`](https://www.rdocumentation.org/packages/sjPlot/versions/2.8.4/topics/tab_model) and [`tab_xtab`](https://www.rdocumentation.org/packages/sjPlot/versions/2.8.4/topics/tab_xtab): `sjtable2df::mtab2df` and `sjtable2df::xtab2df`.

## Install

The development version is available from Github:

```{r}
install.packages("remotes")
remotes::install_github("kapsner/sjtable2df")
```

## Example

Further details and examples are given in the package's [vignette](vignettes/Overview.Rmd)

``` r
library(sjtable2df)
set.seed(1)
dataset <- data.table::data.table(
  "var1" = sample(
    x = c("yes", "no"),
    size = 100,
    replace = TRUE,
    prob = c(.3, .7)
  ),
  "var2" = sample(
    x = c("yes", "no"),
    size = 100,
    replace = TRUE
  )
)

xtab <- sjPlot::tab_xtab(
  var.row = dataset$var1,
  var.col = dataset$var2,
  show.summary = TRUE,
  use.viewer = FALSE
)

sjtable2df::xtab2df(xtab = xtab, output = "data.table")
#>     var1 var2 no var2 yes                               Total
#> 1:    no      29       39                                  68
#> 2:   yes      18       14                                  32
#> 3: Total      47       53                                 100
#> 4:                        χ2=1.116 · df=1 · φ=0.127 · p=0.291

sjtable2df::xtab2df(xtab = xtab, output = "kable", format = "latex")
#> \begin{tabular}[t]{l|l|l|l}
#> \hline
#> var1 & var2 no & var2 yes & Total\\
#> \hline
#> no & 29 & 39 & 68\\
#> \hline
#> yes & 18 & 14 & 32\\
#> \hline
#> Total & 47 & 53 & 100\\
#> \hline
#> \multicolumn{4}{l}{\textsuperscript{} $χ2=1.116 · df=1 · φ=0.127 · p=0.291$}\\
#> \end{tabular}
```

