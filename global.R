rm(list = ls())
library(ggvis)
library(GGally)
library(dplyr)
library(class)
library(caret)
library(shiny)
library(Metrics)



# feature descriptions ####
# -- 1. #3  (age)   integer
# -- 2. #4  (sex)   factor    
# -- 3. #9  (cp)    chest pain type - factor    
# -- 4. #10 (trestbps)  resting blood pressure (integer)
# -- 5. #12 (chol)      serum cholesterol (integer)
# -- 6. #16 (fbs)       (fasting blood sugar > 120 mg/dl)  (1 = true; 0 = false))
# -- 7. #19 (restecg)   resting electrocardiographic results (factor)
#                       -- Value 0: normal
#                       -- Value 1: having ST-T wave abnormality (T wave inversions and/or ST 
#                                           elevation or depression of > 0.05 mV)
#                       -- Value 2: showing probable or definite left ventricular hypertrophy
#                       by Estes' criteria
# -- 8. #32 (thalach)   maximum heart rate achieved (numeric)
# -- 9. #38 (exang)     exercise induced angina (1 = yes; 0 = no) factor
# -- 10. #40 (oldpeak)  ST depression induced by exercise relative to rest (numeric)
# -- 11. slope: factor the slope of the peak exercise ST segment
#                 -- Value 1: upsloping
#                 -- Value 2: flat
#                 -- Value 3: downsloping     
# -- 12. #44 (ca)   factors  number of major vessels (0-3) colored by flourosopy   
# -- 13. #51 (thal) factors 3 = normal; 6 = fixed defect; 7 = reversable defect     
# -- 14. #58 (num)  diagnosis of heart disease (angiographic disease status)
#          -- Value 0: < 50% diameter narrowing
#         -- Value 1: > 50% diameter narrowing


# read in data and preprocess ####

class.list <- c("numeric", "factor","factor",
                "numeric","numeric", "factor", 
                "factor", "numeric", "factor",
                "numeric","factor",
                "factor", "factor", "factor")


ds <- read.csv("processed.cleveland.data",  header = F, 
               colClasses = class.list)
# add names to dataset
names(ds) <- c( "age", "sex", "cp",
                "trestbps", "chol",
                "fbs", "restecg",
                "thalach","exang",
                "oldpeak","slope",
                "ca","thal","num")
feature.list <- list("age" = "age", "sex" ="sex",
                     "cp"= "cp","trestbps" = "trestbps",
                     "chol"="chol","fbs"="fbs",
                     "restecg"="restecg","thalach"="thalach",
                     "exang"="exang","oldpeak"="oldpeak",
                     "slope"="slope","ca"="ca","thal"="thal")

# keep an original copy of the data to retain classes
# for displays
original.ds <- ds

# change the class of all columns to numeric
ds <- as.data.frame(apply(ds, 2, as.numeric))

# remove na/missing values (original data shows as ?)
ds <- na.omit(ds)
# all values of num > 0 are cases of heart disease 
# as per the data descriptions at the uci repository
ds$num[ds$num > 0] <- 1
ds$num <- factor(ds$num, levels = c(0,1), labels = c("negative", "positive"))

# standardize/normalize the data
# for knn we want to ensure the distance is normalized for all 
# features

# standardize all point except the response variable
standardized.X <- scale(ds[,-14])
set.seed(55)

# create training and test sets
training.index <- createDataPartition(ds$num, p = .8,list = F)
train.X <- standardized.X[training.index,]
test.X  <- standardized.X[-training.index,]
train.Y <- ds$num[training.index]
test.Y <- ds$num[-training.index]

# table settings ####

table.settings <- list(searching = F, pageLength = 5, bLengthChange = F,
                       bPaginate = F, bInfo = F )