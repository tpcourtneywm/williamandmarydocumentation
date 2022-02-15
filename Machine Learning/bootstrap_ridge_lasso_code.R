
#####
#Designated proper working environment on my computer. You will want to make sure it is in proper place for your computer.
#####
setwd("D:/Class/Online MSBA/ML1 Online/Mod2")
moneyball=read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 4\\buad5122-m4-moneyball-training.csv",header=T)
install.packages(leaps)
install.packages(dplyr)
install.packages(broom)
install.packages(car)
install.packages(MASS)
install.packages(dvmisc)
install.packages(leaps)
install.packages(ISLR)
install.packages(knitr)
install.packages(printr)
library(ISLR)
library(knitr)
library(printr)
library(dplyr)
library(broom)
library(car)
library(MASS)
library(dvmisc)
library(leaps)
############## Part 1: Data Exploration ##########################################################################
str(moneyball)
summary(moneyball)

# Wins - Use lower bound for lower outliers, upper bound for higher outliers.
par(mfrow=c(1,2))
hist(moneyball$TARGET_WINS, col = "#A71930", xlab = "TARGET_WINS", main = "Histogram of Wins")
boxplot(moneyball$TARGET_WINS, col = "#A71930", main = "Boxplot of Wins")
par(mfrow = c(1,1))

################# Batting ####################
# Hits and Doubles
par(mfrow=c(2,2))
hist(moneyball$TEAM_BATTING_H, col = "#A71930", xlab = "Team_Batting_H", main = "Histogram of Hits")
hist(moneyball$TEAM_BATTING_2B, col = "#09ADAD", xlab = "Doubles", main = "Histogram of Doubles")
boxplot(moneyball$TEAM_BATTING_H, col = "#A71930", main = "Boxplot of Hits")
boxplot(moneyball$TEAM_BATTING_2B, col = "#09ADAD", main = "Boxplot of Doubles")
par(mfrow=c(1,1))

# Triples and Home Runs
par(mfrow=c(2,2))
hist(moneyball$TEAM_BATTING_3B, col = "#A71930", xlab = "Triples", main = "Histogram of Triples")
hist(moneyball$TEAM_BATTING_HR, col = "#DBCEAC", xlab = "Home Runs", main = "Histogram of Home Runs")
boxplot(moneyball$TEAM_BATTING_3B, col = "#A71930", main = "Boxplot of Triples")
boxplot(moneyball$TEAM_BATTING_HR, col = "#DBCEAC", main = "Boxplot of Home Runs")
par(mfrow=c(1,1))

# Walks, Strikeouts, HBP
par(mfrow=c(2,3))
hist(moneyball$TEAM_BATTING_BB, col = "#A71930", xlab = "Walks", main = "Histogram of Walks")
hist(moneyball$TEAM_BATTING_SO, col = "#09ADAD", xlab = "Strikeouts", main = "Histogram of Strikeouts")
hist(moneyball$TEAM_BATTING_HBP, col = "#DBCEAC", xlab = "Hit By Pitches", main = "Histogram of HBP")
boxplot(moneyball$TEAM_BATTING_BB, col = "#A71930", main = "Boxplot of Walks")
boxplot(moneyball$TEAM_BATTING_SO, col = "#09ADAD", main = "Boxplot of Strikeouts")
boxplot(moneyball$TEAM_BATTING_HBP, col = "#DBCEAC", main = "Boxplot of HBP")
par(mfrow=c(1,1))

# Stolen Bases and Caught Stealing
par(mfrow=c(2,2))
hist(moneyball$TEAM_BASERUN_SB, col = "#A71930", xlab = "Stolen Bases", main = "Histogram of Steals")
hist(moneyball$TEAM_BASERUN_CS, col = "#DBCEAC", xlab = "Caught Stealing", main = "Histogram of CS")
boxplot(moneyball$TEAM_BASERUN_SB, col = "#A71930", main = "Boxplot of Steals")
boxplot(moneyball$TEAM_BASERUN_CS, col = "#DBCEAC", main = "Boxplot of CS")
par(mfrow=c(1,1))

