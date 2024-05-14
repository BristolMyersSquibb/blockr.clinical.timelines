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
library(shiny)
library(blockr)
library(blockr.clinical.timelines)

stack <- blockr::new_stack(
  clinical_timeline_data_block,
  clinical_timeline_block
)

ui <- fluidPage(
  theme = bslib::bs_theme(5L),
  generate_ui(stack)
)

server <- function(input, output, session) {
  generate_server(stack)
}

shinyApp(ui, server)
```

