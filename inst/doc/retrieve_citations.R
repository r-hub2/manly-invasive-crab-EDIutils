## ----eval=FALSE---------------------------------------------------------------
# library(EDIutils)
# library(dplyr)
# library(tidyr)

## ----eval=FALSE---------------------------------------------------------------
# scope <- "edi"
# identifiers <- list_data_package_identifiers(scope)

## ----eval=FALSE---------------------------------------------------------------
# identifiers <- paste0(scope, ".", identifiers, ".1")
# res <- lapply(identifiers, list_data_package_citations, list_all = TRUE)
# df_return_all <- do.call(rbind, res)

## ----eval=FALSE---------------------------------------------------------------
# df_data_packages <- df_return_all %>%
#   separate(
#     packageId,
#     into = c("scope", "datasetNum", "revision"),
#     sep = "\\."
#   ) %>%
#   mutate(datasetId = paste(scope, datasetNum, sep = ".")) %>%
#   distinct(datasetId)
# 
# print(paste("Unique data packages being cited:", nrow(df_data_packages)))
# #> [1] "Unique data packages being cited: 375"

## ----eval=FALSE---------------------------------------------------------------
# df_articles <- df_return_all %>%  distinct(articleUrl)
# print(paste('Number of aricles:', nrow(df_articles)))
# #> [1] "Number of aricles: 503"

