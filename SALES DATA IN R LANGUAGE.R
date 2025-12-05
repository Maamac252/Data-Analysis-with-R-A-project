# Loading necessary packages for data exploration

library(dplyr)
library(readr)
library(ggplot2)
library(lubridate)

# the following codes results a grouped by product data with their sum of revenues arranged in a descending order

product_vs_revenues <- sales_data_500 %>% mutate(sales_revenue=price*quantity) %>% group_by(product) %>%
  summarize(product_sales_revenue=sum(sales_revenue)) %>% arrange(-product_sales_revenue)
View(product_vs_revenues)

# Graphing the products which generated the most revenues

ggplot(data = product_vs_revenues)+ geom_bar(mapping = aes(x=product,fill = product))
ggplot(data = product_vs_revenues,aes(x=product,y=product_sales_revenue,fill = product))+ geom_bar(stat = 'identity')+ xlab('product')+ ylab('sales revenue')+
  coord_flip()

ggplot(data = product_vs_revenues,aes(x=product,y=product_sales_revenue,fill = product))+ geom_bar(stat = 'identity')+ xlab('Product')+ ylab('Sales revenue')+coord_flip()+
  labs(title = 'Product Vs Sales',subtitle = 'Products generated the most revenues')
ggsave('Product Vs Sales.png')

# the following codes illustrates the monthly sales and their revenue across the dataset
sales_data_500 $ month <- floor_date(sales_data_500$ order_date,'month')
monthyly_sales <- sales_data_500 %>%
  group_by(month) %>% summarize(monthly_sales=sum(price*quantity))

 monthyly_sales $ month_short <- format(monthyly_sales$month,'%b')
 
 # Graphing the Monthly revenue
 ggplot(data = monthyly_sales,aes(x=month_short,y=monthly_sales,fill = month_short))+ geom_bar(stat = 'identity')+ xlab('month')+ ylab('Revenue')+
   labs(title = 'Month Vs Revenue',subtitle = 'The monthly sales revenue')
 ggsave('Month Vs Sales.png')
 

  # Data visualization using Line chart for assessing the trend changes in the dataset
 
 ggplot(data=monthyly_sales,aes(x=month_short,y=monthly_sales,colour = month_short,size = monthly_sales))+ geom_point(stat = 'identity')+ xlab('Month')+ ylab('Revenue')+
   labs(title = 'point chart monthly sales',subtitle = 'The trending changes in the dataset')
 
 ggsave('Point chart.png')

 