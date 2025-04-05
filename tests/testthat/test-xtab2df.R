test_that(
  desc = "correct functioning of 2x2 xtab2df, with stats",
  code = {

    local_edition(3)
    local_reproducible_output(rstudio = TRUE)

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

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )


    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "data.frame")

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "kable")

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))

    # with more statistics: cell.prc
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      show.cell.prc = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 4)

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )


    # with more statistics: col.prc
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      show.col.prc = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 4)

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )


    # with more statistics: row.prc
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      show.row.prc = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 4)

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )


    # with more statistics: show.exp
    xtab <- sjPlot::tab_xtab(
      var.row = dataset$var1,
      var.col = dataset$var2,
      show.summary = TRUE,
      show.exp = TRUE,
      use.viewer = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab)

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.table"))
    expect_true(nrow(final_tab) == 4)

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )
  }
)



test_that(
  desc = "correct functioning of 2x2 xtab2df, without stats",
  code = {

    local_edition(3)
    local_reproducible_output(rstudio = TRUE)

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

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )
  }
)



test_that(
  desc = "correct functioning of 3x4 xtab2df, with stats",
  code = {

    local_edition(3)
    local_reproducible_output(rstudio = TRUE)

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

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )


    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "data.frame")

    expect_type(final_tab, "list")
    expect_true(inherits(final_tab, "data.frame"))

    expect_snapshot(
      x = final_tab,
      cran = FALSE,
      error = FALSE
    )

    final_tab <- sjtable2df::xtab2df(xtab = xtab, output = "kable")

    expect_type(final_tab, "character")
    expect_true(inherits(final_tab, "knitr_kable"))
  }
)
