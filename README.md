# GettingAndCleaningData
Repo for the Project of the Coursera Course "Getting and Cleaning Data" by John Hopkins University

> The file run_analysis.R is the main script that performs the required functions.

> The tidy set generated is stored in tidyDataset.txt.

> The information regarding the libraries used as well as the use of each variable is given in the CodeBook.

> The required data will be dynamically downloaded and unzipped in your current working directory, as I cannot upload the whole dataset here.



Working and Explaination
> Each line in the script is accompanied with a comment explaining what it does, but the gist can be found below.
>  >The training and testing datasets are read in their entirety.

>  >Then we use the provided labels , activity names and features to modify the datasets.

>  >The dataset is reduced to include only the required data and features.

>  >The training and testing datasets are combined.

>  >The text data values are converted into categorical values by changing them into factors.

>  >The dataset is converted from the wide format to the long format.

>  >The dataset is converted into the wide format after aggregation the values of all features by using the mean as the aggregating function.
