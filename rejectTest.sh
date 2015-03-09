#!/bin/bash
# Reject a commit if it fails a minimum testing criteria (e.g. less than 50% statement coverage)
# Use static analysis tool on the source code.

node_modules/.bin/istanbul cover test.js > testCoverage.txt
>reulst.txt
filename='testCoverage.txt'
filename1='result.txt'
sed -n '3,6p' "$filename">$filename1

echo "=== Running static analysis tool JSHint on the soucre code."
jshint subject.js | tee jshintResult.txt
tmp="$(grep -o "semicolon" jshintResult.txt)"
if [[ $tmp == *"semicolon"* ]]
then
	echo "====== There are bugs in the source code.!!!!!"
	echo "############### JSHint Analysis Failed #################"
        exit 1
fi
echo "############### JSHint Analysis Successful #################"
echo "=== Reject a commit if if fails a minimum test criteria."
while read line
do
var="50"
hundred="100"
temp=$line
temp1=${temp#*:}
temp2=${temp1%%(*}
temp3=${temp2:0:4}
temp4=${temp3:0:3}
if [ "$temp4" -eq "10" ]
then
	temp4="99"
fi
if [ "$temp4" -gt "$var" ]
then
        echo ${temp:0:14} "=== Test coverage is greater than 50%."
else
        echo ${temp:0:14} "=== Test coverage is smaller than 50%."
	echo "#################### Commit Failed ####################"
	exit 1
fi
done<$filename1
echo "#################### Commit Successful ####################"
