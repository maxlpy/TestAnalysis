#!/bin/bash
jshint subject.js | tee jshintResult.txt
tmp="$(grep -o "semicolon" jshintResult.txt)"
if [[ $tmp == *"semicolon"* ]]
then
	echo "There are some bugs in the source code.!!!!!"
	exit 1
fi
