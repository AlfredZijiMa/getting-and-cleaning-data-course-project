# CodeBook for getting and cleaning data project
## variables
1. Training data
*subTrain : from raw data set subject_train.txt
*xTrain : from raw data set X_train.txt
*yTrain : from raw data set y_train.txt
2. Testing data
*subTest : from raw data set subject_test.txt
*xTest : from raw data set X_test.txt
*yTest : from raw data set y_test.txt
3. Feature data
*feature : from raw data set features.txt
4. Activity data
*activity : from raw data setactivity_labels.txt

##Steps to clean data
1. read and store taining, testing, feature and activity data
2. combine training and testing data into a whole data set allData
3. correct names of allData properly
4. subset data and extract needed data
5. simplify names of data set
6. use package 'dplyr' to group and summarise data
7. output tidy data set