################ Pitching ############
# Hits and Home Runs
par(mfrow=c(2,2))
hist(moneyball$TEAM_PITCHING_H, col = "#A71930", xlab = "Hits Against", main = "Histogram of Hits Against")
hist(moneyball$TEAM_PITCHING_HR, col = "#09ADAD", xlab = "Home Runs Against", main = "Histograms of HR Against")
boxplot(moneyball$TEAM_PITCHING_H, col = "#A71930", main = "Boxplot of Hits Against")
boxplot(moneyball$TEAM_PITCHING_HR, col = "#09ADAD", main = "Boxplot of HR Against")
par(mfrow=c(1,1))

# Walks and Strikeouts
par(mfrow=c(2,2))
hist(moneyball$TEAM_PITCHING_BB, col = "#A71930", xlab = "Walks Allowed", main = "Histogram of Walks Allowed")
hist(moneyball$TEAM_PITCHING_SO, col = "#DBCEAC", xlab = "Strikeouts", main = "Histograms of Strikeouts")
boxplot(moneyball$TEAM_PITCHING_BB, col = "#A71930", main = "Boxplot of Walks Allowed")
boxplot(moneyball$TEAM_PITCHING_SO, col = "#DBCEAC", main = "Boxplot of Strikeouts")
par(mfrow=c(1,1))

############## Fielding ###########
# Double Plays and Errors 
par(mfrow=c(2,2))
hist(moneyball$TEAM_FIELDING_DP, col = "#A71930", xlab = "Double Plays", main = "Histogram of Double Plays")
hist(moneyball$TEAM_FIELDING_E, col = "#09ADAD", xlab = "Errors Committed", main = "Histogram of Errors Committed")
boxplot(moneyball$TEAM_FIELDING_DP, col = "#A71930", main = "Boxplot of Double Plays")
boxplot(moneyball$TEAM_FIELDING_E, col = "#09ADAD", main = "Boxplot of Errors Committed")
par(mfrow=c(1,1))

######## Scatterplot Matrix ##########
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

# Batting Stats and Wins
pairs(moneyball[2:8], lower.panel=panel.smooth, upper.panel = panel.cor)

#Baserunning  Stats and Wins
pairs(~ moneyball$TARGET_WINS + moneyball$TEAM_BASERUN_CS + moneyball$TEAM_BASERUN_SB, lower.panel = panel.smooth)

#Pitcher Stats and Wins
pairs(~ moneyball$TARGET_WINS + moneyball$TEAM_PITCHING_BB + moneyball$TEAM_PITCHING_H + 
        moneyball$TEAM_PITCHING_HR + moneyball$TEAM_PITCHING_SO, lower.panel = panel.smooth)

pairs(moneyball[2,9,10,11,12,13])

######################### Part 2: Data Preparation #####################

#Fix Missing Values Using Mean of All Seasons
moneyball$TEAM_BATTING_SO[is.na(moneyball$TEAM_BATTING_SO)] = mean(moneyball$TEAM_BATTING_SO, na.rm = TRUE)
moneyball$TEAM_BATTING_HBP[is.na(moneyball$TEAM_BATTING_HBP)] = mean(moneyball$TEAM_BATTING_HBP, na.rm = TRUE)
moneyball$TEAM_BASERUN_SB[is.na(moneyball$TEAM_BASERUN_SB)] = mean(moneyball$TEAM_BASERUN_SB, na.rm = TRUE)
moneyball$TEAM_BASERUN_CS[is.na(moneyball$TEAM_BASERUN_CS)] = mean(moneyball$TEAM_BASERUN_CS, na.rm = TRUE)
moneyball$TEAM_FIELDING_DP[is.na(moneyball$TEAM_FIELDING_DP)] = mean(moneyball$TEAM_FIELDING_DP, na.rm = TRUE)
moneyball$TEAM_PITCHING_SO[is.na(moneyball$TEAM_PITCHING_SO)] = mean(moneyball$TEAM_PITCHING_SO, na.rm = TRUE)

