
The script run_analysis.R contains the code necessary to treat the raw data and convert it into tidy data. This script:
  - Reads the training and the test data sets, as well as the subject's ID numbers and the activities performed.
  - Assigns column names to the training and the test data set, and merges each data set to their corresponding identifiers (subjects
    ID and activity).
  - Merges both of the data sets in a single data frame.
  - Orders the data frame according to the variables "Subjects_ID" and "Activity".
  - Renames the columns so the variable names are more intuitive.
  - Groups the data frame by ID and activity and calculates the column mean, and stores this in a new, independent data frame.
  - Exports the latter data frame in a text file called "TidyData.txt".
