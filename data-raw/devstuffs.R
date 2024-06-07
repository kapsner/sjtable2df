# nolint start
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
my_desc$set_version("0.0.2.9004")
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
my_desc$set("VignetteBuilder" = "quarto")
# Quarto
my_desc$set("SystemRequirements" = paste0(
  "Quarto command line tools ",
  "(https://github.com/quarto-dev/quarto-cli).")
)

# Testthat stuff
my_desc$set("Config/testthat/parallel" = "false")
my_desc$set("Config/testthat/edition" = "3")
# Roxygen
my_desc$set("Roxygen" = "list(markdown = TRUE)")

# Save everyting
my_desc$write(file = "DESCRIPTION")

# License
usethis::use_gpl3_license()

# Depends
usethis::use_package("R", min_version = "3.6", type = "Depends")

# Imports
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-importing.html
usethis::use_package("data.table", type = "Imports")
usethis::use_package("kableExtra", type = "Imports")
usethis::use_package("magrittr", type = "Imports")
usethis::use_package("rvest", type = "Imports")
usethis::use_package("xml2", type = "Imports")
usethis::use_package("rlang", type = "Imports")
usethis::use_package("stats", type = "Imports")

# Suggests
usethis::use_package("testthat", type = "Suggests", min_version = "3.0.1")
usethis::use_package("lintr", type = "Suggests")
usethis::use_package("quarto", type = "Suggests")
usethis::use_package("mlbench", type = "Suggests")
usethis::use_package("sjPlot", type = "Suggests")
usethis::use_package("lme4", type = "Suggests")


# dev packages
# tag <- "master"
# devtools::install_github(repo = "r-lib/testthat", ref = tag, upgrade = "always")
# # https://cran.r-project.org/web/packages/devtools/vignettes/dependencies.html
# desc::desc_set_remotes(paste0("github::r-lib/testthat@", tag), file = usethis::proj_get())

usethis::use_build_ignore("cran-comments.md")
usethis::use_build_ignore(".lintr")
usethis::use_build_ignore("tic.R")
usethis::use_build_ignore(".github")
usethis::use_build_ignore("NEWS.md")
usethis::use_build_ignore("README.md")
usethis::use_build_ignore("README.qmd")
usethis::use_build_ignore("docs")
usethis::use_build_ignore("Meta")

usethis::use_git_ignore("!NEWS.md")
usethis::use_git_ignore("!README.md")
usethis::use_git_ignore("!README.qmd")
usethis::use_git_ignore("!vignettes/*.qmd")
usethis::use_git_ignore("docs")
usethis::use_git_ignore("Meta")

usethis::use_tidy_description()

quarto::quarto_render(input = "README.qmd")


# https://github.com/gitpython-developers/GitPython/issues/1016#issuecomment-1104114129
# system(
#  command = paste0("git config --global --add safe.directory ", getwd())
# )

# create NEWS.md using the python-package "auto-changelog" (must be installed)
# https://www.conventionalcommits.org/en/v1.0.0/
# build|ci|docs|feat|fix|perf|refactor|test
# system(
#   command = 'auto-changelog -u -t "sjtable2df NEWS" --tag-prefix "v" -o "NEWS.md"'
# )


# nolint end
an <- autonewsmd::autonewsmd$new(repo_name = packagename)
an$generate()
an$write(force = TRUE)
