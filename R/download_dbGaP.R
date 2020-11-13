#' @keywords internal
#'
#' @importFrom magrittr %>%
download_dbGaP <- function(dbGaP_repository_key, dbGaP_directory) {
  system.file("extdata/cart_DAR85767_202008131315.krt",
              package = "HMP2Data") %>%
    paste("prefetch","--cart", ., "--ngc", dbGaP_repository_key,
          "--output-directory",dbGaP_directory) %>%
    system()
  
  paste("vdb-decrypt", dbGaP_directory, "--ngc", dbGaP_repository_key) %>%
    system()
 
}
