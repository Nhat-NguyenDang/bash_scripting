#! /bin/bash
echo "change3214" >> test.log
#download data, save to a file
today=$(date +%Y%m%d)
weather_report=raw_data_$today
city=matsuyama
curl wttr.in/$city --output $weather_report

# extract the current temperature
grep °C $weather_report > temperatures.txt

obs_tmp=$(cat -v temperatures.txt | head -1 | cut -d "+" -f2 | cut -d "^" -f1 )

#extract forecasted temperature
fc_tmp=$(cat temperatures.txt | head -3 | tail -1 | cut -d "^" -f 3-4 | cut -d "+" -f 3 | cut -d "(" -f1 )

#
hour=$(date +%H) 
day=$(date +%d) 
month=$(date +%m)
year=$( date +%Y)

#Add data to log file
echo -e "$year\t$month\t$day\t$hour\t$obs_tmp\t$fc_tmp" >> rx_poc.log
