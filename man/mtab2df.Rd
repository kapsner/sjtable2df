% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mtab2df.R
\name{mtab2df}
\alias{mtab2df}
\title{mtab2df}
\usage{
mtab2df(mtab, n_models, output = "data.table", ...)
}
\arguments{
\item{mtab}{A model table, created with `sjPlot::tab_model`.}

\item{n_models}{An integer, specifiying the number of models in the table.}

\item{output}{A character vector. Allowed values are: "data.table" (default),
"data.frame" or "kable". The function's return value is of the respective
type.}

\item{...}{Further arguments to be passed to `kableExtra::kbl`.}
}
\value{
The table is returned as an R object of the type specified with
  the `output` argument.
}
\description{
Convert table from `sjPlot::tab_model` to R data.frame or
  `knitr::kable`
}
\examples{
\donttest{
set.seed(1)
dataset <- data.table::data.table(
  "var1" = factor(sample(
    x = c("yes", "no"),
    size = 100,
    replace = TRUE,
    prob = c(.3, .7)
  )),
  "var2" = factor(sample(
    x = c("yes", "no"),
    size = 100,
    replace = TRUE
  )),
  "var3" = rnorm(100)
)

# models
m0 <- stats::glm(
  var1 ~ 1,
  data = dataset,
  family = binomial(link = "logit")
)
m1 <- stats::glm(
  var1 ~ var2,
  data = dataset,
  family = binomial(link = "logit")
)
m2 <- stats::glm(
  var1 ~ var2 + var3,
  data = dataset,
  family = binomial(link = "logit")
)

m_table <- sjPlot::tab_model(m0, m1, m2, show.aic = TRUE)

final_tab <- sjtable2df::mtab2df(mtab = m_table, n_models = 3)
}
}
