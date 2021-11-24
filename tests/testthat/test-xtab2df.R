context("test xtab2df")


test_that(
  desc = "correct functioning of 2x2 xtab2df, with stats",
  code = {

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

    # with statistics
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 4)


    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "data.frame")

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "kable")

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))
  }
)



test_that(
  desc = "correct functioning of 2x2 xtab2df, without stats",
  code = {

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

    # without statistics
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = FALSE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 3)
  }
)



test_that(
  desc = "correct functioning of 3x4 xtab2df, with stats",
  code = {

    set.seed(1)
    dataset <- data.table::data.table(
      "var1" = sample(
        x = c("yes", "no", "maybe"),
        size = 100,
        replace = TRUE,
        prob = c(.3, .4, .3)
      ),
      "var2" = sample(
        x = c("yes", "no", "maybe", "maybe not"),
        size = 100,
        replace = TRUE
      )
    )

    # with statistics
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 5)


    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "data.frame")

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "kable")

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))
  }
)