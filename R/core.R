new_clinical_timeline_block <- function(data, ...) {
  all_cols <- function(data) colnames(data)
  usubjid_col <- function(data) {
    cols <- colnames(data)

    if("USUBJID" %in% cols)
      return("USUBJID")

    if("SUBJID" %in% cols) 
      return("SUBJID")

    cols[1]
  }
  
  event_col <- function(data) {
    cols <- colnames(data)

    if("DOMAIN" %in% cols) 
      return("DOMAIN")

    cols[1]
  }

  stdt_col <- function(data) {
    cols <- colnames(data)

    if("STDT" %in% cols) 
      return("STDT")

    if("STDTC" %in% cols) 
      return("STDTC")

    cols[1]
  }

  endt_col <- function(data) {
    cols <- colnames(data)

    if("ENDT" %in% cols) 
      return("ENDT")

    if("ENDTC" %in% cols) 
      return("ENDTC")

    cols[1]
  }

  all_cols_none <- function(data) c("None", colnames(data))

  fields <- list(
    event_col = blockr::new_select_field(
      event_col,
      choices = all_cols,
      title = "Event type"
    ),
    id_col = blockr::new_select_field(
      usubjid_col,
      choices = all_cols,
      title = "Subjects"
    ),
    stdt_col = blockr::new_select_field(
      stdt_col,
      choices = all_cols,
      title = "Start date"
    ),
    endt_col = blockr::new_select_field(
      endt_col,
      choices = all_cols,
      title = "End date"
    )
  )

  new_block(
    fields = fields,
    expr = quote({
      x <- clinical.timelines::clinical_timeline(
        data
      )

      args <- list(
        timeline = x,
        id_col = .(id_col),
        event_col = .(event_col),
        stdt_col = .(stdt_col),
        endt_col = .(endt_col)
      )

      do.call(
        clinical.timelines::clinical_settings,
        args
      )
    }),
    ...,
    class = c("clinical_timeline_block", "plot_block")
  )
}

#' Clinical timeline block
#' 
#' Clinical timeline block
#' 
#' @param data Dataset.
#' @param ... Ignored.
#' 
#' @import blockr
#' @export
clinical_timeline_block <- function(data, ...){
  blockr::initialize_block(new_clinical_timeline_block(data, ...), data)
}

#' @method server_output clinical_timeline_block
#' @export
server_output.clinical_timeline_block <- function (x, result, output) {
  clinical.timelines::renderClinical_timeline(result())
}

#' @method uiOutputBlock clinical_timeline_block
#' @export
uiOutputBlock.clinical_timeline_block <- function (x, ns) {
  shiny::div(
    style = "overflow-y:auto",
    clinical.timelines::clinical_timelineOutput(ns("res"), height = "70vh")
  )
}

#' @method evaluate_block clinical_timeline_block
#' @export
evaluate_block.clinical_timeline_block <- function (x, data, ...) {
  stopifnot(...length() == 0L)
  eval(substitute(data %>% expr, list(expr = blockr::generate_code(x))), 
      list(data = data))
}

#' @method generate_server clinical_timeline_block
#' @export
generate_server.clinical_timeline_block <- function (...) {
  blockr:::generate_server_block(...)
}
