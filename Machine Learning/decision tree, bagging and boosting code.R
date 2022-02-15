

# Note, some of these libraries are not needed for this template code.
library(readr)
library(dplyr)
library(zoo)
library(psych)
library(ROCR)
library(corrplot)
library(car)
library(InformationValue)
library(pbkrtest)
library(car)
library(leaps)
library(MASS)
library(corrplot)
library(glm2)
library(aod)
library(caret)

# Data Import and Variable Type Changes
setwd("D:/Class/Online MSBA/ML1 Online/Mod5")
data <- read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 3\\buad5122-m3-insurance-training.csv")
test <- read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 3\\buad5122-m3-insurance-test.csv")


### Need to make sure our data is understood correctly by R, since we have a mix of numerical and categorical
data$INDEX <- as.factor(data$INDEX)
data$TARGET_FLAG <- as.factor(data$TARGET_FLAG)
data$SEX <- as.factor(data$SEX)
data$EDUCATION <- as.factor(data$EDUCATION)
data$PARENT1 <- as.factor(data$PARENT1)
data$INCOME <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$INCOME)))

data$HOME_VAL <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$HOME_VAL)))
data$MSTATUS <- as.factor(data$MSTATUS)
data$REVOKED <- as.factor(data$REVOKED)
data$RED_CAR <- as.factor(ifelse(data$RED_CAR=="yes", 1, 0))
data$URBANICITY <- ifelse(data$URBANICITY == "Highly Urban/ Urban", "Urban", "Rural")
data$URBANICITY <- as.factor(data$URBANICITY)
data$JOB <- as.factor(data$JOB)
data$CAR_USE <- as.factor(data$CAR_USE)
data$CAR_TYPE <- as.factor(data$CAR_TYPE)
data$DO_KIDS_DRIVE <- as.factor(ifelse(data$KIDSDRIV > 0, 1, 0 ))
data$OLDCLAIM <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$HOME_VAL)))
data$BLUEBOOK <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$BLUEBOOK)))
summary(data)

######## Same treatment on test data set ###########################

### Need to make sure our data is understood correctly by R, since we have a mix of numerical and categorical
test$INDEX <- as.factor(test$INDEX)
test$TARGET_FLAG <- as.factor(test$TARGET_FLAG)
test$SEX <- as.factor(test$SEX)
test$EDUCATION <- as.factor(test$EDUCATION)
test$PARENT1 <- as.factor(test$PARENT1)
test$INCOME <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", test$INCOME)))
test$HOME_VAL <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", test$HOME_VAL)))
test$MSTATUS <- as.factor(test$MSTATUS)
test$REVOKED <- as.factor(test$REVOKED)
test$RED_CAR <- as.factor(ifelse(test$RED_CAR=="yes", 1, 0))
test$URBANICITY <- ifelse(test$URBANICITY == "Highly Urban/ Urban", "Urban", "Rural")
test$URBANICITY <- as.factor(test$URBANICITY)
test$JOB <- as.factor(test$JOB)
test$CAR_USE <- as.factor(test$CAR_USE)
test$CAR_TYPE <- as.factor(test$CAR_TYPE)
test$DO_KIDS_DRIVE <- as.factor(ifelse(test$KIDSDRIV > 0, 1, 0 ))
test$OLDCLAIM <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", test$HOME_VAL)))
test$BLUEBOOK <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", test$BLUEBOOK)))
summary(test)

#################### Part 1: Data Exploration ##############################################
# Histograms for Numeric Variables
par(mfrow=c(2,2))
hist(data$AGE, col = "red", xlab = "Age", main = "AGE Hist")
data0<- subset(data, TARGET_FLAG == 1 )
boxplot(data$AGE, col = "red", main = "AGE BoxPlot")
par(mfrow=c(1,1))

par(mfrow=c(2,2))
hist(sqrt(data$TRAVTIME), col = "green", xlab = "SQRT TRAVTIME", main = "SQRT TRAVTIME Hist")
hist(data$YOJ, col = "blue", xlab = "YOJ", main = "YOJ Hist")
boxplot(sqrt(data$TRAVTIME), col = "green", main = "SQRT TRAVTIME BoxPlot")
boxplot(data$YOJ, col = "blue", main = "YOJ BoxPlot")
par(mfrow=c(1,1))

par(mfrow=c(2,2))
hist(sqrt(data$BLUEBOOK), col = "green", xlab = "SQRT BLUEBOOK", main = "SQRT BLUEBOOK Hist")
hist((data$TIF), col = "blue", xlab = "TIF", main = "TIF Hist")
boxplot(sqrt(data$BLUEBOOK), col = "green", main = "SQRT BLUEBOOK BoxPlot")
boxplot(data$TIF, col = "blue", main = "TIF BoxPlot")
par(mfrow=c(1,1))

