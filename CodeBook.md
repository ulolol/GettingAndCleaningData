This code uses the data.table and the reshape2 libraries.
data.table library is used for the data access and manipulation.
reshape2 is used to transform the data into a more understandable and readable format.

loc = provides the current working directory so that we do not have to enter the full file path everytime we read a file.

trainset = stores the complete training data initially, and later is modified to store just the relevant columns of data from the training dataset

testset = stores the complete testing data initially, and later is modified to store just the relevant columns of data from the testing dataset

activitylabel = stores the class label and the activity names takes from the activity_labels.txt file 

feature = stores the index and the corresponding feature, taken from the features.txt

featurereqd = stores only the features with "mean" or "std" in the name, as required by the project

measurement = stores the mean/std feature names after stripping the unnecessary brackets

trainactivity = stores the training activity 

trainsubject = stores the training subjects

testactivity = stores the testing activity 

testsubject = stores the testing subjects

mergedset = stores the combined training and testing datasets

tidyDataset.txt = tidy dataset text file


The dataset was originally a wide format set which makes it quite difficult to understand and use.
Hence, the tidy set was first converted to the long format and then aggregated to make the final dataset easy to understand and use.
The aggregation function used was the mean of the values for each set.

The dataset consists of only the features with either "mean" or "std" in their name as per the project reqirement. This was achieved by simply modifying 
the variables that store to the whole dataset to just store the required values and strip the rest of the data.


