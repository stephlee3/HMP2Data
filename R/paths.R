#' @keywords internal
paths <- new.env()

paths$dbGaP_directory <-
  "download_dbGaP"

paths$MOMS_PI_Subject_file <-
  "phs001523.v1.pht007508.v1.p1.MOMS_PI_Subject.MULTI.txt.gz"

paths$MOMS_PI_Sample_file <-
  "phs001523.v1.pht007509.v1.p1.MOMS_PI_Sample.MULTI.txt.gz"

paths$MOMS_PI_Clinical_file <-
  "phs001523.v1.pht007510.v1.p1.c1.phenotype_clinical.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_Review_Of_System_file <-
  "phs001523.v1.pht007511.v1.p1.c1.phenotype_reviewOfSystemsSurvey.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_Health_History_file <-
  "phs001523.v1.pht007512.v1.p1.c1.phenotype_healthHistorySurvey.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_Follow_Up_file <-
  "phs001523.v1.pht007513.v1.p1.c1.phenotype_followUpSurvey.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_Delivery_And_Discharge_file <-
  "phs001523.v1.pht007514.v1.p1.c1.phenotype_deliveryAndDischargeSurvey.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_Sample_Attributes_file <-
  "phs001523.v1.pht007515.v1.p1.c1.MOMS_PI_Sample_Attributes.DS-PREG-COM-IRB-PUB-MDS.txt.gz"

paths$MOMS_PI_SRA_file <-
  "phs001523.v1.pht008454.v1.p1.MOMS_PI_SRA.MULTI.txt.gz"


# Subject
paths$MOMS_PI_Subject_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Subject_file)

# Sample
paths$MOMS_PI_Sample_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Sample_file)

# Clinical
paths$MOMS_PI_Clinical_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Clinical_file)

# Review of System
paths$MOMS_PI_Review_Of_System_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Review_Of_System_file)

# Health History
paths$MOMS_PI_Health_History_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Health_History_file)

# Follow-Up
paths$MOMS_PI_Follow_Up_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Follow_Up_file)

# Delivery and Discharge
paths$MOMS_PI_Delivery_And_Discharge_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Delivery_And_Discharge_file)

# Sample Attributes
paths$MOMS_PI_Sample_Attributes_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_Sample_Attributes_file)

# SRA
paths$MOMS_PI_SRA_file_path <-
  file.path(paths$dbGaP_directory, paths$MOMS_PI_SRA_file)