par(mfrow=c(2,2))
hist(data$MVR_PTS, col = "red", xlab = "MVR_PTS", main = "MVR_PTS Hist")
hist(data$CAR_AGE, col = "blue", xlab = "CAR_AGE", main = "CAR_AGE Hist")
boxplot(data$MVR_PTS, col = "red", main = "MVR_PTS BoxPlot")
boxplot(data$CAR_AGE, col = "blue", xlab = "CAR_AGE", main = "CAR_AGE BoxPlot")
par(mfrow=c(1,1))

########### Part 2: Data Transformation ##################
# Fix NA's, note car age
data$AGE[is.na(data$AGE)] <- mean(data$AGE, na.rm = "TRUE")
data$YOJ <- na.aggregate(data$YOJ, data$JOB, mean, na.rm = TRUE)
data$INCOME <- na.aggregate(data$INCOME, data$JOB, mean, na.rm = TRUE)
data$HOME_VAL <- na.aggregate(data$HOME_VAL, data$JOB, mean, na.rm = TRUE )
data$CAR_AGE <- na.aggregate(data$CAR_AGE, data$CAR_TYPE, mean, na.rm = TRUE)
data$CAR_AGE[data$CAR_AGE < 0 ] <- 0 
data$OLDCLAIM <- ifelse(data$CAR_AGE < 5 & !is.na(data$CAR_AGE),0,data$OLDCLAIM)
data$OLDCLAIM <- na.aggregate(data$OLDCLAIM, data$CAR_AGE, mean, na.rm = TRUE )
data$HOME_OWNER <- ifelse(data$HOME_VAL == 0, 0, 1)
data$SQRT_TRAVTIME <- sqrt(data$TRAVTIME)
data$SQRT_BLUEBOOK <- sqrt(data$BLUEBOOK)

# Bin Income
data$INCOME_bin[is.na(data$INCOME)] <- "NA"
data$INCOME_bin[data$INCOME == 0] <- "Zero"
data$INCOME_bin[data$INCOME >= 1 & data$INCOME < 30000] <- "Low"
data$INCOME_bin[data$INCOME >= 30000 & data$INCOME < 80000] <- "Medium"
data$INCOME_bin[data$INCOME >= 80000] <- "High"
data$INCOME_bin <- factor(data$INCOME_bin)
data$INCOME_bin <- factor(data$INCOME_bin, levels=c("NA","Zero","Low","Medium","High"))

test$AGE[is.na(test$AGE)] <- mean(test$AGE, na.rm = "TRUE")
test$YOJ <- na.aggregate(test$YOJ, test$JOB, mean, na.rm = TRUE)
test$INCOME <- na.aggregate(test$INCOME, test$JOB, mean, na.rm = TRUE)
test$HOME_VAL <- na.aggregate(test$HOME_VAL, test$JOB, mean, na.rm = TRUE )
test$CAR_AGE <- na.aggregate(test$CAR_AGE, test$CAR_TYPE, mean, na.rm = TRUE)
test$CAR_AGE[test$CAR_AGE < 0 ] <- 0 
test$OLDCLAIM <- ifelse(test$CAR_AGE < 5 & !is.na(test$CAR_AGE),0,test$OLDCLAIM)
test$OLDCLAIM <- na.aggregate(test$OLDCLAIM, test$CAR_AGE, mean, na.rm = TRUE )
test$HOME_OWNER <- ifelse(test$HOME_VAL == 0, 0, 1)
test$SQRT_TRAVTIME <- sqrt(test$TRAVTIME)
test$SQRT_BLUEBOOK <- sqrt(test$BLUEBOOK)

# Bin Income
test$INCOME_bin[is.na(test$INCOME)] <- "NA"
test$INCOME_bin[test$INCOME == 0] <- "Zero"
test$INCOME_bin[test$INCOME >= 1 & test$INCOME < 30000] <- "Low"
test$INCOME_bin[test$INCOME >= 30000 & test$INCOME < 80000] <- "Medium"
test$INCOME_bin[test$INCOME >= 80000] <- "High"
test$INCOME_bin <- factor(test$INCOME_bin)
test$INCOME_bin <- factor(test$INCOME_bin, levels=c("NA","Zero","Low","Medium","High"))

summary(data)
summary(test)

numeric <- subset(data, select = c(AGE, HOMEKIDS, YOJ, INCOME, HOME_VAL, TRAVTIME, BLUEBOOK, TIF,
                                   CLM_FREQ, MVR_PTS, CAR_AGE), na.rm = TRUE)
