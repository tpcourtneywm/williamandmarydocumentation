# This is generic code that creates a few simple models and does a few simple things with data preparation.

# Some other R Packages to try.
# ROCR [allowing you to compute ROC curves, etc.]
# MASS [allows for stepwise variable selection for BIC, AIC, etc.]

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

# Data Import and Variable Type Changes
setwd("D:/Class/Online MSBA/ML1 Online/Mod3")
data <- read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 3\\buad5122-m3-insurance-training.csv")
test <- read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 3\\buad5122-m3-insurance-test.csv")



### Need to make sure our data is understood correctly by R, since we have a mix of numerical and categorical
data$INDEX <- as.factor(data$INDEX)
data$TARGET_FLAG <- as.factor(data$TARGET_FLAG)
data$SEX <- as.factor(data$SEX)
data$EDUCATION <- as.factor(data$EDUCATION)
data$PARENT1 <- as.factor(data$PARENT1)
data$INCOME <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$INCOME))) #telling that income is a number, since R is reading it as a text value

data$HOME_VAL <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", data$HOME_VAL)))
data$MSTATUS <- as.factor(data$MSTATUS)
data$REVOKED <- as.factor(data$REVOKED)
data$RED_CAR <- as.factor(ifelse(data$RED_CAR=="yes", 1, 0)) #make these binary
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
#we should make modifications to his transformations
summary(data)
plot(data$AGE) #normally distributed, let's set NA's to the mean
data$AGE[is.na(data$AGE)] <- mean(data$AGE, na.rm = TRUE) 
data$YOJ <- na.aggregate(data$YOJ, data$JOB, 0, na.rm = TRUE)
data$INCOME <- na.aggregate(data$INCOME, data$JOB, 0, na.rm = TRUE)
data$HOME_VAL <- na.aggregate(data$HOME_VAL, data$JOB, 0, na.rm = TRUE )
data$FlagCarAge <- as.factor(ifelse(data$CAR_AGE < 1, 1, 0)) 
data$CAR_AGE <- as.numeric(ifelse(data$FlagCarAge  == 1, abs(data$CAR_AGE), data$CAR_AGE)) 
data$CAR_AGE <- na.aggregate(data$CAR_AGE, data$CAR_TYPE, mean, na.rm = TRUE)
data$OLDCLAIM <- ifelse(data$CAR_AGE < 5 & !is.na(data$CAR_AGE),0,data$OLDCLAIM)
data$OLDCLAIM <- na.aggregate(data$OLDCLAIM, data$CAR_AGE, mean, na.rm = TRUE )
data$HOME_OWNER <- ifelse(data$HOME_VAL == 0, 0, 1)
data$SQRT_TRAVTIME <- sqrt(data$TRAVTIME)
data$SQRT_BLUEBOOK <- sqrt(data$BLUEBOOK)


summary(data)

#Let's make Job Binary, as apparently white collar jobs are safer drivers
#if they are 1, they are blue collar workers
data$WhiteCollar <- as.factor(ifelse(data$JOB == "z_Blue Collar", 1, 0))

#leaving TIF as I would not join unless my car is broken

boxplot(data$OLDCLAIM)
a<-IQR(data$OLDCLAIM)
b<-quantile(data$OLDCLAIM, .75)
lb1<-(b+(1.5*a))
lb1

