<!-- badges: start -->
<!-- badges: end -->

# blockr.clinical.timelines

Blockr for [clinical timelines](https://github.com/devOpifex/clinical.timelines)

## Installation

``` r
# install.packages("remotes")
remotes::install_github("blockr-org/blockr.clinical.timelines")
```

## Example

``` r
library(blockr)
library(blockr.clinical.timelines)

stack <- blockr::new_stack(
  new_clinical_timeline_data_block,
  new_clinical_timeline_block
)

serve_stack(stack)
```