c <- cor(numeric)
corrplot(c, method = "square")

############# Part 3: Model Development ######################
#Model Development for TARGET_FLAG
Model1 <- glm(TARGET_FLAG ~ AGE + BLUEBOOK + TRAVTIME + KIDSDRIV + SEX + URBANICITY + HOMEKIDS + 
                CLM_FREQ + REVOKED + MVR_PTS + CAR_AGE + TIF + EDUCATION + MSTATUS + PARENT1 + RED_CAR + 
                CAR_USE + CAR_TYPE + YOJ + JOB + INCOME_bin + HOME_VAL, 
              data = data, family = binomial())
summary(Model1)
data$Model1Prediction <- predict(Model1, type = "response")


Model2 <- glm(TARGET_FLAG ~ AGE + BLUEBOOK + TRAVTIME + KIDSDRIV + SEX +  URBANICITY +
                CLM_FREQ + REVOKED + MVR_PTS + TIF + EDUCATION + MSTATUS + PARENT1 + CAR_USE + CAR_TYPE + YOJ + JOB + 
                HOME_VAL,
                data = data, family = binomial())
summary(Model2)
data$Model2Prediction <- predict(Model2, type = "response")

Model3 <- glm(TARGET_FLAG ~ AGE + SQRT_TRAVTIME + SQRT_BLUEBOOK + DO_KIDS_DRIVE + URBANICITY +
                CLM_FREQ + REVOKED + MVR_PTS + TIF + EDUCATION + MSTATUS + PARENT1 + CAR_USE + CAR_TYPE + JOB + 
                HOME_OWNER,
              data = data, family = binomial())
summary(Model3)
data$Model3Prediction <- predict(Model3, type = "response")
data$Model3Prediction<-ifelse(data$Model3Prediction>.26,1,0)
data$Model3Prediction<-as.factor(data$Model3Prediction)
confusionMatrix(data$Model3Prediction,data$TARGET_FLAG)

library(aod)
library(ggplot2)

#Model 4
model4 <- glm(TARGET_FLAG ~ AGE + SQRT_TRAVTIME + SQRT_BLUEBOOK + DO_KIDS_DRIVE * URBANICITY +
                CLM_FREQ * REVOKED + MVR_PTS + TIF * EDUCATION + MSTATUS + PARENT1 * CAR_USE + CAR_TYPE + JOB + 
                HOME_OWNER,
              data = data, family = "binomial"())
data$Model4Prediction <- predict(model4, type = "response")
summary(model4)
confint(model4)
confint.default
wald.test(b = coef(model4), Sigma = vcov(mylogit), Terms = 4:6)
exp(coef(model4))
exp(cbind(OR = coef(model4), confint(model4)))
prop.table(table(data$TARGET_FLAG))
data$Model4Prediction<-ifelse(data$Model4Prediction>.26,1,0)
data$Model4Prediction<-as.factor(data$Model4Prediction)
confusionMatrix(data$Model4Prediction,data$TARGET_FLAG)

#Model 5 - Bagging and Random Forests

data <- data[ -c(1,31:34)]



library(randomForest)
set.seed(1)
bag.data=randomForest(TARGET_FLAG~.,data=data,mtry=13,importance=TRUE)
x<-1:8161
data['target_amount'] <- x
bag.data1=randomForest(target_amount~.,data=data,mtry=13,importance=TRUE)
bag.data
bag.data1
yhat.bag = predict(bag.data,newdata=data)
yhat.bag<- sapply(yhat.bag, as.numeric)
yhat.bag1 = predict(bag.data,newdata=data)
yhat.bag1<- sapply(yhat.bag, as.numeric)
yhplot(yhat.bag, data)
abline(0,1)
mean((yhat.bag-data)^2)
bag.data=randomForest(TARGET_FLAG~.,data=data,mtry=13,ntree=25)
bag.data1=randomForest(target_amount~.,data=data,mtry=13,ntree=25)
yhat.bag = predict(bag.data,newdata=data)
yhat.bag1 = predict(bag.data,newdata=data)
mean((yhat.bag-data.test)^2)
set.seed(1)
rf.data=randomForest(TARGET_FLAG~.,data=data,mtry=6,importance=TRUE)
rf.data1=randomForest(target_amount~.,data=data,mtry=6,importance=TRUE)
yhat.rf = predict(rf.data,newdata=data)
yhat.rf1 = predict(rf.data1,newdata=data)
mean((yhat.rf-data.test)^2)
importance(rf.data) #rm and lstat are the importance of increasing MSE
varImpPlot(rf.data)
importance(rf.data1) #rm and lstat are the importance of increasing MSE
varImpPlot(rf.data1)

