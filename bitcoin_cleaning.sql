# Select database to use
use bitcoin_dataset;

# Create Table bitcoin dataset
CREATE TABLE `bitcoin_dataset_details` (
  `Trac_timestamp` int NULL,
  `Open_price` varchar(255) NULL,
  `High_price` varchar(255) NULL,
  `Low_price` varchar(255) NULL,
  `Close_price` varchar(255) NULL,
  `Volume_(BTC)` varchar(255) NULL,
  `Volume_(Currency)` varchar(255) NULL,
  `btc_Weighted_Price` varchar(255) NULL
  );
  
# load csv file into the table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bitstampUSD_1-min_data_2012-01-01_to_2021-03-31.csv' 
INTO TABLE bitcoin_dataset_details
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

# Adding Transaction ID to each entry
alter table bitcoin_dataset_details
add column Tranc_ID int NOT NULL Primary key AUTO_INCREMENT;

# Moving column Tran_ID to first position on the table
alter table bitcoin_dataset_details
change Tranc_ID Tranc_ID int first;

# Select Trac_timestamp and show the unixtime
select Trac_timestamp, from_unixtime(Trac_timestamp) from bitcoin_dataset_details
order by from_unixtime(Trac_timestamp);

# Adding new column named Tranc_datetime
alter table bitcoin_dataset_details
add column Tranc_datetime varchar(255) after Trac_timestamp;

# Adding new column named Tranc_time
alter table bitcoin_dataset_details
add column Tranc_time varchar(255) after Tranc_datetime;

# To disable the safe mode
SET sql_safe_updates = 0;

# Setting values to Tranc_datetime from Trac_timestamp column in date and time
update bitcoin_dataset_details set Tranc_datetime = from_unixtime(Trac_timestamp);

select * from bitcoin_dataset_details;

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

# Replacing NAN values to 0 for Open_price
update bitcoin_dataset_details 
set Open_price = 0 where Open_price = 'NaN';

# Change Open_price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Open_price` `Open_price` Double;

# Replacing NAN values to 0 for High_price
update bitcoin_dataset_details 
set High_price = 0 where High_price = 'NaN';

# Change High_price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `High_price` `High_price` double;

# Replacing NAN values to 0 for Low_price
update bitcoin_dataset_details 
set Low_price = 0 where Low_price = 'NaN';

# Change Low_price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Low_price` `Low_price` Double;

# Replacing NAN values to 0 for Close_price
update bitcoin_dataset_details 
set Close_price = 0 where Close_price = 'NaN';

# Change Close_price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Close_price` `Close_price` Double;

# Replacing NAN values to 0 for Volume_BTC
update bitcoin_dataset_details 
set Volume_BTC = 0 where Volume_BTC = 'NaN';

# Change Volume_BTC column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Volume_BTC` `Volume_BTC` Double;

# Replacing NAN values to 0 for Volume_Currency
update bitcoin_dataset_details 
set Volume_Currency = 0 where Volume_Currency = 'NaN';

# Change Volume_Currency column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `Volume_Currency` `Volume_Currency` Double;

# Replacing NAN values to 0 for btc_Weighted_Price
update bitcoin_dataset_details 
set btc_Weighted_Price = 0 where btc_Weighted_Price = 'NaN';

# Change btc_Weighted_Price column data type to Decimal(Double)
alter table bitcoin_dataset_details 
change column `btc_Weighted_Price` `btc_Weighted_Price` Double;

# Description of the table created
describe bitcoin_dataset_details;

# Export the cleaned data into a csv file
select * into outfile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bitcoin_dataset.csv'
fields terminated by ',' lines terminated by '\n'
from bitcoin_dataset_details
where Open_price != 0
order by Tranc_datetime Asc;