#Straighten Relationships
moneyball$TEAM_BATTING_1B <- moneyball$TEAM_BATTING_H - moneyball$TEAM_BATTING_HR - moneyball$TEAM_BATTING_3B -
                             moneyball$TEAM_BATTING_2B
moneyball$log_TEAM_BATTING_1B <- log(moneyball$TEAM_BATTING_1B)
moneyball$log_TEAM_BATTING_3B <- log(moneyball$TEAM_BATTING_3B)
moneyball$log_TEAM_BASERUN_SB <- log(moneyball$TEAM_BASERUN_SB)
moneyball$log_TEAM_BASERUN_CS <- log(moneyball$TEAM_BASERUN_CS)
moneyball$TEAM_BATTING_SO[is.na(moneyball$TEAM_BATTING_SO)] = mean(moneyball$TEAM_BATTING_SO, na.rm = TRUE)
moneyball$TEAM_FIELDING_E[(moneyball$TEAM_FIELDING_E > 500)] = 500
moneyball$sqrt_TEAM_PITCHING_HR <- sqrt(moneyball$TEAM_PITCHING_HR)
moneyball$SB_PCT <- moneyball$TEAM_BASERUN_SB/(1.0*moneyball$TEAM_BASERUN_SB+moneyball$TEAM_BASERUN_CS)
moneyball$SB_PCT[is.na(moneyball$SB_PCT)] = mean(moneyball$SB_PCT, na.rm = TRUE)

#Check that na's are gone. 
summary(moneyball)


# Cut the training data into training and validation
spec = c(train = .7, validate=.3)

g = sample(cut(
 seq(nrow(moneyball)), 
  nrow(moneyball)*cumsum(c(0,spec)),
 labels = names(spec)
))

res = split(moneyball, g)



sapply(res, nrow)/nrow(moneyball)

set.seed(1)

summary(res$train)
summary(res$validate)
train<-res$train
validate<-res$validate

data(moneyball); require(glmnet)
x=as.matrix(train[, c('TEAM_BATTING_H','TEAM_BATTING_2B','TEAM_BATTING_3B','TEAM_BATTING_HR','TEAM_BATTING_BB','TEAM_BATTING_SO','TEAM_BASERUN_SB','TEAM_BASERUN_CS','TEAM_BATTING_HBP','TEAM_PITCHING_H','TEAM_PITCHING_HR','TEAM_PITCHING_BB','TEAM_PITCHING_SO','TEAM_FIELDING_E','TEAM_FIELDING_DP','TEAM_BATTING_1B')])
y=train$TARGET_WINS

# Ridge Regression

library(glmnet)
grid=10^seq(10,-2,length=100)
ridge.mod=glmnet(x,y,alpha=1,lambda=grid)
dim(coef(ridge.mod))
ridge.mod$lambda[50]
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2))
ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1,60]^2))
predict(ridge.mod,s=50,type="coefficients")[1:17,]
set.seed(1)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]
ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid, thresh=1e-12)
ridge.pred=predict(ridge.mod,s=4,newx=x[test,])
mean((ridge.pred-y.test)^2)
mean((mean(y[train])-y.test)^2)
ridge.pred=predict(ridge.mod,s=1e10,newx=x[test,])
mean((ridge.pred-y.test)^2)
ridge.pred=predict(ridge.mod,s=0,newx=x[test,],exact=T,x=x[train,],y=y[train])
mean((ridge.pred-y.test)^2)
lm(y~x, subset=train)
predict(ridge.mod,s=0,exact=T,type="coefficients",x=x[train,],y=y[train])[1:17,]
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam
ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)
out=glmnet(x,y,alpha=0)
predict(out,type="coefficients",s=bestlam)[1:17,]

train<-res$train

