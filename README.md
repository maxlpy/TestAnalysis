### Run unit tests, measure coverage, and report the results
Based on previous workshop and hw2, we use TestGeneration tools to generate test case(test.js) to cover javascript unit test. And then, we adopt Istanbul which is a coverage tool to run test case and get test result report.

Generate Unit Test Case: 

    node main.js

Run istanbul tool and get a simple coverage report

    node_modules/.bin/istanbul cover test.js
    
![alt tag](https://github.com/maxlpy/TestAnalysis/blob/master/pictures/TestResult.png)

### Improve testing coverage with constraint
We used contraint to generate the test case and improve the coverage by 100%. We can run `node main.js` to generate `test.js`, and the code under test is `subject.js`. Then we will get the above coverage report.

### Use an existing static analysis tool JSHint to analyze the source code
We used the JSHint to analyze the sourse code `subject.js`. The more infomation about JSHint can be found from here. 
#### Install JSHint
    npm install jshint -g

#### Run JSHint on sourse code
    jshint subject.js
#### Get analysis result
    subject.js: line 4, col 10, Use '===' to compare with 'null'.
    subject.js: line 8, col 15, Missing semicolon.
    subject.js: line 9, col 6, Unnecessary semicolon.
    3 errors

### Extend JSHint with a new rule
According to above analysis result of JSHint, we got 3 errors. JSHint comes with a default set of warnings but it was designed to be very configurable. There are three main ways to configure your copy of JSHint. 
We used the second methd to create a special file `.jshintrc` and put this config into the directory of our project. In case of `.jshintrc`, JSHint will start looking for this file in the same directory as the file that's being linted. 
We can configure the rules in the JSHint configure file and implement a new analysis.
    {
    "eqnull": true
    }

Run `jshint subject.js` again, we can get the following result
    subject.js: line 8, col 15, Missing semicolon.
    subject.js: line 9, col 6, Unnecessary semicolon.
    2 errors




We can see that there are 3 erros
which are found by JsHint. We can modify the options of the JsHint to omit certain errors found by JsHint. For example, we want to omit the first error which is using '==' to compare with 'null'. We can create a .jshintrc file and put the JsHint options into it. The list of the JsHint options can be found here. To omit the above the error,we can put the following into the file.
