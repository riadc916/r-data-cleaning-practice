library(tidyverse)

file.choose()
clean_ana <- read.csv("/Users/riadmac/Documents/R program/r-data-cleaning-practice/data/processed/cleaned_superstore.csv") |>
  select(-X)


summary(clean_ana)
head(clean_ana)

#what are our total sales and total profit 
clean_ana |>
  summarise(
    Total_sales=sum(sales),
    Total_profit=sum(profit)
  )
#Which product categories and sub-categories are generating the highest profit?
clean_ana |>
  group_by(product_category,product_sub_category) |>
  summarise(Total_profit=sum(profit)) |>
  arrange(desc(Total_profit))


#Are we incurring a loss (or negative profit) on any product or category?
clean_ana |>
  group_by(product_category,product_sub_category) |>
  summarise(Total_profit=sum(profit)) |>
  filter(Total_profit < 0)



