## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(EDIutils)

## ----eval=FALSE---------------------------------------------------------------
# # Interactively at the console
# login()
# #> User name: "my_name"
# #> User password: "my_secret"
# 
# # Programmatically with function arguments
# login(userId = "my_name", userPass = "my_secret")
# 
# # Programmatically with a file containing userId and userPass arguments
# login(config = paste0(tempdir(), "/config.txt"))

## ----eval=FALSE---------------------------------------------------------------
# # Create reservation
# identifier <- create_reservation(scope = "edi", env = "staging")
# identifier
# #> [1] 595

## ----eval=FALSE---------------------------------------------------------------
# 
# # Evaluate data package
# transaction <- evaluate_data_package(
#  eml = paste0(tempdir(), "/edi.595.1.xml"),
#  env = "staging")
# transaction
# #> [1] "evaluate_163966785813042760"
# 
# # Check status
# status <- check_status_evaluate(transaction, env = "staging")
# status
# #> [1] TRUE

## ----eval=FALSE---------------------------------------------------------------
# # Summarize report
# read_evaluate_report_summary(transaction, env = "staging")
# #> ===================================================
# #>   EVALUATION REPORT
# #> ===================================================
# #>
# #> PackageId: edi.595.1
# #> Report Date/Time: 2021-12-16T22:49:25
# #> Total Quality Checks: 29
# #> Valid: 21
# #> Info: 8
# #> Warn: 0
# #> Error: 0

## ----eval=FALSE---------------------------------------------------------------
# # Read the evaluation report
# report <- read_evaluate_report(transaction, as = "char", env = "staging")
# message(report)
# #> ===================================================
# #>   EVALUATION REPORT
# #> ===================================================
# #>
# #> PackageId: edi.595.1
# #> Report Date/Time: 2021-12-16T08:17:40
# #> Total Quality Checks: 29
# #> Valid: 21
# #> Info: 8
# #> Warn: 0
# #> Error: 0
# #>
# #> ---------------------------------------------------
# #>   DATASET REPORT
# #> ---------------------------------------------------
# #>
# #> IDENTIFIER: packageIdPattern
# #> NAME: packageId pattern matches "scope.identifier.revision"
# #> DESCRIPTION: Check against LTER requirements for scope.identifier.revision
# #> EXPECTED: 'scope.n.m', where 'n' and 'm' are integers and 'scope' is one ...
# #> FOUND: edi.595.1
# #> STATUS: valid
# #> EXPLANATION:
# #> SUGGESTION:
# #> REFERENCE:
# #>
# #> IDENTIFIER: emlVersion
# #> NAME: EML version 2.1.0 or beyond
# #> DESCRIPTION: Check the EML document declaration for version 2.1.0 or higher
# #> EXPECTED: eml://ecoinformatics.org/eml-2.1.0 or higher
# #> FOUND: https://eml.ecoinformatics.org/eml-2.2.0
# #> STATUS: valid
# #> EXPLANATION: Validity of this quality report is dependent on this check ...
# #> SUGGESTION:
# #> REFERENCE:
# #> ...

## ----eval=FALSE---------------------------------------------------------------
# # Create a new data package
# transaction <- create_data_package(
#  eml = paste0(tempdir(), "/edi.595.1.xml"),
#  env = "staging")
# transaction
# #> [1] "create_163966765080210573__edi.595.1"
# 
# # Check status
# status <- check_status_create(
#  transaction = transaction,
#  env = "staging")
# status
# #> [1] TRUE

## ----eval=FALSE---------------------------------------------------------------
# #' # Update data package
# #' transaction <- update_data_package(
# #'   eml = paste0(tempdir(), "/edi.595.2.xml"),
# #'   env = "staging")
# #' transaction
# #' #> [1] "update_edi.595_163966788658131920__edi.595.2"
# #'
# #' # Check status
# #' status <- check_status_update(
# #'   transaction = transaction,
# #'   env = "staging")
# #' status
# #' #> [1] TRUE

