Readme for Getting and Clinning Data Project

Script run_analysis.R

I assume that working directory is the same as uzipped data sets.

First I make function to add train to test files. This gives shorter code. Next I use this function to add: subject, labels_id and features; these are raw datasets: subject_*.txt', y_*.txt X_*.txt respectively, where * = train or test. And, I read feature names from 'features.txt' file and I select only that columns which name include "mean" or "std" (case insensitive). I choose only these columns from features dataset.

Labels which describe activities I extract using simple SQL query. Then I simplify some of variable names and merge columns with cbind function. Finally I aggregate the data and write the final table.
