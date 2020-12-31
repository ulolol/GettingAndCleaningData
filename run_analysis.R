require(data.table)
require(reshape2)

#set the location as the current working directory to avoid entering it everytime we need to read a file.
loc = getwd()


#download and unzip the provided dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file.path(loc, "projDataset.zip"))
unzip(zipfile = "projDataset.zip")


#load the training dataset
trainset = fread(file.path(loc, "UCI HAR Dataset/train/X_train.txt"))


#load the testing dataset
testset = fread(file.path(loc, "UCI HAR Dataset/test/X_test.txt"))


#generate acvitity labels and feature list using the provided files for the same in the dataset
activitylabel = fread(file.path(loc, "UCI HAR Dataset/activity_labels.txt"), col.names = c("classlabel", "activityname"))

feature = fread(file.path(loc, "UCI HAR Dataset/features.txt"), col.names = c("index", "featurename"))



#extract the values with either "mean" or "std" in the feature name
featurereqd = grep("(mean|std)\\(\\)", feature[, featurename])


#generate a measurement using the mean/std features
measurement = feature[featurereqd, featurename]


#remove the brackets from the entries in measurement to make it easier to understand(Brackets are not required for processing the data)
measurement = gsub('[()]', '', measurement)


#load required values from the testset and trainset by using the generated activitylabel and feature list
trainset = trainset[, featurereqd, with = FALSE]


#set the column names in trainset as the ones in measurement 
data.table::setnames(trainset, colnames(trainset), measurement)


#read the training activity 
trainactivity = fread(file.path(loc, "UCI HAR Dataset/train/y_train.txt"), col.names = c("activity"))


#read the training subjects
trainsubject = fread(file.path(loc, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("subjectno"))


#add the training subjects and activities to the trainset
trainset = cbind(trainsubject, trainactivity, trainset)

#testset processing
testset = testset[, featurereqd, with = FALSE]


#set the column names in testset as the ones in measurement
data.table::setnames(testset, colnames(testset), measurement)


#read the testing activities
testactivity = fread(file.path(loc, "UCI HAR Dataset/test/y_test.txt"), col.names = c("activity"))


#read the tesing subjects
testsubject = fread(file.path(loc, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("subjectno"))


#add the testing subjects and activities to testset
testset = cbind(testsubject, testactivity, testset)


#print the top values of both sets to confirm the data
print(head(trainset))
print(head(testset))


#merge the training and testing datasets
mergedset = rbind(trainset, testset)


#print the top values of the merged dataset to confirm the data 
print(head(mergedset))


#change the classlabel to the activityname
#converting the text data into a factor to generate categorical data
mergedset[["activity"]] = factor(mergedset[, activity], levels = activitylabel[["classlabel"]], labels = activitylabel[["activityname"]])



#converting the text data into a factor to generate categorical data
mergedset[["subjectno"]] = as.factor(mergedset[,subjectno])



#the dataset is in wide format which is not easy to understand and use, so convert it to long format
mergedset = reshape2::melt(data = mergedset, id = c("subjectno", "activity"))



#convert the long dataset to wide format again to aggregate the values of each entry into understandable sections
#using mean of the data as the aggregating function
mergedset = reshape2::dcast(data = mergedset, subjectno + activity ~ variable, fun.aggregate = mean)



#write the merged tidy dataset to a file
write.table(mergedset, file = "tidyDataset.txt", quote = FALSE, row.names = FALSE)







