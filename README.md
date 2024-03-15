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

4. I exported the cleaned data (those that have Open price value transactions other than 0) into another .csv file for further analysis on PowerBI
 ```sql
# Export the cleaned data into a csv file
select * into outfile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bitcoin_dataset.csv'
fields terminated by ',' lines terminated by '\n'
from bitcoin_dataset_details
where Open_price != 0
order by Tranc_datetime Asc;
```
## Summary of Findings
1. To discern market trends and assess the current state of Bitcoin, the simple moving average (SMA) was employed. The simple moving average of 50 days and 200 days is calculated to know the current market trend for the last 50 days. when the SMA-50 exceeds the SMA-200 the market is on the up trend and if the opposite, it is in a downtrend as indicated in the report.

2. Beyond price fluctuations, this analysis uncovers intriguing insights into Bitcoin trading volume. Following the peak in 2015, which saw approximately 5.5 million Bitcoins traded, the volume declined to around 851,000. The data further reveals key trading hours, with peak trading activity occurring between 3 p.m. and 5 p.m., while the quietest hours fall between 3 a.m. and 6 a.m.

3. The year 2018 witnessed a significant drop in Bitcoin's price, plummeting from around $17,000 to roughly $3,600. A similar decline occurred in late 2019 when the price fell from approximately $12,000 to about $7,000. However, 2020 marked a remarkable turnaround when Bitcoin's price surged from roughly $7,000 to an impressive $29,000. The trend continued into 2021, with Bitcoin nearly doubling in value, soaring from around $29,000 to a staggering $58,000. This analysis delves into these pivotal moments and their impact on the cryptocurrency market.

## Conclusion
The utilization of a 50-day and 200-day Simple Moving Average (SMA) provided a deeper understanding of market trends which offers valuable insights for those navigating the cryptocurrency market. Beyond price and moving averages, the analysis brings to light the fluctuations in Bitcoin's trading volume, offering a glimpse into the dynamics of Bitcoin trading hours. this analysis offers valuable insights for investors, traders, and anyone intrigued by the evolving world of cryptocurrency.