train$P_TARGET_WINSridge <- 19.7629740585 + 
  0.0222915007* train$TEAM_BATTING_H +
  0.0228671656* train$TEAM_BATTING_2B + 
  0.0688592357* train$TEAM_BATTING_3B +
  0.0263048514* train$TEAM_BATTING_HR +
  0.0125901452* train$TEAM_BATTING_BB +
  0.0168020444 * train$TEAM_BASERUN_SB +
  -0.0018993083* train$TEAM_BATTING_SO +
  0.0054956897* train$TEAM_BASERUN_CS +
  0.0604963111* train$TEAM_BATTING_HBP +
  -0.0014566078* train$TEAM_PITCHING_H +
  0.0237355146* train$TEAM_PITCHING_HR +
  0.0025179222* train$TEAM_PITCHING_BB +
  0.0009686851 * train$TEAM_PITCHING_SO  +
  -0.0143781736 * train$TEAM_FIELDING_E +
  -0.0748154947 * train$TEAM_FIELDING_DP +
  0.0162324575 * train$TEAM_BATTING_1B 

train$P_TARGET_WINSridge
mean(train$P_TARGET_WINSridge)
boxplot(train$P_TARGET_WINSridge)
summary(train$P_TARGET_WINSridge)
# The Lasso

lasso.mod=glmnet(x[train,],y[train],alpha=1,lambda=grid)
plot(lasso.mod)
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
lasso.pred=predict(lasso.mod,s=bestlam,newx=x[test,])
mean((lasso.pred-y.test)^2)
out=glmnet(x,y,alpha=1,lambda=grid)
lasso.coef=predict(out,type="coefficients",s=bestlam)[1:17,]
lasso.coef
lasso.coef[lasso.coef!=0]

train$P_TARGET_WINSlasso <- 13.4902860655 + 
  0.0464710914* train$TEAM_BATTING_H +
  0 * train$TEAM_BATTING_2B + 
  0.0268688862* train$TEAM_BATTING_3B +
  0.0107087068* train$TEAM_BATTING_HR +
  0.0175108231* train$TEAM_BATTING_BB +
  0.0196594009 * train$TEAM_BASERUN_SB +
  0* train$TEAM_BATTING_SO +
  0* train$TEAM_BASERUN_CS +
  0.0* train$TEAM_BATTING_HBP +
  -0.0009216324* train$TEAM_PITCHING_H +
  0.0094789634* train$TEAM_PITCHING_HR +
  0* train$TEAM_PITCHING_BB +
  0.0019737732 * train$TEAM_PITCHING_SO  +
  -0.0151787404  * train$TEAM_FIELDING_E +
  -0.0835613403 * train$TEAM_FIELDING_DP +
 0 * train$TEAM_BATTING_1B 

train$P_TARGET_WINSlasso
mean(train$P_TARGET_WINSlasso)
boxplot(train$P_TARGET_WINSlasso)
summary(train$P_TARGET_WINSlasso)
# The Bootstrap
library(boot)
train<-res$train
set.seed(1)
boot.fn=function(train,index)
  +return(coef(lm(train$TARGET_WINS~  TEAM_BATTING_1B + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
                    TEAM_BATTING_H + 
                    TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_PITCHING_HR + 
                    TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E + TEAM_FIELDING_DP + log_TEAM_BATTING_1B + 
                    SB_PCT + sqrt_TEAM_PITCHING_HR, data = train, subset=index)))
boot.fn(train,1:1593)

boot.fn(train, sample(1593,1593, replace = T))

train$P_TARGET_WINSboot <- 78.13573721 + 
  0.01640665 * train$TEAM_BATTING_2B + 
  0.14123853* train$TEAM_BATTING_3B +
  0.08894479 * train$TEAM_BATTING_HR +
  00.03239443* train$TEAM_BATTING_BB +
  0.02531498  * train$TEAM_BASERUN_SB +
  -0.01857807 * train$TEAM_BATTING_SO +
  -0.00778210* train$TEAM_BASERUN_CS +
  -0.06014367* train$TEAM_PITCHING_HR +
  -0.01491488* train$TEAM_PITCHING_BB +
  0.01082557 * train$TEAM_PITCHING_SO  +
  -0.04396129  * train$TEAM_FIELDING_E +
  -0.12571876 * train$TEAM_FIELDING_DP +
  0.05802006 * train$TEAM_BATTING_1B +
  -11.28122622 * train$log_TEAM_BATTING_1B +
  17.45916906 * train$SB_PCT +
  1.58766581 * 1.876559e+00 



