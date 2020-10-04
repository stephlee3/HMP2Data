#' @keywords internal
#' 
#' @importFrom magrittr %>%

check_download_status <- function() {
  dbGaP_dir_files = list.files(paths$dbGaP_directory)
  required_files = c(paths$MOMS_PI_Subject_file,
    paths$MOMS_PI_Sample_file,
    paths$MOMS_PI_Clinical_file,
    paths$MOMS_PI_Review_Of_System_file,
    paths$MOMS_PI_Health_History_file,
    paths$MOMS_PI_Follow_Up_file,
    paths$MOMS_PI_Delivery_And_Discharge_file,
    paths$MOMS_PI_Sample_Attributes_file,
    paths$MOMS_PI_SRA_file)
  return(all(required_files %in% dbGaP_dir_files))
}
