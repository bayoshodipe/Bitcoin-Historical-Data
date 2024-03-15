# Bitcoin Historical Data
### MS Excel-MySQL-PowerBI
![Bitcoin Historic Data Report - Samuel Adebayo Shodipe 1](https://github.com/bayoshodipe/Bitcoin-Historical-Data/assets/8863358/3741b760-2b87-43b0-8ee4-11187c641547)

The historic Bitcoin data analysis presented here unveils a fascinating journey of the world's most renowned cryptocurrency, Bitcoin, about the course of a decade from 2012 to 2021, this digital asset experienced a remarkable surge in value, evolving from a modest $4.39 to a staggering $58,000 per unit over the span of ten years. Bitcoin's trajectory is nothing short of extraordinary.

## Data Used

**Data** - Bitcoin Data with 8 columns and 1,048,576 rows from January 2012 ro March 2021 provided by #Quantun Analytics NG.

**Data Cleaning & Analysis** - MySQL and PowerBI

**Data Visualization** - PowerBI

## SQL Cleaning Techniques
1. The raw data was in unix timestamp and I have to convert it to Timedate in order to extract the date and time into separate columns

```sql
# Setting values to Tranc_time column by spliting Tranc_Datetime to time
update bitcoin_dataset_details set Tranc_time = substring_index(Tranc_datetime, ' ', -1);

# Change Tranc_time column data type to time
alter table bitcoin_dataset_details 
change column `Tranc_time` `Tranc_time` Time;

# Setting values to Tranc_datetime column by spliting Tranc_Datetime to date
update bitcoin_dataset_details set Tranc_datetime = substring_index(Tranc_datetime, ' ', 1);

# Change Tranc_datetime column data type to date
alter table bitcoin_dataset_details 
change column `Tranc_datetime` `Tranc_datetime` Date;

```

2. I substituted every "NaN" values in all the columns with 0 and change the column data type to Double

```sql
# Replacing NAN values to 0 for Open_price
update bitcoin_dataset_details 
set Open_price = 0 where Open_price = 'NaN';

# Change Open_price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Open_price` `Open_price` Double;

```


3. I inserted another column for the Transaction ID which has an incremental value and serves as the primary key for the table and I moved it to the first position in the table

 ```sql
# Adding Transaction ID to each entry
alter table bitcoin_dataset_details
add column Tranc_ID int NOT NULL Primary key AUTO_INCREMENT;

# Moving column Tran_ID to first position on the table
alter table bitcoin_dataset_details
change Tranc_ID Tranc_ID int first;
```
