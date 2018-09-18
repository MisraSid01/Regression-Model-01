library(ggplot2)
library(caret)
library(magrittr)
library(rpart)
library(stats)
library(tibble)
library(tidyverse)

set.seed(42)

# Reading a file into R Workspace"
house_data <- read_csv("kc_house_data.csv")
house_data$waterfront <- as.factor(house_data$waterfront)
house_data$condition <- as.factor(house_data$condition)
house_data$grade <- as.factor(house_data$grade)
# -------------------------------------------------------------------------------
# Randomly sorting rows of the dataset to avoid selection Bias
sample_rows <- sample(nrow(house_data))
house_data <- house_data[sample_rows, ]

#---------------------------------------------------------------------------------
# Splitting the data into training and test datasets
data_split <- round(nrow(house_data) * 0.80)
train <- house_data[(1:data_split), ]
test <- house_data[(data_split + 1):(nrow(house_data)), ]

# ---------------------------------------------------------------------------------
# Training the model on train dataset and testing the data.
house_model <- train(price ~. -id, train, method = "lm",
                     trControl = trainControl(method = "cv", number = 10,
                         verboseIter = TRUE))

print(house_model)
house_predict <- predict(house_model, test)

# ---------------------------------------------------------------------------










