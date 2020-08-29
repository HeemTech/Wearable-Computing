Code Book

The purpose of this code book is to describe the variables, the data, and any transformation or work done to clean the data.

Datasets required:
1.'features_info.txt': Shows information about the variables used on the feature vector.
2.'features.txt': List of all features.
3.'activity_labels.txt': Links the class labels with their activity name.
4.'train/X_train.txt': Training set.
5.'train/y_train.txt': Training labels.
6.'test/X_test.txt': Test set.
7.'test/y_test.txt': Test labels.
8.'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Transformations:
1.The above mentioned datasets are loaded into R.
2.The test data and train data for the set,labels and subject information are merged together.
3.Only mean and std information are subsetted from the merged data sets.
4.A separate dataset is created which contain the id_numbers iof the subjects, the various activities they performed, and the mean of the variables.
5.It is stored in a file.