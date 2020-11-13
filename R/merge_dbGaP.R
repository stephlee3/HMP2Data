#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr distinct
#' @importFrom dplyr ungroup
#' @importFrom dplyr full_join
#' @importFrom dplyr inner_join
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom tidyr fill
#' @importFrom tidyr spread
#' @import phyloseq

merge_dbGap = function(phyloseq_obj, dbGaP_directory){
  sample_integration = read_dbGaP_sample(dbGaP_directory)
  visit_info = read_dbGaP_visit(dbGaP_directory)
  open_access_metadata = data.frame(phyloseq_obj@sam_data)
  
  #visit_info_fill =
  #  visit_info %>%
  #  group_by(visit_ID) %>%
  #  fill(colnames(visit_info),.direction = "downup") %>%
  #  distinct() %>%
  #  ungroup()
  
  
  visit_info_wide =
    visit_info %>%
    mutate(exist = "yes") %>%
    spread(survey_ID,exist) %>%
    select(-"<NA>") %>%
    group_by(visit_ID) %>%
    fill(colnames(.),.direction = "downup") %>%
    distinct() %>%
    ungroup()
  
  ## manually remove inconsistent records
  ## EP004835_k10
  row_idx = which(visit_info_wide$visit_ID == "EP004835_K10")
  visit_info_wide$vdischarge[row_idx] = NA
  
  ## mom_divery_method = C_section
  row_idx = which(visit_info_wide$visit_ID == "EP013002_K40")
  visit_info_wide$mom_delivery_method[row_idx] = "C_section"
  
  ## EP075340_K10
  row_idx = which(visit_info_wide$visit_ID == "EP075340_K10")
  visit_info_wide$mom_delivery_method[row_idx] = "C_section"
  
  ## EP081373_K20
  row_idx = which(visit_info_wide$visit_ID == "EP081373_K20")
  visit_info_wide$diet_gluten_free[row_idx] = NA
  
  ## EP256139_K10
  row_idx = which(visit_info_wide$visit_ID == "EP256139_K10")
  visit_info_wide$mom_delivery_method[row_idx] = "C_section"
  visit_info_wide$vdischarge[row_idx] = NA
  
  visit_info_wide = distinct(visit_info_wide)
  
  complete_metadata =
    sample_integration %>%
    full_join(visit_info_wide)
  
  complete_hmpdacc_metadata =
      open_access_metadata %>%
      inner_join(complete_metadata, by = c("file_name"="SAMPLE_ID"))
  rownames(complete_hmpdacc_metadata) = complete_hmpdacc_metadata$file_name
  
  complete_phyloseq_obj = 
    phyloseq(otu_table(phyloseq_obj@otu_table, taxa_are_rows = TRUE),
             sample_data(complete_hmpdacc_metadata),
             tax_table(phyloseq_obj@tax_table))
  
  return(complete_phyloseq_obj)
}



