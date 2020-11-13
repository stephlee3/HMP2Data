#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr rename
#' @importFrom readr read_tsv
#' @importFrom dplyr full_join

quiet_read <- function(x) {
  cols(.default = "?") %>%
    read_tsv(x, col_types = ., skip = 10)
}


quiet_join <- function(x, y) {
  list(x, y) %>%
    lapply(colnames) %>%
    Reduce(intersect, x = .) %>%
    full_join(x, y, by = .)
}

read_dbGaP_sample <- function(dbGaP_directory) {
  paths = create_paths(dbGaP_directory)
  list(#paths$MOMS_PI_Subject_file_path,
    paths$MOMS_PI_Sample_file_path,
    #paths$MOMS_PI_Clinical_file_path,
    #paths$MOMS_PI_Review_Of_System_file_path,
    #paths$MOMS_PI_Health_History_file_path,
    #paths$MOMS_PI_Follow_Up_file_path,
    #paths$MOMS_PI_Delivery_And_Discharge_file_path,
    paths$MOMS_PI_Sample_Attributes_file_path,
    paths$MOMS_PI_SRA_file_path
  ) %>%
    lapply(quiet_read) %>%
    Reduce(quiet_join, x = .) %>%
    dplyr::rename(BioSample_Accession = `BioSample Accession`)
}

read_dbGaP_visit <- function(dbGaP_directory) {
  paths = create_paths(dbGaP_directory)
  list(paths$MOMS_PI_Subject_file_path,
       #paths$MOMS_PI_Sample_file_path,
       paths$MOMS_PI_Clinical_file_path,
       paths$MOMS_PI_Review_Of_System_file_path,
       paths$MOMS_PI_Health_History_file_path,
       paths$MOMS_PI_Follow_Up_file_path,
       paths$MOMS_PI_Delivery_And_Discharge_file_path
       #paths$MOMS_PI_Sample_Attributes_file_path,
       #paths$MOMS_PI_SRA_file_path
  ) %>%
    lapply(quiet_read) %>%
    Reduce(quiet_join, x = .)
}
