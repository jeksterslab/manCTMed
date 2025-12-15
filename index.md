# manCTMed

Ivan Jacob Agaloos Pesigan 2025-12-15

## Description

Research compendium for the manuscript Pesigan, I. J. A., Russell, M.
A., & Chow, S.-M. (2025). Inferences and Effect Sizes for Direct,
Indirect, and Total Effects in Continuous-Time Mediation Models.
*Psychological Methods*. <https://doi.org/10.1037/met0000779>

## Acknowledgments

This research was made possible by the Prevention and Methodology
Training Program (PAMT) funded by a T32 training grant (T32 DA017629
Multiple Principal Investigators: Jennifer Maggs & Stephanie Lanza) from
the National Institute on Drug Abuse (NIDA), the National Institutes of
Health Intensive Longitudinal Health Behavior Cooperative Agreement
Program (U24AA027684), National Science Foundation (Grant DUE-2417294),
the National Center for Advancing Translational Sciences
(UL1TR002014-06), and the National Institute of Diabetes, Digestive &
Kidney Diseases (U01DK135126).

Computations for this research were performed on the Pennsylvania State
University’s Institute for Computational and Data Sciences’ Roar
supercomputer using SLURM for job scheduling (Yoo et al., 2003), GNU
Parallel to run the simulations in parallel (Tange, 2021), and Apptainer
to ensure a reproducible software stack (Kurtzer et al., 2017, 2021).
See `.sim/README.md` and the scripts in the `.sim` folder in the
[GitHub](https://github.com/jeksterslab/manCTMed) repository for more
details on how the simulations were performed.

## Installation

You can install `manCTMed` from
[GitHub](https://github.com/jeksterslab/manCTMed) with:

``` r

if (!require("remotes")) install.packages("remotes")
remotes::install_github("jeksterslab/manCTMed")
```

See
[Containers](https://jeksterslab.github.io/manCTMed/articles/containers.html)
for containerized versions of the package.

## Author-Accepted Manuscript

See
<https://github.com/jeksterslab/manCTMed/blob/main/.setup/latex/manCTMed-manuscript.Rtex>
for the latex file of the manuscript. See
<https://github.com/jeksterslab/manCTMed/blob/latex/manCTMed-manuscript.pdf>
for the compiled PDF.

## R Package

Effect sizes, standard errors and confidence intervals for the direct,
indirect, and total effects for continuous-time mediation models as well
as visualization tools are available in the `cTMed` package available on
the Comprehensive R Archive Network (CRAN)
(<https://CRAN.R-project.org/package=cTMed>). Documentation and examples
can be found in the accompanying website
(<https://jeksterslab.github.io/cTMed>).

## More Information

See [GitHub Pages](https://jeksterslab.github.io/manCTMed/index.html)
for package documentation.
