## ----setup--------------------------------------------------------------------
library(EDIutils)

## ----eval=FALSE---------------------------------------------------------------
# context("Create journal citation")
# 
# testthat::test_that("Test attributes of returned object", {
#   skip_if_logged_out()
#   journalCitationId <- create_journal_citation(
#     packageId = get_test_package(),
#     articleDoi = "10.1890/11-1026.1",
#     articleUrl = "https://doi.org/10.1890/11-1026.1",
#     articleTitle = "Corridors promote fire via connectivity and edge effects",
#     journalTitle = "Ecological Applications",
#     relationType = "IsCitedBy",
#     env = "staging")
#   expect_type(journalCitationId, "double")
#   res <- delete_journal_citation(journalCitationId, env = "staging")
#   expect_true(res)
# })

## ----eval=FALSE---------------------------------------------------------------
# context("Evaluate data package")
# 
# testthat::test_that("Test attributes of returned object", {
#   skip_if_logged_out()
#   skip_if_missing_eml_config()
#   # Create data package for evaluation
#   identifier <- create_reservation(scope = "edi", env = "staging")
#   packageId <- paste0("edi.", identifier, ".1")
#   eml <- create_test_eml(
#     path = tempdir(),
#     packageId = packageId,
#     edi_id = "EDI-543afa80c859825d35d37d9111c24a4a65a0ff3e")
#   on.exit(file.remove(eml), add = TRUE, after = FALSE)
#   # Evaluate
#   transaction <- evaluate_data_package(eml, env = "staging")
#   res <- check_status_evaluate(transaction, env = "staging")
#   expect_true(res)
#   # Read evaluation report
#   report <- read_evaluate_report(transaction, env = "staging")
#   expect_true("xml_document" %in% class(report))
#   delete_reservation("edi", identifier, env = "staging")
# })
# 