train$P_TARGET_WINSboot
mean(train$P_TARGET_WINSboot)
boxplot(train$P_TARGET_WINSboot)

summary(train$P_TARGET_WINSboot)

#let's validate
validate<-res$validate
data(validate); require(glmnet)
x=as.matrix(validate[, c('TEAM_BATTING_H','TEAM_BATTING_2B','TEAM_BATTING_3B','TEAM_BATTING_HR','TEAM_BATTING_BB','TEAM_BATTING_SO','TEAM_BASERUN_SB','TEAM_BASERUN_CS','TEAM_BATTING_HBP','TEAM_PITCHING_H','TEAM_PITCHING_HR','TEAM_PITCHING_BB','TEAM_PITCHING_SO','TEAM_FIELDING_E','TEAM_FIELDING_E','TEAM_FIELDING_DP','TEAM_BATTING_1B')])
y=validate$TARGET_WINS



# Ridge Regression

library(glmnet)
grid=10^seq(10,-2,length=100)
ridge.mod=glmnet(x,y,alpha=0,lambda=grid)
dim(coef(ridge.mod))
ridge.mod$lambda[50]
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2))
ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1,60]^2))
predict(ridge.mod,s=50,type="coefficients")[1:17,]
set.seed(1)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]
ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid, thresh=1e-12)
ridge.pred=predict(ridge.mod,s=4,newx=x[test,])
mean((ridge.pred-y.test)^2)
mean((mean(y[train])-y.test)^2)
ridge.pred=predict(ridge.mod,s=1e10,newx=x[test,])
mean((ridge.pred-y.test)^2)
ridge.pred=predict(ridge.mod,s=0,newx=x[test,],exact=T,x=x[train,],y=y[train])
mean((ridge.pred-y.test)^2)
lm(y~x, subset=train)
predict(ridge.mod,s=0,exact=T,type="coefficients",x=x[train,],y=y[train])[1:17,]
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam
ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)
out=glmnet(x,y,alpha=0)
predict(out,type="coefficients",s=bestlam)[1:17,]

# The Lasso

lasso.mod=glmnet(x[train,],y[train],alpha=1,lambda=grid)
plot(lasso.mod)
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
lasso.pred=predict(lasso.mod,s=bestlam,newx=x[test,])
mean((lasso.pred-y.test)^2)
out=glmnet(x,y,alpha=1,lambda=grid)
lasso.coef=predict(out,type="coefficients",s=bestlam)[1:17,]
lasso.coef
lasso.coef[lasso.coef!=0]

validate<-res$validate
set.seed(1)
boot.fn=function(validate,index)
  +return(coef(lm(validate$TARGET_WINS~  TEAM_BATTING_1B + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
                    TEAM_BATTING_H + 
                    TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_PITCHING_HR + 
                    TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E + TEAM_FIELDING_DP + log_TEAM_BATTING_1B + 
                    SB_PCT + sqrt_TEAM_PITCHING_HR, data = validate, subset=index)))
boot.fn(validate,1:1593)

validateR<-boot.fn(validate, sample(1593,1593, replace = T))



#***Note at this point you may wish to also check to ensure outliers are imputed but not deleted***

#################### Part 3: Model Creation ############################################

#Function for Mean Square Error Calculation

#####
#Designated proper working environment on my computer. You will want to make sure it is in proper place for your computer.
#####

#################### Test Data ##########################

#we will use ridge regression
moneyball_test=read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 4\\buad5122-m4-moneyball-test.csv",header=T)

