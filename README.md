# E.PATH
<!-- badges: start -->
[![R-CMD-check](https://github.com/AhmedMehdiLab/E.PATH/workflows/R-CMD-check/badge.svg)](https://github.com/AhmedMehdiLab/E.PATH/actions)
<!-- badges: end -->

Environmental Pathways Database

## Installation
To install this package, run:

``` r
# install.packages("remotes")
remotes::install_github("AhmedMehdiLab/E.PATH")
```

## Usage
This package contains two data files:

`E.PATH::annotations` is a `tibble` which maps gene set names to annotations and
sources.

`E.PATH::database` is a `list` containing `gs_genes` and `gs_info`.
* `gs_genes` is a `list` mapping gene set names to individual genes.
* `gs_info` is a `tibble` containing information on gene sets. It is included 
for compatibility with other packages, and does not contain any information.
