# Getting-and-Cleaning-Data

1)We read all Test releated files( x_test,y_test,subject_test) using Cbind and then combine them into 1 file
2)We will do the same for Trial file's
3)Will then combine the results from Step 1 and Step 2 using rbind
4)As there are some duplicate columns in the file,we need to first delete them before we perform selective columns
5)We then Select only the columns related to Mean and Std
6)We will Update the labels to Descriptions using Factors
7)We will update the column names using gsub
8)We will then create and save a data with averages grouped by activity and subject 
