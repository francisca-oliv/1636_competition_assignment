##  There are two data sets training data.csv and holdout_data.csv in the input_data directory of this repo
##  Set up a model predicting the variable "income" in the data set training_data.csv
#     Use this model to predict the missing income variable in the holdout_data.csv dataset
#     All data wrangling, feature engineering and modeling steps should be done in this repo. We want to see your work. Document what you are doing in a markdown file!
#   Give us back a file called predictions.csv containing your predictions.
#     The file should be located in the output_data directory of the repo
#     The file has to be of the same length and ordering as the holdout_data.csv file!
#     The predicted column has to be named income_group_name! This means if your group name is group1 the column should be named income_group1!

library(caret)
library(dplyr)
library(tidyverse)
library(xgboost)
#install.packages("janitor")
library(janitor) <#for data cleaning

getwd()
setwd("/Users/franciscacoito/Documents/WU/Courses/FW 2022/Data Science/Github/moped/1636_competition_assignment/input_data")

tdata <- read.csv("trainig_test_data.csv") %>% drop_na()
hdata <- read.csv("holdout_data.csv") %>% drop_na() #includes 29 variables, i.e. all except 'income'


#Our procedure should be finding a ensemble model that works best to fit our model to such training set.
#The method used to split the whole data set was hold-out, meaning we split the dataset into a train and test set. 
#We train the model on the training set, and then we evaluate how well the model performs on unseen data, the test set.
#Importantly, we tune the model by definind a set of hyperparameters that correspond to the ensemble method used --> tunning grid.
#Finally obtain our predictions of target feature (income) and assess the model performance using as metric the RMSE.
#It is also of interest to observe how our target variable correlated to the predicted model and which of the explanatory variables
#are the most important in predicting our model.

#The hold out set purpose is to validade model performance! A.k.a the unseen test data

#Step 1: cleaning data
names(tdata)
str(tdata)

dupes <- tdata %>%  
  get_dupes()  #checking for dupes in data

tdata %>% 
  remove_constant()  #checking for constant data, if so remove







nrow(hdata)/nrow(tdata) #p=0.11 approx i.e. the splitting rule to get each trainting and holdout set



#Hyperparameter Tuning
tuneGrid <- expand_grid()


