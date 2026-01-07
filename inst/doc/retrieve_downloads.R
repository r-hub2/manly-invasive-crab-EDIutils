## ----eval=FALSE---------------------------------------------------------------
# library(EDIutils)
# library(dplyr)
# library(tidyr)
# library(ggplot2)
# library(lubridate)

## ----eval=FALSE---------------------------------------------------------------
# login()
# #> userID: "my_name"
# #> userPass: "my_secret"

## ----eval=FALSE---------------------------------------------------------------
# # Construct the query
# query <- paste(
#   "category=info",
#   "serviceMethod=readDataEntity",
#   "resourceId=knb-lter-ntl",
#   "fromTime=2018-12-12T00:00:00",
#   "toTime=2022-05-24T00:00:00",
#   sep = "&"
# )
# 
# # Get the report
# df_report <- get_audit_report(query)
# 
# logout()

## ----eval=FALSE---------------------------------------------------------------
# df_results <- df_report %>%
#   filter(user != "robot") %>%
#   filter(userAgent != "DataONE-Python/3.4.7 +http://dataone.org/") %>%
#   filter(nchar(resourceId) > 0) %>%
#   separate(entryTime, into = c("date", NA), sep = "T") %>%
#   separate(
#     resourceId,
#     into = c(NA, NA, NA, NA, NA, NA, "scope", "identifier", "revision", NA),
#     sep = "/"
#   )
# 
# df_results$date <- ymd(df_results$date)

## ----eval=FALSE---------------------------------------------------------------
# df_downloads <- df_results %>%
#   group_by(identifier) %>%
#   summarise(n = n())

## ----eval=FALSE---------------------------------------------------------------
# top20 <- arrange(df_downloads, desc(n)) %>% slice(1:20)
# 
# ggplot(top20, aes(x = reorder(identifier, -n), y = n)) +
#   geom_bar(stat = "identity") +
#   labs(
#     y = "Number of Downloads",
#     x = "Data Package Identifier",
#     title = "Downloads by Identifier"
#   )

## ----eval=FALSE---------------------------------------------------------------
# df_downloads_per_month <- df_results %>%
#   mutate(month = month(date)) %>%
#   group_by(month) %>%
#   summarise(n = n())

## ----eval=FALSE---------------------------------------------------------------
# df_downloads_daily <- df_results %>%
#   group_by(date) %>%
#   arrange(date) %>%
#   summarise(n = n())
# 
# ggplot(df_downloads_daily, aes(x = date, y = n, group = 1)) +
#   geom_line() +
#   labs(
#     y = "Number of Downloaded Entities",
#     x = "Date",
#     title = "Daily Downloads"
#   )

