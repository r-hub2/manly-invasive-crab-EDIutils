## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(EDIutils)

## ----eval=FALSE---------------------------------------------------------------
# # Match all documents with keywords "disturbance" and return only their IDs
# res <- search_data_packages(query = 'q=keyword:disturbance&fl=id')

## ----eval=FALSE---------------------------------------------------------------
# # Match all documents with keywords "disturbance", excluding ecotrends and
# # lter-landsat scopes from the returned results
# query <- 'q=keyword:disturbance&fl=packageid&fq=-scope:(ecotrends+lter-landsat)'
# res <- search_data_packages(query)

## ----eval=FALSE---------------------------------------------------------------
# # Match anything, display all fields, limit to only one document
# res <- search_data_packages(query = 'q=*&fl=*&rows=1')

## ----eval=FALSE---------------------------------------------------------------
# # Find all FCE LTER data packages, displaying the package id, title, and DOI
# query <- 'q=scope:knb-lter-fce&fl=packageid,title,doi&rows=100'
# res <- search_data_packages(query)
# 
# # Query on author
# query <- 'q=author:duane+costa&fq=author:costa&fl=id,title,author,score'
# res <- search_data_packages(query)

## ----eval=FALSE---------------------------------------------------------------
# # Query on subject "Primary Production" OR subject "plant". Note that 'subject'
# # is an aggregation of several other fields containing searchable text:
# # 'author', 'organization', 'title', 'keyword', and 'abstract' fields rolled
# # together into a single searchable field.
# query <- paste0('q=subject:("Primary+Production")+OR+subject:plant&fq=',
#                 '-scope:ecotrends&fq=-scope:lter-landsat*&fl=id,packageid,',
#                 'title,author,organization,pubdate,coordinates')
# res <- search_data_packages(query)

## ----eval=FALSE---------------------------------------------------------------
# scope = "edi"
# identifier = "1047"
# revision = list_data_package_revisions(scope, identifier, filter = "newest")
# paste(scope, identifier, revision, sep = ".")
# #> [1] "edi.1047.2"

## ----eval=FALSE---------------------------------------------------------------
# packageId <- "edi.1047.1"

## ----eval=FALSE---------------------------------------------------------------
# # Download data package to path
# read_data_package_archive(packageId, path = tempdir())
# #> |=============================================================| 100%
# dir(tempdir())
# #> [1] ""edi.1047.1.zip"

## ----eval=FALSE---------------------------------------------------------------
# # List data entities of the data package
# res <- read_data_entity_names(packageId)
# res
# #>                           entityId                entityName
# #> 1 3abac5f99ecc1585879178a355176f6d        Environmentals.csv
# #> 2 f6bfa89b48ced8292840e53567cbf0c8               ByCatch.csv
# #> 3 c75642ddccb4301327b4b1a86bdee906               Chinook.csv
# #> 4 2c9ee86cc3f3ffc729c5f18bfe0a2a1d             Steelhead.csv
# #> 5 785690848dd20f4910637250cdc96819 TrapEfficiencyRelease.csv
# #> 6 58b9000439a5671ea7fe13212e889ba5 TrapEfficiencySummary.csv
# #> 7 86e61c1a501b7dcf0040d10e009bfd87        TrapOperations.csv
# 
# # Download Steelhead.csv in raw bytes. Use the entityName and entityID as keys.
# entityName <- "Steelhead.csv"
# entityId <- res$entityId[res$entityName == entityName]
# raw <- read_data_entity(packageId, entityId)
# head(raw)
# #> [1] ef bb bf 44 61 74

## ----eval=FALSE---------------------------------------------------------------
# # These data have a common format are simply parsed
# data <- readr::read_csv(file = raw)
# data
# #> # A tibble: 2,926 x 14
# #>    Date   trapVisitID subSiteName catchRawID releaseID commonName
# #>    <chr>        <dbl> <chr>            <dbl>     <dbl> <chr>
# #>  1 1/12/~         326 North Chan~      32123         0 Steelhead ~
# #>  2 1/14/~         336 North Chan~      33980         0 Steelhead ~
# #>  3 1/15/~         337 North Chan~      32683         0 Steelhead ~
# #>  4 1/16/~         339 North Chan~      32971         0 Steelhead ~
# #>  5 1/17/~         341 North Chan~      33104         0 Steelhead ~
# #>  6 1/18/~         342 North Chan~      33304         0 Steelhead ~
# #>  7 1/19/~         343 North Chan~      33432         0 Steelhead ~
# #>  8 1/21/~         349 North Chan~      34083         0 Steelhead ~
# #>  9 1/21/~         349 North Chan~      34084         0 Steelhead ~
# #> 10 1/23/~         351 North Chan~      34384         0 Steelhead ~
# #> # ... with 2,916 more rows, and 8 more variables:
# #> #   lifeStage <chr>, forkLength <dbl>, weight <dbl>, n <dbl>,
# #> #   mort <chr>, fishOrigin <chr>, markType <chr>,
# #> #   CatchRaw.comments <chr>

## ----eval=FALSE---------------------------------------------------------------
# # Read the same data entity but using the physical metadata
# library(xml2)
# eml <- read_metadata(packageId)
# meta <- read_metadata_entity(packageId, entityId)
# fieldDelimiter <- xml_text(xml_find_first(meta, ".//physical//fieldDelimiter"))
# numHeaderLines <- xml_double(xml_find_first(meta, ".//physical//numHeaderLines"))
# data <- readr::read_delim(
#   file = raw,
#   delim = fieldDelimiter,
#   skip = numHeaderLines-1)
# data
# #> # A tibble: 2,926 x 14
# #>    Date   trapVisitID subSiteName catchRawID releaseID commonName
# #>    <chr>        <dbl> <chr>            <dbl>     <dbl> <chr>
# #>  1 1/12/~         326 North Chan~      32123         0 Steelhead ~
# #>  2 1/14/~         336 North Chan~      33980         0 Steelhead ~
# #>  3 1/15/~         337 North Chan~      32683         0 Steelhead ~
# #>  4 1/16/~         339 North Chan~      32971         0 Steelhead ~
# #>  5 1/17/~         341 North Chan~      33104         0 Steelhead ~
# #>  6 1/18/~         342 North Chan~      33304         0 Steelhead ~
# #>  7 1/19/~         343 North Chan~      33432         0 Steelhead ~
# #>  8 1/21/~         349 North Chan~      34083         0 Steelhead ~
# #>  9 1/21/~         349 North Chan~      34084         0 Steelhead ~
# #> 10 1/23/~         351 North Chan~      34384         0 Steelhead ~
# #> # ... with 2,916 more rows, and 8 more variables:
# #> #   lifeStage <chr>, forkLength <dbl>, weight <dbl>, n <dbl>,
# #> #   mort <chr>, fishOrigin <chr>, markType <chr>,
# #> #   CatchRaw.comments <chr>

