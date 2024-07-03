#' Clinical Timeline Data Block
#'
#' This data block is used to create a clinical timeline data frame from the ADaM data sets.
#'
#' @param ... Ignored.
#'
#' @export
new_clinical_timeline_data_block <- function(...) {
  blockr::new_block(
    fields = list(),
    expr = quote({
      build <- function(adex = pharmaverseadam::adex,
                        adcm = pharmaverseadam::adcm,
                        adae = pharmaverseadam::adae) {
        cm <- adcm |>
          dplyr::select(SUBJID, SITEID, CMSTDY, CMENDY, CMSTDTC, CMENDTC, CMDECOD, CMSEQ) |>
          dplyr::rename(STDY = CMSTDY, ENDY = CMENDY, STDTC = CMSTDTC, ENDTC = CMENDTC, SEQ = CMSEQ, DECOD = CMDECOD) |>
          dplyr::mutate(DOMAIN = "Concomitant Medications")

        ae <- adae |>
          dplyr::select(SUBJID, SITEID, AESTDY, AEENDY, AESTDTC, AEENDTC, AEDECOD, AESEQ) |>
          dplyr::rename(STDY = AESTDY, ENDY = AEENDY, STDTC = AESTDTC, ENDTC = AEENDTC, SEQ = AESEQ, DECOD = AEDECOD) |>
          dplyr::mutate(DOMAIN = "Adverse Events")

        ex <- adex |>
          dplyr::select(SUBJID, SITEID, EXSTDY, EXENDY, EXSTDTC, EXENDTC, EXDOSE, EXDOSU, EXDOSFRQ, EXSEQ) |>
          dplyr::mutate(DOMAIN = "Exposure", EXDECOD = paste(EXDOSE, EXDOSU, EXDOSFRQ)) |>
          dplyr::rename(STDY = EXSTDY, ENDY = EXENDY, STDTC = EXSTDTC, ENDTC = EXENDTC, SEQ = EXSEQ, DECOD = EXDECOD)

        dplyr::bind_rows(ex, ae, cm) |>
          dplyr::select(DOMAIN, SITEID, SUBJID, SEQ, STDY, ENDY, STDTC, ENDTC, DECOD) |>
          dplyr::arrange(DOMAIN, SUBJID, SEQ, STDY) |>
          dplyr::filter(!is.na(STDY), !is.na(ENDY))
      }

      build()
    }),
    ...,
    class = c("clinical_timeline_data_block", "data_block")
  )
}
