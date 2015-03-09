#!/bin/bash
node_modules/.bin/istanbul cover test.js > testCoverage.txt
>reulst.txt
filename='testCoverage.txt'
filename1='result.txt'
sed -n '3,6p' "$filename">$filename1

while read line
do
var="50"
hundred="100"
temp=$line
temp1=${temp#*:}
temp2=${temp1%%(*}
temp3=${temp2:0:4}

if [ "$temp3" == "$hundred" ]
then
	temp3="99"
	echo $temp2
fi
temp3=${temp2:0:3}
if [ "$temp3" -gt "$var" ]
then
	echo "Test coverage is greater than 50%."
else
	echo "Test coverage is smaller than 50%."
fi
done<$filename1
