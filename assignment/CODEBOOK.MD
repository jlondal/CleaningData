run_analysis.R script cleans the data as follows:

1. Loads in X_train.txt, y_train.txt and subject_train.txt in the train folder into: train, trainLabel and trainSubject respectively
2. Loads in X_test.txt, y_test.txt and subject_test.txt in the test folder into: test, testLabel and testSubject respectively
In the script these steps are mixed together

3. Appends test & train to create a new dataset called join.Data

4. Loads features.txt from the root director in the data folder into features variable. 

5. Loads the acitivty_lables.txt in the root director into activities variable

6. Merges the join.Subject, join.Label and join.Data by column to get output_df (I was getting to excited and thought I was almost done)

7. Exports the output_df out to merged_data.txt in the working directory.

8. Creates a empty maxtix, by empty I mean filled with NA's to populated with all the mean of each activity & subject. The matrix is 
called results

9. Loops though and populated the matrix restults
