context("test mtab2df")


test_that(
  desc = "correct functioning of mtab2df",
  code = {

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


    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 3,
      output = "data.frame"
    )

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    final_tab <- sjtable2df::mtab2df(
      mtab = m_table,
      n_models = 3,
      output = "kable"
    )

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))
  }
)