data$FlagOC <- as.factor(ifelse(data$OLDCLAIM < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
data$OLDCLAIM <- as.numeric(ifelse(data$OLDCLAIM  == 1, quantile(data$OLDCLAIM,c(.90)), data$OLDCLAIM)) 

# Bin Income
#distinguish bin income more, make more bins
#https://money.usnews.com/money/personal-finance/family-finance/articles/where-do-i-fall-in-the-american-economic-class-system
#determined classes
boxplot(data$INCOME)
data$INCOME_bin[is.na(data$INCOME)] <- "NA"
data$INCOME_bin[data$INCOME == 0] <- "Zero"
data$INCOME_bin[data$INCOME >= 1 & data$INCOME < 32048] <- "Poor"
data$INCOME_bin[data$INCOME >= 32048 & data$INCOME < 53413] <- "Lower-Middle Class"
data$INCOME_bin[data$INCOME >= 53413 & data$INCOME < 106827] <- "Middle Class"
data$INCOME_bin[data$INCOME >= 106827 & data$INCOME < 373894] <- "Upper-Middle Class"
data$INCOME_bin[data$INCOME >= 373894] <- "Rich"
data$INCOME_bin <- factor(data$INCOME_bin)
data$INCOME_bin <- factor(data$INCOME_bin, levels=c("NA","Zero","Poor","Lower-Middle Class","Middle Class", "Upper-Middle Class","Rich"))

summary(test)
plot(test$AGE) #normally distributed, let's set NA's to the mean
test$AGE[is.na(test$AGE)] <- mean(data$AGE, na.rm = TRUE) 
test$YOJ <- na.aggregate(test$YOJ, test$JOB, 0, na.rm = TRUE)
test$INCOME <- na.aggregate(test$INCOME, test$JOB, 0, na.rm = TRUE)
test$HOME_VAL <- na.aggregate(test$HOME_VAL, test$JOB, 0, na.rm = TRUE )
test$FlagCarAge <- as.factor(ifelse(test$CAR_AGE < 1, 1, 0)) 
test$CAR_AGE <- as.numeric(ifelse(test$FlagCarAge  == 1, abs(test$CAR_AGE), test$CAR_AGE)) 
test$CAR_AGE <- na.aggregate(test$CAR_AGE, test$CAR_TYPE, mean, na.rm = TRUE)
test$OLDCLAIM <- ifelse(test$CAR_AGE < 5 & !is.na(test$CAR_AGE),0,test$OLDCLAIM)
test$OLDCLAIM <- na.aggregate(test$OLDCLAIM, test$CAR_AGE, mean, na.rm = TRUE )
test$HOME_OWNER <- ifelse(test$HOME_VAL == 0, 0, 1)
test$SQRT_TRAVTIME <- sqrt(test$TRAVTIME)
test$SQRT_BLUEBOOK <- sqrt(test$BLUEBOOK)


boxplot(data$INCOME)
boxplot(test$INCOME)
test$INCOME_bin[test$INCOME == 0] <- "Zero"
test$INCOME_bin[test$INCOME >= 1 & test$INCOME < 32048] <- "Poor"
test$INCOME_bin[test$INCOME >= 32048 & test$INCOME < 53413] <- "Lower-Middle Class"
test$INCOME_bin[test$INCOME >= 53413 & test$INCOME < 106827] <- "Middle Class"
test$INCOME_bin[test$INCOME >= 106827 & test$INCOME < 373894] <- "Upper-Middle Class"
test$INCOME_bin[test$INCOME >= 373894] <- "Rich"
test$INCOME_bin <- factor(test$INCOME_bin)
test$INCOME_bin <- factor(test$INCOME_bin, levels=c("Zero","Poor","Lower-Middle Class","Middle Class", "Upper-Middle Class","Rich"))


summary(test)

#Let's make Job Binary, as apparently white collar jobs are safer drivers
#if they are 1, they are blue collar workers
test$WhiteCollar <- as.factor(ifelse(test$JOB == "z_Blue Collar", 1, 0))

#leaving TIF as I would not join unless my car is broken

boxplot(test$OLDCLAIM)
a<-IQR(test$OLDCLAIM)
b<-quantile(test$OLDCLAIM, .75)
lb1<-(b+(1.5*a))
lb1

test$FlagOC <- as.factor(ifelse(test$OLDCLAIM < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
test$OLDCLAIM <- as.numeric(ifelse(test$OLDCLAIM  == 1, quantile(test$OLDCLAIM,c(.90)), test$OLDCLAIM))



summary(data)
summary(test)

numeric <- subset(data, select = c(AGE, HOMEKIDS, YOJ, INCOME, HOME_VAL, TRAVTIME, BLUEBOOK, TIF,
                                   CLM_FREQ, MVR_PTS, CAR_AGE), na.rm = TRUE)
c <- cor(numeric)
corrplot(c, method = "square")

############# Part 3: Model Development ######################
#Model Development for TARGET_FLAG
Model1 <- glm(TARGET_FLAG ~ AGE + BLUEBOOK + TRAVTIME + KIDSDRIV + SEX +  URBANICITY +
                CLM_FREQ + REVOKED,
              data = data, family = binomial())
summary(Model1)
data$Model1Prediction <- predict(Model1, type = "response")


Model2 <- glm(TARGET_FLAG ~ AGE + BLUEBOOK + TRAVTIME + KIDSDRIV + SEX +  URBANICITY +
                CLM_FREQ + REVOKED + MVR_PTS + TIF + EDUCATION * MSTATUS + PARENT1 + CAR_USE + CAR_TYPE + YOJ + JOB + 
                HOME_VAL + INCOME_bin,
              data = data, family = binomial())
summary(Model2)
data$Model2Prediction <- predict(Model2, type = "response")

Model3 <- glm(TARGET_FLAG ~ AGE + SQRT_TRAVTIME + SQRT_BLUEBOOK + DO_KIDS_DRIVE * URBANICITY +
                CLM_FREQ + REVOKED + MVR_PTS + TIF + EDUCATION + MSTATUS + PARENT1 + CAR_USE + CAR_TYPE + JOB + 
                HOME_OWNER+INCOME_bin * WhiteCollar,
              data = data, family = binomial())
summary(Model3)
data$Model3Prediction <- predict(Model3, type = "response")

########## Part 4: Model Selection 
#calculate the AIC and BIC, package from MASS library and make a selection.
#calculate the ROC values (the area under the curve)
AIC(Model1)
BIC(Model1)
AIC(Model2)
BIC(Model2)
AIC(Model3)
BIC(Model3)
ks_stat(actuals=data$TARGET_FLAG, predictedScores=data$Model1Prediction)
ks_stat(actuals=data$TARGET_FLAG, predictedScores=data$Model2Prediction)
ks_stat(actuals=data$TARGET_FLAG, predictedScores=data$Model3Prediction)
#ROC Curve
library(ROCR)
library(pROC)

ROCR1=prediction(data$Model1Prediction, data$TARGET_FLAG)
perf1=performance(ROCR1,"tpr","fpr")
plot(perf1,colorize=F, print.cutoffs.at=seq(0,1,0.1))
roc(data$TARGET_FLAG, data$Model1Prediction, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive Percentage", ylab="True Positive Percentage", lwd=4,print.auc=TRUE)

ROCR2=prediction(data$Model2Prediction, data$TARGET_FLAG)
perf2=performance(ROCR2,"tpr","fpr")
plot(perf2,colorize=F, print.cutoffs.at=seq(0,1,0.1))
roc(data$TARGET_FLAG, data$Model2Prediction, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive Percentage", ylab="True Positive Percentage", lwd=4,print.auc=TRUE)

ROCR3=prediction(data$Model3Prediction, data$TARGET_FLAG)
auc.tmp<-performance(data$TARGET_FLAG,"auc")
perf3=performance(ROCR3,"tpr","fpr")
plot(perf3,colorize=F, print.cutoffs.at=seq(0,1,0.1))
roc(data$TARGET_FLAG, data$Model3Prediction, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive Percentage", ylab="True Positive Percentage", lwd=4,print.auc=TRUE)
mean(data$Model1Prediction)
mean(data$Model2Prediction)
mean(data$Model3Prediction)
# We'll choose Model 3, here are its coefficients
coef(Model3)

#### Part 5:  Score Model on Test Data set and output csv file

# Again, double-checking to make sure we don't have any NA's in our Test Data Set
summary(test)

########### STAND ALONE SCORING PROGRAM ###############
##### Model coefficients used to create P_TARGET_FLAG
test$P_TARGET_FLAG <- predict(Model3, newdata = test, type = "response")


#Prediction File 
prediction <- test[c("INDEX","P_TARGET_FLAG")]
write.csv(prediction, file = "C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 3\\prediction.csv")
#should be a probability between 0 and 1, the target claim should be about 26% and 27%
#typically softwares do it in alpha order, some of them are z_F, so M is first alphabetically
mean(prediction$P_TARGET_FLAG)
boxplot(prediction$P_TARGET_FLAG)