# Fixing na's
moneyball_test$TEAM_BATTING_1B <- moneyball_test$TEAM_BATTING_H - moneyball_test$TEAM_BATTING_HR -
moneyball_test$TEAM_BATTING_3B -moneyball_test$TEAM_BATTING_2B
moneyball_test$TEAM_BATTING_SO[is.na(moneyball_test$TEAM_BATTING_SO)] = mean(moneyball_test$TEAM_BATTING_SO, na.rm = TRUE)
moneyball_test$TEAM_BATTING_HBP[is.na(moneyball_test$TEAM_BATTING_HBP)] = mean(moneyball_test$TEAM_BATTING_HBP, na.rm = TRUE)
moneyball_test$TEAM_BASERUN_SB[is.na(moneyball_test$TEAM_BASERUN_SB)] = mean(moneyball_test$TEAM_BASERUN_SB, na.rm = TRUE)
moneyball_test$TEAM_BASERUN_CS[is.na(moneyball_test$TEAM_BASERUN_CS)] = mean(moneyball_test$TEAM_BASERUN_CS, na.rm = TRUE)
moneyball_test$TEAM_FIELDING_DP[is.na(moneyball_test$TEAM_FIELDING_DP)] = mean(moneyball_test$TEAM_FIELDING_DP, na.rm = TRUE)
moneyball_test$TEAM_PITCHING_SO[is.na(moneyball_test$TEAM_PITCHING_SO)] = mean(moneyball_test$TEAM_PITCHING_SO, na.rm = TRUE)
moneyball_test$TEAM_BASERUN_CS[moneyball_test$TEAM_BASERUN_CS < 1] = 1
moneyball_test$SB_PCT <- moneyball_test$TEAM_BASERUN_SB/(1.0*moneyball_test$TEAM_BASERUN_SB+moneyball_test$TEAM_BASERUN_CS)
moneyball_test$SB_PCT[is.na(moneyball_test$SB_PCT)] = mean(moneyball_test$SB_PCT)
moneyball_test$log_TEAM_BASERUN_CS <- log(moneyball_test$TEAM_BASERUN_CS)
moneyball_test$TEAM_PITCHING_BB[is.na(moneyball_test$TEAM_PITCHING_BB)] = mean(moneyball_test$TEAM_PITCHING_BB, na.rm = TRUE)
moneyball_test$TEAM_FIELDING_E[is.na(moneyball_test$TEAM_FIELDING_E)] = mean(moneyball_test$TEAM_FIELDING_E, na.rm = TRUE)
moneyball_test$TEAM_FIELDING_E[(moneyball_test$TEAM_FIELDING_E > 500)] = 500
summary(moneyball_test)

# Stand Alone Scoring
moneyball_test$P_TARGET_WINSridge <- 19.7629740585 + 
  0.0222915007* moneyball_test$TEAM_BATTING_H +
  0.0228671656* moneyball_test$TEAM_BATTING_2B + 
  0.0688592357* moneyball_test$TEAM_BATTING_3B +
  0.0263048514* moneyball_test$TEAM_BATTING_HR +
  0.0125901452* moneyball_test$TEAM_BATTING_BB +
  0.0168020444 * moneyball_test$TEAM_BASERUN_SB +
  -0.0018993083* moneyball_test$TEAM_BATTING_SO +
  0.0054956897* moneyball_test$TEAM_BASERUN_CS +
  0.0604963111* moneyball_test$TEAM_BATTING_HBP +
  -0.0014566078* moneyball_test$TEAM_PITCHING_H +
  0.0237355146* moneyball_test$TEAM_PITCHING_HR +
  0.0025179222* moneyball_test$TEAM_PITCHING_BB +
  0.0009686851 * moneyball_test$TEAM_PITCHING_SO  +
  -0.0143781736 * moneyball_test$TEAM_FIELDING_E +
  -0.0748154947 * moneyball_test$TEAM_FIELDING_DP +
  0.0162324575 * moneyball_test$TEAM_BATTING_1B 

moneyball_test$P_TARGET_WINS = ifelse(moneyball_test$P_TARGET_WINS>115, 115, moneyball_test$P_TARGET_WINS)
moneyball_test$P_TARGET_WINS = ifelse(moneyball_test$P_TARGET_WINS<35, 35, moneyball_test$P_TARGET_WINS)
  
#subset of data set for the deliverable "Scored data file"
prediction <- moneyball_test[c("INDEX","P_TARGET_WINS")]

#####
#Note, this next function will output a CSV file in your work environment called write.csv.
#####

#Prediction File 
write.csv(prediction, file = "C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 4\\prediction.csv")
mean(prediction$P_TARGET_WINS)
