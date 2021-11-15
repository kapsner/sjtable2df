packagename <- "sjtable2df"

# remove existing description object
unlink("DESCRIPTION")
# Create a new description object
my_desc <- desc::description$new("!new")
# Set your package name
my_desc$set("Package", packagename)
#Set your name
my_desc$set_authors(c(
  person(
    given = "Lorenz A.",
    family = "Kapsner",
    email = "lorenz.kapsner@gmail.com",
    role = c('cre', 'aut', 'cph'),
    comment = c(ORCID = "0000-0003-1866-860X")
  )))
# Remove some author fields
my_desc$del("Maintainer")
# Set the version
my_desc$set_version("0.0.1")
# The title of your package
my_desc$set(Title = "Convert 'sjPlot' HTML-Tables to R 'data.frame'")
# The description of your package
my_desc$set(Description = paste0(
  "A small set of helper functions to convert 'sjPlot' HTML-tables to ",
  "R data.frame objects / knitr::kable-tables."
))
# The description of your package
my_desc$set("Date/Publication" = paste(as.character(Sys.time()), "UTC"))
# The urls
my_desc$set("URL", "https://github.com/kapsner/sjtable2df")
my_desc$set("BugReports",
            "https://github.com/kapsner/sjtable2df/issues")

# Vignette Builder
my_desc$set("VignetteBuilder" = "knitr")

# License
my_desc$set("License", "GPL-3")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# License
usethis::use_gpl3_license()

# Depends
usethis::use_package("R", min_version = "2.10", type="Depends")

# Imports
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-importing.html
usethis::use_package("data.table", type="Imports")
usethis::use_package("kableExtra", type="Imports")
usethis::use_package("magrittr", type="Imports")
usethis::use_package("rvest", type="Imports")
#usethis::use_package("utils", type="Imports")

# Suggests
usethis::use_package("testthat", type = "Suggests", min_version = "3.0.1")
usethis::use_package("lintr", type = "Suggests")
usethis::use_package("knitr", type = "Suggests")
usethis::use_package("rmarkdown", type = "Suggests")
usethis::use_package("mlbench", type = "Suggests")
usethis::use_package("sjPlot", type = "Suggests")


# dev packages
# tag <- "master"
# devtools::install_github(repo = "r-lib/testthat", ref = tag, upgrade = "always")
# # https://cran.r-project.org/web/packages/devtools/vignettes/dependencies.html
# desc::desc_set_remotes(paste0("github::r-lib/testthat@", tag), file = usethis::proj_get())


# gitignore
usethis::use_git_ignore("/*")
usethis::use_git_ignore("/*/*")
usethis::use_git_ignore("*.log")
usethis::use_git_ignore("!/.gitignore")
usethis::use_git_ignore("!/.Rbuildignore")
usethis::use_git_ignore("!/data-raw/")
usethis::use_git_ignore("/data-raw/*")
usethis::use_git_ignore("!/data-raw/devstuffs.R")
usethis::use_git_ignore("!/DESCRIPTION")
usethis::use_git_ignore("!/LICENSE.md")
usethis::use_git_ignore("!/cran-comments.md")
usethis::use_git_ignore("!/man/")
usethis::use_git_ignore("!NAMESPACE")
usethis::use_git_ignore("!/R/")
usethis::use_git_ignore("!/README.md")
usethis::use_git_ignore("!/vignettes/")
usethis::use_git_ignore("!/tests/")
usethis::use_git_ignore("/tests/*")
usethis::use_git_ignore("!/tests/testthat/")
usethis::use_git_ignore("/tests/testthat/*")
usethis::use_git_ignore("!/tests/testthat/test-*.R")
usethis::use_git_ignore("!/tests/testthat.R")
usethis::use_git_ignore("/tests/testthat/testdata/")
usethis::use_git_ignore("/.Rhistory")
usethis::use_git_ignore("!/*.Rproj")
usethis::use_git_ignore("/.Rproj*")
usethis::use_git_ignore("/.RData")
usethis::use_git_ignore("/.vscode")
usethis::use_git_ignore("!/.lintr")
usethis::use_git_ignore("!/.github/")
usethis::use_git_ignore("!/tic.R")

usethis::use_build_ignore("cran-comments.md")
usethis::use_build_ignore(".lintr")
usethis::use_build_ignore("tic.R")
usethis::use_build_ignore(".github")

usethis::use_tidy_description()
