library(tidyverse)
library(readr)
library(janitor)

#file handle
file.choose()
sam_data <- read.csv("/Users/riadmac/Documents/R program/r-data-cleaning-practice/data/raw /Sample - Superstore Sales (Excel).csv",fileEncoding = "latin1")


glimpse(sam_data)
colSums(is.na(sam_data))
summary(sam_data)
sum(duplicated(sam_data))

#clean column names and convert order date to date formet
clean_data <- sam_data |>
  clean_names() |>
  mutate(
    order_date=as.Date(order_date,format="%m/%d/%y"),
    ship_date=as.Date(ship_date,format="%m/%d/%y")
  )

glimpse(clean_data)
summary(clean_data)
colSums(is.na(clean_data))
sum(duplicated(clean_data))

#Median Imputation for the gap values
clean_data <- clean_data |>
  group_by(product_sub_category) |>
  mutate(
    product_base_margin=if_else(
      is.na(product_base_margin),
      median(product_base_margin,na.rm = TRUE),
      product_base_margin
    )
    ) |>
  ungroup()
write.csv(clean_data,"data/processed/cleaned_superstore.csv")
