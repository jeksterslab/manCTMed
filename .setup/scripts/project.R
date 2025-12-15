#' Define project related objects here.
#'
#' | Object Name      | Description                                         |
#' |:-----------------|:----------------------------------------------------|
#' | `project`        | Project name.                                       |
#' | `pkg_cran`       | CRAN packages to install on top of                  |
#' |                  | package dependencies in `DESCRIPTION`.              |
#' | `pkg_github`     | GitHub packages to install.                         |
#' | `pkg_github_ref` | GitHub branch corresponding to packages             |
#' |                  | in `pkg_github`. `if (length(pkg_github_ref) == 0)` |
#' |                  | use the `HEAD` branch.                              |
#' | `pkg_ver`        | Packages with specific version.                     |
#' | `ver`            | Version corresponding to packages in `pkg_ver`.     |
#' | `ignore`         | Items to add to `.Rbuildignore`.                    |
#' | `license`        | Options are `"mit"`, `"gpl3"`, or `NULL`            |
#'

project <- "manCTMed"

rproject_ver <- NULL

# installed using the container
# "dynr"

pkg_cran <- c(
  "DT",
  "OpenMx"
)

# pkg_github <- c(
#   "jeksterslab/simStateSpace",
#   "jeksterslab/bootStateSpace",
#   "jeksterslab/dynUtils",
#   "jeksterslab/cTMed"
# )

pkg_github <- c(
  "jeksterslab/dynUtils@dc3f47b"
)

pkg_github_ref <- c()

pkg_ver <- c(
  "simStateSpace",
  "bootStateSpace",
  "cTMed"
)

ver <- c(
  "1.2.9",
  "1.0.2",
  "1.0.6"
)

pkg_bioconductor <- c()

ignore <- "^vignettes$"

license <- "mit"

git_user <- "jeksterslab"
git_email <- "learn.jeksterslab@gmail.com"
r_email <- "r.jeksterslab@gmail.com"