# Boosting
library(gbm)
set.seed(1)
boost.data=gbm(TARGET_FLAG~.,data=data,distribution="gaussian",n.trees=5000,interaction.depth=4)
boost.data1=gbm(target_amount~.,data=data,distribution="gaussian",n.trees=5000,interaction.depth=4)

summary(boost.data)
summary(boost.data1)
par(mfrow=c(1,2))
plot(boost.data,i="BLUEBOOK") #stats of relative importance
plot(boost.data,i="HOME_OWNER") #grows with the predictor
yhat.boost=predict(boost.data,newdata=data,n.trees=5000)
yhat.boost1=predict(boost.data1,newdata=data,n.trees=5000)
mean((yhat.boost-data.test)^2)
boost.data=gbm(TARGET_FLAG~.,data=data,distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
boost.data1=gbm(target_amount~.,data=data,distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
yhat.boost=predict(boost.data,newdata=data,n.trees=5000)
yhat.boost1=predict(boost.data1,newdata=data,n.trees=5000)
mean((yhat.boost-data.test)^2)



# Predictions on the training set
predictTrain = predict(model4, data = data, type = "response")




#### Part 5:  Score Model on Test Data set and output csv file

# Again, double-checking to make sure we don't have any NA's in our Test Data Set
x<-1:2141
test <- test[ -c(1)]
summary(test)
test['TARGET_FLAG'] <- x
library(randomForest)
set.seed(1)
bag.data=randomForest(TARGET_FLAG~.,data=test,mtry=13,importance=TRUE)

test['target_amount'] <- x
bag.data1=randomForest(target_amount~.,data=test,mtry=13,importance=TRUE)
bag.data
bag.data1
yhat.bag = predict(bag.data,newdata=test)
yhat.bag<- sapply(yhat.bag, as.numeric)
yhat.bag1 = predict(bag.data,newdata=test)
yhat.bag1<- sapply(yhat.bag, as.numeric)
yhplot(yhat.bag, test)
abline(0,1)
mean((yhat.bag-data)^2)
bag.data=randomForest(TARGET_FLAG~.,data=test,mtry=13,ntree=25)
bag.data1=randomForest(target_amount~.,data=test,mtry=13,ntree=25)
yhat.bag = predict(bag.data,newdata=test)
yhat.bag1 = predict(bag.data,newdata=test)
mean((yhat.bag-data.test)^2)
set.seed(1)
rf.data=randomForest(TARGET_FLAG~.,data=test,mtry=6,importance=TRUE)
rf.data1=randomForest(target_amount~.,data=test,mtry=6,importance=TRUE)
yhat.rf = predict(rf.data,newdata=test)
yhat.rf1 = predict(rf.data1,newdata=test)
mean((yhat.rf-data.test)^2)
importance(rf.data) #rm and lstat are the importance of increasing MSE
varImpPlot(rf.data)
importance(rf.data1) #rm and lstat are the importance of increasing MSE
varImpPlot(rf.data1)

# Boosting
library(gbm)
set.seed(1)
boost.data=gbm(TARGET_FLAG~.,data=test,distribution="gaussian",n.trees=5000,interaction.depth=4)
boost.data1=gbm(target_amount~.,data=test,distribution="gaussian",n.trees=5000,interaction.depth=4)

summary(boost.data)
summary(boost.data1)
par(mfrow=c(1,2))
plot(boost.data,i="BLUEBOOK") #stats of relative importance
plot(boost.data,i="HOME_OWNER") #grows with the predictor
yhat.boost=predict(boost.data,newdata=test,n.trees=5000)
yhat.boost1=predict(boost.data1,newdata=test,n.trees=5000)
mean((yhat.boost-data.test)^2)
boost.data=gbm(TARGET_FLAG~.,data=test,distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
boost.data1=gbm(target_amount~.,data=test,distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
yhat.boost=predict(boost.data,newdata=test,n.trees=5000)
yhat.boost1=predict(boost.data1,newdata=test,n.trees=5000)
mean((yhat.boost-data.test)^2)

########### STAND ALONE SCORING PROGRAM ###############
##### Model coefficients used to create P_TARGET_FLAG

test<-cbind(test,yhat.bag1)

mean(test$TARGET_FLAG)
test$TARGET_FLAG<-ifelse(test$yhat.bag1>1072,1,0)
mean(test$TARGET_FLAG)
test$P_TARGET_FLAG<-as.factor(test$TARGET_FLAG)
colnames(test)[31] <- "TARGET_AMT_FINAL"
#Prediction File 

prediction <- test[c("TARGET_FLAG","TARGET_AMT_FINAL")]
write.csv(prediction, file = "C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 7\\Prediction.csv")

summary(test)
