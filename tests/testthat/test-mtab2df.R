test_that(
  desc = "correct functioning of mtab2df: glm",
  code = {

    local_edition(3)

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

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 6)

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )


    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 3,
      output = "data.frame"
    )

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 3,
      output = "kable"
    )

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )
  }
)

test_that(
  desc = "correct functioning of mtab2df: glmer",
  code = {

    local_edition(3)

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
      "var3" = rnorm(100),
      "var4" = c(rep(1, 25), rep(2, 25), rep(3, 25), rep(4, 25))
    )

    # models
    m1 <- lme4::glmer(
      var1 ~ var2 + (1 | var4),
      data = dataset,
      family = binomial(link = "logit")
    )
    m2 <- lme4::glmer(
      var1 ~ var2 + var3 + (1 | var4),
      data = dataset,
      family = binomial(link = "logit")
    )

    m_table <- sjPlot::tab_model(m1, m2, show.aic = TRUE)

    final_tab <- sjtable2df::mtab2df(mtab = m_table, n_models = 2)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 10)

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )


    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 2,
      output = "data.frame"
    )

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )

    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 2,
      output = "kable"
    )

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))

    expect_snapshot_value(
      x = final_tab,
      style = "json2",
      cran = FALSE,
      tolerance = 10e-1,
      ignore_function_env = TRUE
    )


  }
)

test_that(
  desc = "correct functioning of mtab2df with significance: glm",
  code = {

    local_edition(3)

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

    m_table <- sjPlot::tab_model(m0, m1, m2,
                                 show.aic = TRUE,
                                 p.style = "numeric_star")

    final_tab <- sjtable2df::mtab2df(mtab = m_table, n_models = 3)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 7)

    empty_other_cols <- vapply(
      X = final_tab[nrow(final_tab), 2:ncol(final_tab)],
      FUN = function(x) {
        # has column >1 empty string?
        "" == x
      },
      FUN.VALUE = logical(1)
    )

    expect_true(sum(empty_other_cols) == ncol(final_tab) - 1)
  }
)
