.onLoad <- \(...){
  blockr::register_block(
    clinical_timeline_block,
    "Clinical timeline",
    "Visualise events over time",
    input = "data.frame",
    output = "clinical_timeline",
    package = "blockr.clinical.timelines",
    classes = c("clinical_timeline_block", "plot_block")
  )

  blockr::register_block(
    clinical_timeline_data_block,
    "Clinical timeline data",
    "Prepare data for clinical timeline visualisation",
    input = NA_character_,
    output = "data.frame",
    package = "blockr.clinical.timelines",
    classes = c("clinical_timeline_data_block", "data_block")
  )
}
