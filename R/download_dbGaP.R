#' @keywords internal
#'
#' @importFrom magrittr %>%
download_dbGaP <- function(dbGaP_repository_key) {
  system.file("extdata/cart_DAR85767_202008131315.krt",
              package = "testtest") %>%
    paste("prefetch","--cart", ., "--ngc", dbGaP_repository_key,
          "--output-directory",paths$dbGaP_directory) %>%
    system()
  
  paste("vdb-decrypt", paths$dbGaP_directory, "--ngc", dbGaP_repository_key) %>%
    system()
}

