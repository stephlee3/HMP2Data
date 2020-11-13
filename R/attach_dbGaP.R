#' Attach dbGaP metadata to a Phyloseq object
#'
#' The National Center for Biotechnology Information (NCBI) database of
#' Genotypes and Phenotypes (dbGaP) has extensive metadata pretaining to the HMP
#' study. Access to this metadata is controlled and its use requires
#' authorization by the appropriate Data Access Committee – further information
#' is available \href{https://tinyurl.com/yb7okvga}{here}. Those with
#' authorization will be able to download a dbGaP repository key and can use it
#' to attach the controlled-access metadata to a
#' \code{\link[phyloseq]{phyloseq}} object with a
#' single command, provided the NCBI SRA Toolkit is installed and on the user's
#' \code{PATH}. See note below for further information.
#'
#'
#' @param phyloseq_obj A \code{\link[phyloseq]{phyloseq}}
#' object from the \code{\link{phyloseq}} package
#' @param dbGaP_repository_key A repository key downloaded from dbGaP; only
#' required for the initial download and not needed thereafter
#' 
#'
#' @return A \code{\link[phyloseq]{phyloseq}}
#' object with protected metadata from dbGaP attached
#' @export
#'
#' @note
#' The NCBI SRA Toolkit is called internally and must be on the user's
#' \code{PATH} or an error message will be displayed. The NCBI SRA Toolkit can
#' readily be installed on multiple platforms following
#' \href{https://tinyurl.com/y894uvvf}{these} instructions.
#' 
#' This attach_dbGaP function is constructed based on the same function from \href{https://github.com/waldronlab/HMP16SData}{HMP16SData} package.
#'
#' @examples
#' \dontrun{
#' momspi16S_phyloseq = momspi16S()
#' momspi16S_phyloseq_restricted <-
#'   attach_dbGaP(phyloseq_obj = momspi16S_phyloseq,
#'   dbGaP_repository_key = "/path/to/prj_12345.ngc")
#' }
#'
#' @importFrom magrittr %>%
#' @importFrom stringr str_remove
#' @importFrom stringr str_replace
#' @importFrom assertthat assert_that
#' @importFrom assertthat has_extension
#' @importFrom assertthat is.readable
#' @importFrom SummarizedExperiment colData<-
attach_dbGaP <- function(phyloseq_obj, dbGaP_repository_key = "") {
  dbGaP_directory <- paste0("dbGaP-",gsub(".*prj_(.+).ngc", "\\1", dbGaP_repository_key))
  
  if (!dir.exists(dbGaP_directory)) {
    dir.create(dbGaP_directory)
    assert_that(has_extension(dbGaP_repository_key, "ngc"))
    assert_that(is.readable(dbGaP_repository_key))
    
    Sys.which("vdb-config") %>%
      nchar() %>%
      if (. == 0) {
        stop("Ensure NCBI SRA Toolkit is installed and on your PATH.\n",
             "       See https://tinyurl.com/y894uvvf for help.\n",
             "       Check with Sys.getenv(\"PATH\")",
             call. = FALSE)
      }
    message("\nDownloading the dbGaP data...\n")
    download_dbGaP(dbGaP_repository_key, dbGaP_directory)
  }
  
  if(!check_download_status(dbGaP_directory)){
    message("\nIncomplete downloading due to connection issues with NCBI. Try to re-download the data...")
    download_dbGaP(dbGaP_repository_key, dbGaP_directory)
  }
  if (check_download_status(dbGaP_directory))
    message("\nSuccessfully downloading and decrypting all the dbGaP data...")
    

  message("\nMerging the dbGaP data...")
  complete_phyloseq = merge_dbGap(phyloseq_obj, dbGaP_directory)
  return(complete_phyloseq)
}
