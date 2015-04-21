# MILESTONE: TEST+ANALYSIS

Team Member:
- Pengyu Li    (pli5@ncsu.edu)

- Nikhil Katre (nkatre@ncsu.edu)

## Evaluation

Unit Tests and Coverage - 20%

Test Generation/Exploration Technique - 20%

Base Analysis - 30%

Extended Analysis - 10%

Gate - 20%

### Unit Tests and Coverage results
Based on previous workshop and hw2, we have used TestGeneration tools to generate test case(test.js) to cover javascript unit test. And then, adopt Istanbul which is a coverage tool to run test cases and report test result.

Generate Unit Test Case: 

    node main.js

Run istanbul tool to get a simple coverage report

    node_modules/.bin/istanbul cover test.js
    
![alt tag](https://github.com/maxlpy/TestAnalysis/blob/master/pictures/TestResult0.png)

### Improve testing coverage with constraint
We used contraint to generate the test case and improve the coverage by 100%. You can see `main.js` in my repository which include all the code to improve testing coverage. 

We can run `node main.js` to generate `test.js` for `subject.js`. Then, we run istanbul tool to get the following coverage report.
![alt tag](https://github.com/maxlpy/TestAnalysis/blob/master/pictures/TestResult1.png)

## Analysis Component
### Basic analysis using an existing static analysis tool JSHint to analyze the source code
We used the JSHint to analyze the sourse code `subject.js`. The more infomation about JSHint can be found from [here](http://jshint.com/docs)

Install JSHint

    npm install jshint -g

Run JSHint on sourse code

    jshint subject.js
Analysis results

    subject.js: line 4, col 10, Use '===' to compare with 'null'.
    subject.js: line 8, col 15, Missing semicolon.
    subject.js: line 9, col 6, Unnecessary semicolon.
    <b>3 errors</b>

### Extended Analysis using JSHint with a new rule 
According to the above analysis result of JSHint, we got `3 errors`. JSHint comes with a default set of warnings but it was designed to be very configurable. 

#### JSHint Configuration

JSHint comes with a default set of warnings but it was designed to be very configurable. There are [three ways](http://jshint.com/docs/) to configure your copy of JSHint: you can either specify the configuration file manually via the --config flag, use a special file `.jshintrc` or put your config into your projects package.json file under the jshintConfig property. 

In case of `.jshintrc`, JSHint will start looking for this file in the same directory as the file that's being linted. If not found, it will move one level up the directory tree all the way up to the filesystem root. 

We used the second methd to create a special file `.jshintrc` and put this config into the directory of our project. 

For example, `error1: subject.js: line 4, col 10, Use '===' to compare with 'null'.` We can ignore this rule via changing the JSHint configure file with following steps.

Configure the rules in the JSHint configure file and implement a new analysis.

    {
         "eqnull": true
    }

Run `jshint subject.js` again, we can get the following result

    subject.js: line 8, col 15, Missing semicolon.
    subject.js: line 9, col 6, Unnecessary semicolon.
    2 error

### Reject a commit using Gate value 50%.

We used git pre-commit hook to reject a a commit if its minimum testing criteria is lower than 50%. You can do it by following steps:

Create a pre-commit file in the directory of .git/hooks.

    cd .git/hooks
    mv pre-comit.sample pre-commit
    chmod +x pre-commit
    
Then, copy the content of rejectTest.sh into pre-commit file, and then run `git commit -m "Test pre-commit"`. You will get the following results.

#### JSHint Analysis Results

    fred@acer:~/Dropbox/Courses/CSC591/TestAnalysis$ git commit -m "test"
    =============================================================================
    Writing coverage object [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage/coverage.json]
    Writing coverage reports at [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage]
    =============================================================================
    === Running static analysis tool JSHint on the soucre code.
    subject.js: line 8, col 15, Missing semicolon.
    subject.js: line 9, col 6, Unnecessary semicolon.
    2 errors
    ====== There are bugs in the source code.!!!!!
    ############### JSHint Analysis Failed #################

After fixing the above two errors, we can run `git commit -m test2` again. The successful analysis results came out.

    fred@acer:~/Dropbox/Courses/CSC591/TestAnalysis$ git commit -m "test2"
    =============================================================================
    Writing coverage object [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage/coverage.json]
    Writing coverage reports at [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage]
    =============================================================================
    === Running static analysis tool JSHint on the soucre code.
    ############### JSHint Analysis Successful #################

#### Test coverage is lower than gate value 50%

When test criteria is lower than 50%, the gate value of 50% will tell the test results and fail the `git commit`. We will get the following test results:

    fred@acer:~/Dropbox/Courses/CSC591/TestAnalysis$ git commit -m "add reject a commit function"
    =============================================================================
    Writing coverage object [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage/coverage.json]
    Writing coverage reports at [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage]
    =============================================================================
    === Running static analysis tool JSHint on the soucre code.
    ############### JSHint Analysis Successful #################
    === Reject a commit if if fails a minimum test criteria.
    Statements : === Test coverage is greater than 50%.
    Branches   : === Test coverage is smaller than 50%.   
    ###################### Commit Failed ######################
    
If we added more test cases and all test criterias greater than 50%, `git commit` will succeed. In this case, we run `git commit -m "test"` again, it will show the following test results.
    
#### Test coverage is greater than gate value 50%

    fred@acer:~/Dropbox/Courses/CSC591/TestAnalysis$ git commit -m "test"
    =============================================================================
    Writing coverage object [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage/coverage.json]
    Writing coverage reports at [/home/fred/Dropbox/Courses/CSC591/TestAnalysis/coverage]
    =============================================================================
    === Running static analysis tool JSHint on the soucre code.
    ############### JSHint Analysis Successful #################
    === Reject a commit if if fails a minimum test criteria.
    Statements : === Test coverage is greater than 50%.
    Branches   : === Test coverage is greater than 50%.
    Functions  : === Test coverage is greater than 50%.
    Lines      : === Test coverage is greater than 50%.
    #################### Commit Successful #####################
    [master 601d7c2] test
     15 files changed, 163 insertions(+), 141 deletions(-)
     delete mode 100644 analysis.txt
     rewrite coverage/coverage.json (93%)
     create mode 100755 jshint.sh
     create mode 100644 jshintResult.txt
