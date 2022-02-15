#####
#Designated proper working environment on my computer. You will want to make sure it is in proper place for your computer.
#####
setwd("D:/Class/Online MSBA/ML1 Online/Mod2")
moneyball=read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 2\\buad5122-m2-moneyball-training.csv",header=T)
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
summary(moneyball) #have to correct for NA's and outliers

# Wins - Use lower bound for lower outliers, upper bound for higher outliers.
par(mfrow=c(1,2))
hist(moneyball$TARGET_WINS, col = "#A71930", xlab = "TARGET_WINS", main = "Histogram of Wins")
boxplot(moneyball$TARGET_WINS, col = "#A71930", main = "Boxplot of Wins") #significant outliers
par(mfrow = c(1,1))

#lets fix the lower bound of wins. The fewest wins ever for a 162 game season by percentage is 21.06. We will round up to 22 games won
moneyball$FlagWlow <- as.numeric(ifelse(moneyball$TARGET_WINS > 22, 0, 1)) 
moneyball$TARGET_WINS <- as.numeric(ifelse(moneyball$FlagWlow  == 1, quantile(moneyball$TARGET_WINS,c(.05)), moneyball$TARGET_WINS))
#lets fix the upper bound of wins. The most wins ever for a 162 game season by percentage is 123.606. We will round up to 124 games won
moneyball$FlagWhigh <- as.numeric(ifelse(moneyball$TARGET_WINS < 124, 0, 1)) 
moneyball$TARGET_WINS <- as.numeric(ifelse(moneyball$FlagWhigh  == 1, quantile(moneyball$TARGET_WINS,c(.95)), moneyball$TARGET_WINS))
################# Batting ####################
# Hits and Doubles
par(mfrow=c(2,2))
hist(moneyball$TEAM_BATTING_H, col = "#A71930", xlab = "Team_Batting_H", main = "Histogram of Hits")
hist(moneyball$TEAM_BATTING_2B, col = "#09ADAD", xlab = "Doubles", main = "Histogram of Doubles")
boxplot(moneyball$TEAM_BATTING_H, col = "#A71930", main = "Boxplot of Hits")
boxplot(moneyball$TEAM_BATTING_2B, col = "#09ADAD", main = "Boxplot of Doubles")
par(mfrow=c(1,1))

#lets fix the lower bound of hits. I can't find the lowest number of hits in a season, but the worst average is .240, and that team had 1300 hits
moneyball$FlagHlow <- as.numeric(ifelse(moneyball$TEAM_BATTING_H > 1300, 0, 1)) 
moneyball$TEAM_BATTING_H <- as.numeric(ifelse(moneyball$FlagHlow  == 1, quantile(moneyball$TEAM_BATTING_H,c(.05)), moneyball$TEAM_BATTING_H))
#lets fix the upper bound of hits. The most hits ever for a 162 game season by percentage is 1875. 
moneyball$FlagHhigh <- as.numeric(ifelse(moneyball$TEAM_BATTING_H < 1875, 0, 1)) 
moneyball$TEAM_BATTING_H <- as.numeric(ifelse(moneyball$FlagHhigh  == 1, quantile(moneyball$TEAM_BATTING_H,c(.95)), moneyball$TEAM_BATTING_H))


#lets fix the lower bound of 2B. Fewest in a season is 110
moneyball$Flag2Blow <- as.numeric(ifelse(moneyball$TEAM_BATTING_2B > 116, 0, 1)) 
moneyball$TEAM_BATTING_2B <- as.numeric(ifelse(moneyball$Flag2Blow  == 1, quantile(moneyball$TEAM_BATTING_2B,c(.05)), moneyball$TEAM_BATTING_2B))

#lets fix the lower bound of 2B. most in a season is 376
moneyball$Flag2Bhigh <- as.numeric(ifelse(moneyball$TEAM_BATTING_2B < 376, 0, 1)) 
moneyball$TEAM_BATTING_2B <- as.numeric(ifelse(moneyball$Flag2Bhigh  == 1, quantile(moneyball$TEAM_BATTING_2B,c(.95)), moneyball$TEAM_BATTING_2B))


# Triples and Home Runs
par(mfrow=c(2,2))
hist(moneyball$TEAM_BATTING_3B, col = "#A71930", xlab = "Triples", main = "Histogram of Triples")
hist(moneyball$TEAM_BATTING_HR, col = "#DBCEAC", xlab = "Home Runs", main = "Histogram of Home Runs")
boxplot(moneyball$TEAM_BATTING_3B, col = "#A71930", main = "Boxplot of Triples")
boxplot(moneyball$TEAM_BATTING_HR, col = "#DBCEAC", main = "Boxplot of Home Runs")
par(mfrow=c(1,1))


#lets fix the lower bound of 3B. Fewest in a season is 5
moneyball$Flag3Blow <- as.numeric(ifelse(moneyball$TEAM_BATTING_3B > 5, 0, 1)) 
moneyball$TEAM_BATTING_3B <- as.numeric(ifelse(moneyball$Flag3Blow  == 1, quantile(moneyball$TEAM_BATTING_3B,c(.05)), moneyball$TEAM_BATTING_3B))

#lets fix the lower bound of 3B. most in a season is 153
moneyball$Flag3Bhigh <- as.numeric(ifelse(moneyball$TEAM_BATTING_3B < 153, 0, 1)) 
moneyball$TEAM_BATTING_3B <- as.numeric(ifelse(moneyball$Flag3Bhigh  == 1, quantile(moneyball$TEAM_BATTING_3B,c(.95)), moneyball$TEAM_BATTING_3B))

#lets fix the lower bound of HR. Fewest in a season is 3
moneyball$FlagHRlow <- as.numeric(ifelse(moneyball$TEAM_BATTING_HR > 3, 0, 1)) 
moneyball$TEAM_BATTING_HR <- as.numeric(ifelse(moneyball$FlagHRlow  == 1, quantile(moneyball$TEAM_BATTING_HR,c(.05)), moneyball$TEAM_BATTING_HR))




# Walks, Strikeouts, HBP
par(mfrow=c(2,3))
hist(moneyball$TEAM_BATTING_BB, col = "#A71930", xlab = "Walks", main = "Histogram of Walks")
hist(moneyball$TEAM_BATTING_SO, col = "#09ADAD", xlab = "Strikeouts", main = "Histogram of Strikeouts")
hist(moneyball$TEAM_BATTING_HBP, col = "#DBCEAC", xlab = "Hit By Pitches", main = "Histogram of HBP")
boxplot(moneyball$TEAM_BATTING_BB, col = "#A71930", main = "Boxplot of Walks")
boxplot(moneyball$TEAM_BATTING_SO, col = "#09ADAD", main = "Boxplot of Strikeouts")
boxplot(moneyball$TEAM_BATTING_HBP, col = "#DBCEAC", main = "Boxplot of HBP")
par(mfrow=c(1,1))

##did not change bases on balls rules because the rules have changed so much

#lets change team strikout rules

moneyball$H_TO_SO_R<- moneyball$TEAM_BATTING_SO/moneyball$TEAM_BATTING_H
summary(moneyball$H_TO_SO_R)
x<-c(moneyball$H_TO_SO_R)
median_so_ratio<-median(x, na.rm = TRUE) #define the median ratio of strike outs to hits
moneyball$Flag_TEAM_BATTING_SO <- as.numeric(ifelse(is.na(moneyball$TEAM_BATTING_SO), 1, 0)) #create a flag that identifies the na values
moneyball$TEAM_BATTING_SO[is.na(moneyball$TEAM_BATTING_SO)] = (median_so_ratio*moneyball$TEAM_BATTING_H) #if they are flagged, have it being the median value


hist(moneyball$TEAM_BATTING_SO)
#now lets get rid of the zeros in strike outs

moneyball$Flag_TEAM_BATTING_SO_zero <- as.factor(ifelse(moneyball$TEAM_BATTING_SO != 0, 0, 1))
moneyball$TEAM_BATTING_SO <- as.numeric(ifelse(moneyball$Flag_TEAM_BATTING_SO_zero == 1, quantile(moneyball$TEAM_BATTING_SO,c(.05)), moneyball$TEAM_BATTING_SO)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

#now lets get rid of the zeros in strike outs

moneyball$Flag_TEAM_BATTING_BB_zero <- as.factor(ifelse(moneyball$TEAM_BATTING_BB != 0, 0, 1)) 
moneyball$TEAM_BATTING_BB <- as.numeric(ifelse(moneyball$Flag_TEAM_BATTING_BB_zero == 1, quantile(moneyball$TEAM_BATTING_BB,c(.05)), moneyball$TEAM_BATTING_BB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is


hist(moneyball$TEAM_BATTING_SO)

#team batting hit by pitch
#would not recommend putting in the model
moneyball$Flagbat_HBP <- as.factor(ifelse(is.na(moneyball$TEAM_BATTING_HBP), 1, 0)) #create a flag that identifies the missing values
moneyball$TEAM_BATTING_HBP[is.na(moneyball$TEAM_BATTING_HBP)] = median(moneyball$TEAM_BATTING_HBP, na.rm = TRUE) #if they are flagged, have it being the median value


# Stolen Bases and Caught Stealing
par(mfrow=c(2,2))
hist(moneyball$TEAM_BASERUN_SB, col = "#A71930", xlab = "Stolen Bases", main = "Histogram of Steals")
hist(moneyball$TEAM_BASERUN_CS, col = "#DBCEAC", xlab = "Caught Stealing", main = "Histogram of CS")
boxplot(moneyball$TEAM_BASERUN_SB, col = "#A71930", main = "Boxplot of Steals")
boxplot(moneyball$TEAM_BASERUN_CS, col = "#DBCEAC", main = "Boxplot of CS")
par(mfrow=c(1,1))

moneyball$SB_CS_R<- moneyball$TEAM_BASERUN_SB/moneyball$TEAM_BASERUN_CS
summary(moneyball$SB_CS_R)
x<-c(moneyball$SB_CS_R)
median_sb_ratio<-median(x, na.rm = TRUE) #define the median ratio
moneyball$Flag_TEAM_BASERUN_SB <- as.numeric(ifelse(is.na(moneyball$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
moneyball$TEAM_BASERUN_SB[is.na(moneyball$TEAM_BASERUN_SB)] = (median_sb_ratio*moneyball$TEAM_BASERUN_CS) #if they are flagged, have it being the ratio

moneyball$Flag_TEAM_BASERUN_SB2 <- as.numeric(ifelse(is.na(moneyball$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
moneyball$TEAM_BASERUN_SB[is.na(moneyball$TEAM_BASERUN_SB)] = median(moneyball$TEAM_BASERUN_SB, na.rm = TRUE) #if they are flagged, have it being the ratio


hist(moneyball$TEAM_BASERUN_SB)

moneyball$Flag_TEAM_BASERUN_SB_zero <- as.factor(ifelse(moneyball$TEAM_BASERUN_SB != 0, 0, 1)) 
moneyball$TEAM_BASERUN_SB <- as.numeric(ifelse(moneyball$Flag_TEAM_BASERUN_SB_zero == 1, quantile(moneyball$TEAM_BASERUN_SB,c(.05)), moneyball$TEAM_BASERUN_SB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

hist(moneyball$TEAM_BATTING_SO)

moneyball$FlagSB <- as.factor(ifelse(moneyball$TEAM_BASERUN_SB < 415, 0, 1)) #a team has stolen a max of 415 bases in a season, so if they have more lets return it to the 95th percentile
moneyball$TEAM_BASERUN_SB <- as.numeric(ifelse(moneyball$FlagSB  == 1, quantile(moneyball$TEAM_BASERUN_SB,c(.95)), moneyball$TEAM_BASERUN_SB))
#Lets get rid of the NA's in caught 

hist(moneyball$TEAM_BASERUN_SB)


#Let's fix caught stealing
#Lets get rid of the NA's
moneyball$SB_CS_R<- moneyball$TEAM_BASERUN_CS/moneyball$TEAM_BASERUN_SB
summary(moneyball$SB_CS_R)
x<-c(moneyball$SB_CS_R)
median_cs_ratio<-median(x, na.rm = TRUE) #define the median ratio
moneyball$Flag_TEAM_BASERUN_CS <- as.numeric(ifelse(is.na(moneyball$TEAM_BASERUN_CS), 1, 0)) #create a flag that identifies the na values
moneyball$TEAM_BASERUN_CS[is.na(moneyball$TEAM_BASERUN_CS)] = (median_cs_ratio*moneyball$TEAM_BASERUN_SB) #determine the number of times caught stealing by multiplying the ratio by the number of stolen bases they ran

boxplot(moneyball$TEAM_BASERUN_CS)

#lets fix the outliers
moneyball$FlagCS <- as.factor(ifelse(moneyball$TEAM_BASERUN_CS < 191, 0, 1)) 
moneyball$TEAM_BASERUN_CS <- as.numeric(ifelse(moneyball$FlagCS  == 1, quantile(moneyball$TEAM_BASERUN_CS,c(.95)), moneyball$TEAM_BASERUN_CS)) #no team has been caught stealing more than 191 times, so lets reduce from there
moneyball$FlagCS1 <- as.factor(ifelse(moneyball$TEAM_BASERUN_CS > 8, 0, 1))  #no team has been caught stealing more than 8 times, so lets reduce from there
moneyball$TEAM_BASERUN_CS <- as.numeric(ifelse(moneyball$FlagCS1  == 1, quantile(moneyball$TEAM_BASERUN_CS,c(.05)), moneyball$TEAM_BASERUN_CS)) 

################ Pitching ############
# Hits and Home Runs
par(mfrow=c(2,2))
hist(moneyball$TEAM_PITCHING_H, col = "#A71930", xlab = "Hits Against", main = "Histogram of Hits Against")
hist(moneyball$TEAM_PITCHING_HR, col = "#09ADAD", xlab = "Home Runs Against", main = "Histograms of HR Against")
boxplot(moneyball$TEAM_PITCHING_H, col = "#A71930", main = "Boxplot of Hits Against")
boxplot(moneyball$TEAM_PITCHING_HR, col = "#09ADAD", main = "Boxplot of HR Against")
par(mfrow=c(1,1))

#no team has hit more than 1,783 hits in a season, so we assume that a team has not given up that many as well

moneyball$FlagPH <- as.factor(ifelse(moneyball$TEAM_PITCHING_H < 1783, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
moneyball$TEAM_PITCHING_H <- as.numeric(ifelse(moneyball$FlagPH  == 1, quantile(moneyball$TEAM_PITCHING_H,c(.90)), moneyball$TEAM_PITCHING_H)) 


#lets fix team pitching HR, we will say three as that is the least amount of homeruns a team has ever had
moneyball$FlagPHR <- as.factor(ifelse(moneyball$TEAM_PITCHING_HR > 3, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
moneyball$TEAM_PITCHING_HR <- as.numeric(ifelse(moneyball$FlagPHR  == 1, quantile(moneyball$TEAM_PITCHING_HR,c(.90)), moneyball$TEAM_PITCHING_HR)) 


# Walks and Strikeouts #would not recommend using strike outs
par(mfrow=c(2,2))
hist(moneyball$TEAM_PITCHING_BB, col = "#A71930", xlab = "Walks Allowed", main = "Histogram of Walks Allowed")
hist(moneyball$TEAM_PITCHING_SO, col = "#DBCEAC", xlab = "Strikeouts", main = "Histograms of Strikeouts")
boxplot(moneyball$TEAM_PITCHING_BB, col = "#A71930", main = "Boxplot of Walks Allowed")
boxplot(moneyball$TEAM_PITCHING_SO, col = "#DBCEAC", main = "Boxplot of Strikeouts")
par(mfrow=c(1,1))

x<-IQR(moneyball$TEAM_PITCHING_BB)
y<-quantile(moneyball$TEAM_PITCHING_BB, .25)
lb<-(y-(1.5*x))
a<-IQR(moneyball$TEAM_PITCHING_BB)
b<-quantile(moneyball$TEAM_PITCHING_BB, .75)
lb1<-(b+(1.5*a))
lb1
lb
moneyball$FlagPBB <- as.factor(ifelse(moneyball$TEAM_PITCHING_BB > lb, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball$TEAM_PITCHING_BB <- as.numeric(ifelse(moneyball$FlagPBB  == 1, quantile(moneyball$TEAM_PITCHING_BB,c(.10)), moneyball$TEAM_PITCHING_BB)) 
moneyball$FlagPBB1 <- as.factor(ifelse(moneyball$TEAM_PITCHING_BB < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball$TEAM_PITCHING_BB <- as.numeric(ifelse(moneyball$FlagPBB1  == 1, quantile(moneyball$TEAM_PITCHING_BB,c(.90)), moneyball$TEAM_PITCHING_BB)) 

x<-c(moneyball$TEAM_PITCHING_SO)
median<-median(x, na.rm = TRUE) #define the median ratio
moneyball$Flag_TEAM_Pitching_strikeouts <- as.numeric(ifelse(is.na(moneyball$TEAM_PITCHING_SO), 1, 0)) #create a flag that identifies the na values
moneyball$TEAM_PITCHING_SO[is.na(moneyball$TEAM_PITCHING_SO)] = (median) 


x<-IQR(moneyball$TEAM_PITCHING_SO)
y<-quantile(moneyball$TEAM_PITCHING_SO, .25)
lb<-(y-(1.5*x))

lb
moneyball$FlagPSO <- as.factor(ifelse(moneyball$TEAM_PITCHING_SO > lb, 0, 1))#since the range is so wide, let adjust using the IQR
moneyball$TEAM_PITCHING_SO <- as.numeric(ifelse(moneyball$FlagPSO  == 1, quantile(moneyball$TEAM_PITCHING_SO,c(.10)), moneyball$TEAM_PITCHING_SO)) 
moneyball$FlagPSO1 <- as.factor(ifelse(moneyball$TEAM_PITCHING_SO < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball$TEAM_PITCHING_SO <- as.numeric(ifelse(moneyball$FlagPSO1  == 1, quantile(moneyball$TEAM_PITCHING_SO,c(.90)), moneyball$TEAM_PITCHING_SO)) 

############## Fielding ###########
# Double Plays and Errors 
par(mfrow=c(2,2))
hist(moneyball$TEAM_FIELDING_DP, col = "#A71930", xlab = "Double Plays", main = "Histogram of Double Plays")
hist(moneyball$TEAM_FIELDING_E, col = "#09ADAD", xlab = "Errors Committed", main = "Histogram of Errors Committed")
boxplot(moneyball$TEAM_FIELDING_DP, col = "#A71930", main = "Boxplot of Double Plays")
boxplot(moneyball$TEAM_FIELDING_E, col = "#09ADAD", main = "Boxplot of Errors Committed")
par(mfrow=c(1,1))

boxplot(moneyball$TEAM_FIELDING_E)

a<-IQR(moneyball$TEAM_FIELDING_E)
b<-quantile(moneyball$TEAM_FIELDING_E, .75)
lb1<-(b+(1.5*a))
lb1
moneyball$FlagE <- as.factor(ifelse(moneyball$TEAM_FIELDING_E < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball$TEAM_FIELDING_E <- as.numeric(ifelse(moneyball$FlagE  == 1, quantile(moneyball$TEAM_FIELDING_E,c(.90)), moneyball$TEAM_FIELDING_E)) 


#lets fix double plays
boxplot(moneyball$TEAM_FIELDING_DP)
hist(moneyball$TEAM_FIELDING_DP) #seems evenly disributed. let's just fix the NA's


x<-c(moneyball$TEAM_FIELDING_DP)
median<-median(x, na.rm = TRUE) #define the median ratio
moneyball$flag_DP <- as.numeric(ifelse(is.na(moneyball$TEAM_FIELDING_DP), 1, 0)) #create a flag that identifies the na values, and adjust them to be the median
moneyball$TEAM_FIELDING_DP[is.na(moneyball$TEAM_FIELDING_DP)] = (median) 

summary(moneyball)

moneyball<-moneyball[-c(18:48)]
summary(moneyball)

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

#Straighten Relationships
moneyball$TEAM_BATTING_1B <- moneyball$TEAM_BATTING_H - moneyball$TEAM_BATTING_HR - moneyball$TEAM_BATTING_3B -
  moneyball$TEAM_BATTING_2B
moneyball$log_TEAM_BATTING_1B <- log(moneyball$TEAM_BATTING_1B)
moneyball$log_TEAM_BATTING_3B <- log(moneyball$TEAM_BATTING_3B)
moneyball$log_TEAM_BASERUN_SB <- log(moneyball$TEAM_BASERUN_SB)
moneyball$log_TEAM_BASERUN_CS <- log(moneyball$TEAM_BASERUN_CS)
moneyball$log_TEAM_BATTING_2B <- log(moneyball$TEAM_BATTING_2B)
moneyball$log_TEAM_BATTING_1B <- log(moneyball$TEAM_BATTING_1B)
moneyball$log_TEAM_BATTING_HR <- log(moneyball$TEAM_BATTING_HR)*-1
moneyball$log_TEAM_PITCHING_HR<- log(moneyball$TEAM_PITCHING_HR)*2
moneyball$log_TEAM_PITCHING_H<- log(moneyball$TEAM_PITCHING_H)
moneyball$log_TEAM_FIELDING_E<- log(moneyball$TEAM_FIELDING_E)
moneyball$TEAM_FIELDING_E[(moneyball$TEAM_FIELDING_E > 500)] = 500
moneyball$sqrt_TEAM_PITCHING_HR <- sqrt(moneyball$TEAM_PITCHING_HR)
moneyball$SB_PCT <- moneyball$TEAM_BASERUN_SB/(1.0*moneyball$TEAM_BASERUN_SB+moneyball$TEAM_BASERUN_CS)
moneyball$SB_PCT[is.na(moneyball$SB_PCT)] = mean(moneyball$SB_PCT, na.rm = TRUE)

#Check that na's are gone. 
summary(moneyball)

#***Note at this point you may wish to also check to ensure outliers are imputed but not deleted***

#################### Part 3: Model Creation ############################################

#Function for Mean Square Error Calculation
mse <- function(sm) 
  mean(sm$residuals^2)

# TC model
pitchratio<-log(moneyball$TEAM_PITCHING_SO/moneyball$TEAM_PITCHING_BB)
AVG<-log(moneyball$TEAM_BATTING_H/5555)*-1
homerunratio <-log(moneyball$TEAM_BATTING_HR/moneyball$TEAM_PITCHING_HR)*-1
slugging<- log(moneyball$TEAM_BATTING_1B+(2*moneyball$TEAM_BATTING_2B)+(3*moneyball$TEAM_BATTING_3B)+(4*moneyball$TEAM_BATTING_HR))/5555 #avg number of bats in a 162 game season
onbase <- log((moneyball$TEAM_BATTING_BB*2)+ moneyball$TEAM_BATTING_1B+(2*moneyball$TEAM_BATTING_2B)+(3*moneyball$TEAM_BATTING_3B)+(4*moneyball$TEAM_BATTING_HR))
defense<-log((moneyball$TEAM_FIELDING_DP*1)+(moneyball$TEAM_PITCHING_SO*1)) *-1
bad_defense<-log((moneyball$TEAM_PITCHING_BB*1+(moneyball$TEAM_PITCHING_H*2)+moneyball$TEAM_PITCHING_HR*4+(moneyball$TEAM_FIELDING_E*20)))
strikeoutavg<-log(moneyball$TEAM_PITCHING_SO/162)
numofnothing<-(5555-(moneyball$TEAM_BATTING_H+moneyball$TEAM_BATTING_HBP+moneyball$TEAM_BATTING_SO+moneyball$TEAM_BATTING_BB))#5555 is the avg number of at bats in an mlb season. trying to determine how many times a player gets out not counting the stats available
WHIP<-log((moneyball$TEAM_PITCHING_BB+moneyball$TEAM_PITCHING_H)/(162*9))
OBP<-(log(moneyball$TEAM_BATTING_H+moneyball$TEAM_BATTING_BB+moneyball$TEAM_BATTING_HBP/5555)*-1)^2
BA<- log(moneyball$TEAM_BATTING_H/(moneyball$TEAM_BATTING_HBP+moneyball$TEAM_BATTING_SO+moneyball$TEAM_BATTING_BB+numofnothing))*-1
OBPSLG<-OBP+slugging
OBPSLGfour<-OBPSLG^4
slugpgame<-slugging/162
obppgame<-OBP/162 * -1
runprediction<-log((moneyball$TEAM_BATTING_H/162)/1.87) #average number of hits per run
opprp<-log((moneyball$TEAM_PITCHING_H/162)/1.87)
score<-runprediction-opprp
mult<-score*opprp*runprediction
ln(score)
pitchouts<-log(5555-(moneyball$TEAM_PITCHING_H+moneyball$TEAM_PITCHING_BB))
OBPSLGgame<-log(OBPSLG/162)
totalbases<- log(moneyball$TEAM_BATTING_1B+(moneyball$TEAM_BATTING_2B*2)+(moneyball$TEAM_BATTING_3B*3)+(moneyball$TEAM_BATTING_HR*4))


#model 1
stepwisemodel <- lm(formula = TARGET_WINS ~ OBPSLGfour * mult * score + opprp * runprediction * pitchouts * totalbases  * slugpgame * pitchratio + AVG + OBPSLG * BA + OBP * WHIP + bad_defense  + defense+ slugging * homerunratio * 
                      moneyball$SB_PCT+log_TEAM_BASERUN_SB  + moneyball$log_TEAM_BATTING_2B + moneyball$log_TEAM_BATTING_1B + moneyball$log_TEAM_BATTING_3B + moneyball$log_TEAM_BATTING_HR +
                      moneyball$log_TEAM_PITCHING_HR + log_TEAM_PITCHING_H +
                      moneyball$log_TEAM_FIELDING_E * log(pitchouts), data = moneyball)
stepwise <- stepAIC(stepwisemodel, direction = "both")
stepwise
summary(stepwise)

#model 2
stepwisemodel2 <- lm(formula = TARGET_WINS ~ OBPSLGfour * mult * score + opprp * runprediction * pitchouts * totalbases  * slugpgame * pitchratio + AVG + OBPSLG * BA + OBP * WHIP + bad_defense  + defense+ slugging * homerunratio * 
                      moneyball$SB_PCT+log_TEAM_BASERUN_SB  + moneyball$log_TEAM_BATTING_2B + moneyball$log_TEAM_BATTING_1B + moneyball$log_TEAM_BATTING_3B + moneyball$log_TEAM_BATTING_HR +
                      moneyball$log_TEAM_PITCHING_HR + log_TEAM_PITCHING_H +
                      moneyball$log_TEAM_FIELDING_E, data = moneyball)
stepwise2 <- stepAIC(stepwisemodel2, direction = "both")
stepwise2
summary(stepwise2)


#model 3
stepwisemodel3 <- lm(formula = TARGET_WINS ~ OBPSLGfour + mult+ score + opprp + runprediction * pitchouts * totalbases  * slugpgame * pitchratio + AVG + OBPSLG * BA + bad_defense  + defense+ slugging * homerunratio * 
                       moneyball$SB_PCT+log_TEAM_BASERUN_SB  + moneyball$log_TEAM_BATTING_2B + moneyball$log_TEAM_BATTING_1B + moneyball$log_TEAM_BATTING_3B + moneyball$log_TEAM_BATTING_HR +
                       moneyball$log_TEAM_PITCHING_HR + log_TEAM_PITCHING_H +
                       moneyball$log_TEAM_FIELDING_E, data = moneyball)
stepwise3 <- stepAIC(stepwisemodel3, direction = "both")
stepwise3
summary(stepwise3)


######## Performance #######
AIC(stepwise)
AIC(stepwise2)
AIC(stepwise3)
mse(stepwise)
mse(stepwise2)
mse(stepwise3)

#####
#Designated proper working environment on my computer. You will want to make sure it is in proper place for your computer.
#####

#################### Test Data ########################## #you incorporate it from the training dataset
moneyball_test=read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 2\\buad5122-m2-moneyball-test.csv",header=T)

summary(moneyball_test) #have to correct for NA's and outliers

# Wins - Use lower bound for lower outliers, upper bound for higher outliers.
par(mfrow=c(1,2))
hist(moneyball_test$TARGET_WINS, col = "#A71930", xlab = "TARGET_WINS", main = "Histogram of Wins")
boxplot(moneyball_test$TARGET_WINS, col = "#A71930", main = "Boxplot of Wins") #significant outliers
par(mfrow = c(1,1))

#lets fix the lower bound of wins. The fewest wins ever for a 162 game season by percentage is 21.06. We will round up to 22 games won
moneyball_test$FlagWlow <- as.numeric(ifelse(moneyball_test$TARGET_WINS > 22, 0, 1)) 
moneyball_test$TARGET_WINS <- as.numeric(ifelse(moneyball_test$FlagWlow  == 1, quantile(moneyball_test$TARGET_WINS,c(.05)), moneyball_test$TARGET_WINS))
#lets fix the upper bound of wins. The most wins ever for a 162 game season by percentage is 123.606. We will round up to 124 games won
moneyball_test$FlagWhigh <- as.numeric(ifelse(moneyball_test$TARGET_WINS < 124, 0, 1)) 
moneyball_test$TARGET_WINS <- as.numeric(ifelse(moneyball_test$FlagWhigh  == 1, quantile(moneyball_test$TARGET_WINS,c(.95)), moneyball_test$TARGET_WINS))
################# Batting ####################
# Hits and Doubles
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_BATTING_H, col = "#A71930", xlab = "Team_Batting_H", main = "Histogram of Hits")
hist(moneyball_test$TEAM_BATTING_2B, col = "#09ADAD", xlab = "Doubles", main = "Histogram of Doubles")
boxplot(moneyball_test$TEAM_BATTING_H, col = "#A71930", main = "Boxplot of Hits")
boxplot(moneyball_test$TEAM_BATTING_2B, col = "#09ADAD", main = "Boxplot of Doubles")
par(mfrow=c(1,1))

#lets fix the lower bound of hits. I can't find the lowest number of hits in a season, but the worst average is .240, and that team had 1300 hits
moneyball_test$FlagHlow <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_H > 1300, 0, 1)) 
moneyball_test$TEAM_BATTING_H <- as.numeric(ifelse(moneyball_test$FlagHlow  == 1, quantile(moneyball_test$TEAM_BATTING_H,c(.05)), moneyball_test$TEAM_BATTING_H))
#lets fix the upper bound of hits. The most hits ever for a 162 game season by percentage is 1875. 
moneyball_test$FlagHhigh <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_H < 1875, 0, 1)) 
moneyball_test$TEAM_BATTING_H <- as.numeric(ifelse(moneyball_test$FlagHhigh  == 1, quantile(moneyball_test$TEAM_BATTING_H,c(.95)), moneyball_test$TEAM_BATTING_H))


#lets fix the lower bound of 2B. Fewest in a season is 110
moneyball_test$Flag2Blow <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_2B > 116, 0, 1)) 
moneyball_test$TEAM_BATTING_2B <- as.numeric(ifelse(moneyball_test$Flag2Blow  == 1, quantile(moneyball_test$TEAM_BATTING_2B,c(.05)), moneyball_test$TEAM_BATTING_2B))

#lets fix the lower bound of 2B. most in a season is 376
moneyball_test$Flag2Bhigh <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_2B < 376, 0, 1)) 
moneyball_test$TEAM_BATTING_2B <- as.numeric(ifelse(moneyball_test$Flag2Bhigh  == 1, quantile(moneyball_test$TEAM_BATTING_2B,c(.95)), moneyball_test$TEAM_BATTING_2B))


# Triples and Home Runs
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_BATTING_3B, col = "#A71930", xlab = "Triples", main = "Histogram of Triples")
hist(moneyball_test$TEAM_BATTING_HR, col = "#DBCEAC", xlab = "Home Runs", main = "Histogram of Home Runs")
boxplot(moneyball_test$TEAM_BATTING_3B, col = "#A71930", main = "Boxplot of Triples")
boxplot(moneyball_test$TEAM_BATTING_HR, col = "#DBCEAC", main = "Boxplot of Home Runs")
par(mfrow=c(1,1))


#lets fix the lower bound of 3B. Fewest in a season is 5
moneyball_test$Flag3Blow <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_3B > 5, 0, 1)) 
moneyball_test$TEAM_BATTING_3B <- as.numeric(ifelse(moneyball_test$Flag3Blow  == 1, quantile(moneyball_test$TEAM_BATTING_3B,c(.05)), moneyball_test$TEAM_BATTING_3B))

#lets fix the lower bound of 3B. most in a season is 153
moneyball_test$Flag3Bhigh <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_3B < 153, 0, 1)) 
moneyball_test$TEAM_BATTING_3B <- as.numeric(ifelse(moneyball_test$Flag3Bhigh  == 1, quantile(moneyball_test$TEAM_BATTING_3B,c(.95)), moneyball_test$TEAM_BATTING_3B))

#lets fix the lower bound of HR. Fewest in a season is 3
moneyball_test$FlagHRlow <- as.numeric(ifelse(moneyball_test$TEAM_BATTING_HR > 3, 0, 1)) 
moneyball_test$TEAM_BATTING_HR <- as.numeric(ifelse(moneyball_test$FlagHRlow  == 1, quantile(moneyball_test$TEAM_BATTING_HR,c(.05)), moneyball_test$TEAM_BATTING_HR))




# Walks, Strikeouts, HBP
par(mfrow=c(2,3))
hist(moneyball_test$TEAM_BATTING_BB, col = "#A71930", xlab = "Walks", main = "Histogram of Walks")
hist(moneyball_test$TEAM_BATTING_SO, col = "#09ADAD", xlab = "Strikeouts", main = "Histogram of Strikeouts")
hist(moneyball_test$TEAM_BATTING_HBP, col = "#DBCEAC", xlab = "Hit By Pitches", main = "Histogram of HBP")
boxplot(moneyball_test$TEAM_BATTING_BB, col = "#A71930", main = "Boxplot of Walks")
boxplot(moneyball_test$TEAM_BATTING_SO, col = "#09ADAD", main = "Boxplot of Strikeouts")
boxplot(moneyball_test$TEAM_BATTING_HBP, col = "#DBCEAC", main = "Boxplot of HBP")
par(mfrow=c(1,1))

##did not change bases on balls rules because the rules have changed so much

#lets change team strikout rules

moneyball_test$H_TO_SO_R<- moneyball_test$TEAM_BATTING_SO/moneyball_test$TEAM_BATTING_H
summary(moneyball_test$H_TO_SO_R)
x<-c(moneyball_test$H_TO_SO_R)
median_so_ratio<-median(x, na.rm = TRUE) #define the median ratio of strike outs to hits
moneyball_test$Flag_TEAM_BATTING_SO <- as.numeric(ifelse(is.na(moneyball_test$TEAM_BATTING_SO), 1, 0)) #create a flag that identifies the na values
moneyball_test$TEAM_BATTING_SO[is.na(moneyball_test$TEAM_BATTING_SO)] = (median_so_ratio*moneyball_test$TEAM_BATTING_H) #if they are flagged, have it being the median value


hist(moneyball_test$TEAM_BATTING_SO)
#now lets get rid of the zeros in strike outs

moneyball_test$Flag_TEAM_BATTING_SO_zero <- as.factor(ifelse(moneyball_test$TEAM_BATTING_SO != 0, 0, 1))
moneyball_test$TEAM_BATTING_SO <- as.numeric(ifelse(moneyball_test$Flag_TEAM_BATTING_SO_zero == 1, quantile(moneyball_test$TEAM_BATTING_SO,c(.05)), moneyball_test$TEAM_BATTING_SO)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

#now lets get rid of the zeros in strike outs

moneyball_test$Flag_TEAM_BATTING_BB_zero <- as.factor(ifelse(moneyball_test$TEAM_BATTING_BB != 0, 0, 1)) 
moneyball_test$TEAM_BATTING_BB <- as.numeric(ifelse(moneyball_test$Flag_TEAM_BATTING_BB_zero == 1, quantile(moneyball_test$TEAM_BATTING_BB,c(.05)), moneyball_test$TEAM_BATTING_BB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is


hist(moneyball_test$TEAM_BATTING_SO)

#team batting hit by pitch
#would not recommend putting in the model
moneyball_test$Flagbat_HBP <- as.factor(ifelse(is.na(moneyball_test$TEAM_BATTING_HBP), 1, 0)) #create a flag that identifies the missing values
moneyball_test$TEAM_BATTING_HBP[is.na(moneyball_test$TEAM_BATTING_HBP)] = median(moneyball$TEAM_BATTING_HBP, na.rm = TRUE) #if they are flagged, have it being the median value


# Stolen Bases and Caught Stealing
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_BASERUN_SB, col = "#A71930", xlab = "Stolen Bases", main = "Histogram of Steals")
hist(moneyball_test$TEAM_BASERUN_CS, col = "#DBCEAC", xlab = "Caught Stealing", main = "Histogram of CS")
boxplot(moneyball_test$TEAM_BASERUN_SB, col = "#A71930", main = "Boxplot of Steals")
boxplot(moneyball_test$TEAM_BASERUN_CS, col = "#DBCEAC", main = "Boxplot of CS")
par(mfrow=c(1,1))

moneyball_test$SB_CS_R<- moneyball_test$TEAM_BASERUN_SB/moneyball_test$TEAM_BASERUN_CS
summary(moneyball_test$SB_CS_R)
x<-c(moneyball_test$SB_CS_R)
median_sb_ratio<-median(x, na.rm = TRUE) #define the median ratio
moneyball_test$Flag_TEAM_BASERUN_SB <- as.numeric(ifelse(is.na(moneyball_test$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
moneyball_test$TEAM_BASERUN_SB[is.na(moneyball_test$TEAM_BASERUN_SB)] = (median_sb_ratio*moneyball_test$TEAM_BASERUN_CS) #if they are flagged, have it being the ratio

moneyball_test$Flag_TEAM_BASERUN_SB2 <- as.numeric(ifelse(is.na(moneyball_test$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
moneyball_test$TEAM_BASERUN_SB[is.na(moneyball_test$TEAM_BASERUN_SB)] = median(moneyball_test$TEAM_BASERUN_SB, na.rm = TRUE) #if they are flagged, have it being the ratio


hist(moneyball_test$TEAM_BASERUN_SB)

moneyball_test$Flag_TEAM_BASERUN_SB_zero <- as.factor(ifelse(moneyball_test$TEAM_BASERUN_SB != 0, 0, 1)) 
moneyball_test$TEAM_BASERUN_SB <- as.numeric(ifelse(moneyball_test$Flag_TEAM_BASERUN_SB_zero == 1, quantile(moneyball_test$TEAM_BASERUN_SB,c(.05)), moneyball_test$TEAM_BASERUN_SB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

hist(moneyball_test$TEAM_BATTING_SO)

moneyball_test$FlagSB <- as.factor(ifelse(moneyball_test$TEAM_BASERUN_SB < 415, 0, 1)) #a team has stolen a max of 415 bases in a season, so if they have more lets return it to the 95th percentile
moneyball_test$TEAM_BASERUN_SB <- as.numeric(ifelse(moneyball_test$FlagSB  == 1, quantile(moneyball_test$TEAM_BASERUN_SB,c(.95)), moneyball_test$TEAM_BASERUN_SB))
#Lets get rid of the NA's in caught 

hist(moneyball_test$TEAM_BASERUN_SB)


#Let's fix caught stealing
#Lets get rid of the NA's
moneyball_test$SB_CS_R<- moneyball_test$TEAM_BASERUN_CS/moneyball_test$TEAM_BASERUN_SB
summary(moneyball_test$SB_CS_R)
x<-c(moneyball_test$SB_CS_R)
median_cs_ratio<-median(x, na.rm = TRUE) #define the median ratio
moneyball_test$Flag_TEAM_BASERUN_CS <- as.numeric(ifelse(is.na(moneyball_test$TEAM_BASERUN_CS), 1, 0)) #create a flag that identifies the na values
moneyball_test$TEAM_BASERUN_CS[is.na(moneyball_test$TEAM_BASERUN_CS)] = (median_cs_ratio*moneyball_test$TEAM_BASERUN_SB) #determine the number of times caught stealing by multiplying the ratio by the number of stolen bases they ran

boxplot(moneyball_test$TEAM_BASERUN_CS)

#lets fix the outliers
moneyball_test$FlagCS <- as.factor(ifelse(moneyball_test$TEAM_BASERUN_CS < 191, 0, 1)) 
moneyball_test$TEAM_BASERUN_CS <- as.numeric(ifelse(moneyball_test$FlagCS  == 1, quantile(moneyball_test$TEAM_BASERUN_CS,c(.95)), moneyball_test$TEAM_BASERUN_CS)) #no team has been caught stealing more than 191 times, so lets reduce from there
moneyball_test$FlagCS1 <- as.factor(ifelse(moneyball_test$TEAM_BASERUN_CS > 8, 0, 1))  #no team has been caught stealing more than 8 times, so lets reduce from there
moneyball_test$TEAM_BASERUN_CS <- as.numeric(ifelse(moneyball_test$FlagCS1  == 1, quantile(moneyball_test$TEAM_BASERUN_CS,c(.05)), moneyball_test$TEAM_BASERUN_CS)) 

################ Pitching ############
# Hits and Home Runs
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_PITCHING_H, col = "#A71930", xlab = "Hits Against", main = "Histogram of Hits Against")
hist(moneyball_test$TEAM_PITCHING_HR, col = "#09ADAD", xlab = "Home Runs Against", main = "Histograms of HR Against")
boxplot(moneyball_test$TEAM_PITCHING_H, col = "#A71930", main = "Boxplot of Hits Against")
boxplot(moneyball_test$TEAM_PITCHING_HR, col = "#09ADAD", main = "Boxplot of HR Against")
par(mfrow=c(1,1))

#no team has hit more than 1,783 hits in a season, so we assume that a team has not given up that many as well

moneyball_test$FlagPH <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_H < 1783, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
moneyball_test$TEAM_PITCHING_H <- as.numeric(ifelse(moneyball_test$FlagPH  == 1, quantile(moneyball_test$TEAM_PITCHING_H,c(.90)), moneyball_test$TEAM_PITCHING_H)) 


#lets fix team pitching HR, we will say three as that is the least amount of homeruns a team has ever had
moneyball_test$FlagPHR <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_HR > 3, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
moneyball_test$TEAM_PITCHING_HR <- as.numeric(ifelse(moneyball_test$FlagPHR  == 1, quantile(moneyball_test$TEAM_PITCHING_HR,c(.90)), moneyball_test$TEAM_PITCHING_HR)) 


# Walks and Strikeouts #would not recommend using strike outs
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_PITCHING_BB, col = "#A71930", xlab = "Walks Allowed", main = "Histogram of Walks Allowed")
hist(moneyball_test$TEAM_PITCHING_SO, col = "#DBCEAC", xlab = "Strikeouts", main = "Histograms of Strikeouts")
boxplot(moneyball_test$TEAM_PITCHING_BB, col = "#A71930", main = "Boxplot of Walks Allowed")
boxplot(moneyball_test$TEAM_PITCHING_SO, col = "#DBCEAC", main = "Boxplot of Strikeouts")
par(mfrow=c(1,1))

x<-IQR(moneyball_test$TEAM_PITCHING_BB)
y<-quantile(moneyball_test$TEAM_PITCHING_BB, .25)
lb<-(y-(1.5*x))
a<-IQR(moneyball_test$TEAM_PITCHING_BB)
b<-quantile(moneyball_test$TEAM_PITCHING_BB, .75)
lb1<-(b+(1.5*a))
lb1
lb
moneyball_test$FlagPBB <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_BB > lb, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball_test$TEAM_PITCHING_BB <- as.numeric(ifelse(moneyball_test$FlagPBB  == 1, quantile(moneyball_test$TEAM_PITCHING_BB,c(.10)), moneyball_test$TEAM_PITCHING_BB)) 
moneyball_test$FlagPBB1 <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_BB < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball_test$TEAM_PITCHING_BB <- as.numeric(ifelse(moneyball_test$FlagPBB1  == 1, quantile(moneyball_test$TEAM_PITCHING_BB,c(.90)), moneyball_test$TEAM_PITCHING_BB)) 

x<-c(moneyball$TEAM_PITCHING_SO)
median<-median(x, na.rm = TRUE) #define the median ratio
moneyball_test$Flag_TEAM_Pitching_strikeouts <- as.numeric(ifelse(is.na(moneyball_test$TEAM_PITCHING_SO), 1, 0)) #create a flag that identifies the na values
moneyball_test$TEAM_PITCHING_SO[is.na(moneyball_test$TEAM_PITCHING_SO)] = (median) 


x<-IQR(moneyball_test$TEAM_PITCHING_SO)
y<-quantile(moneyball_test$TEAM_PITCHING_SO, .25)
lb<-(y-(1.5*x))

lb
moneyball_test$FlagPSO <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_SO > lb, 0, 1))#since the range is so wide, let adjust using the IQR
moneyball_test$TEAM_PITCHING_SO <- as.numeric(ifelse(moneyball_test$FlagPSO  == 1, quantile(moneyball_test$TEAM_PITCHING_SO,c(.10)), moneyball_test$TEAM_PITCHING_SO)) 
moneyball_test$FlagPSO1 <- as.factor(ifelse(moneyball_test$TEAM_PITCHING_SO < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball_test$TEAM_PITCHING_SO <- as.numeric(ifelse(moneyball_test$FlagPSO1  == 1, quantile(moneyball_test$TEAM_PITCHING_SO,c(.90)), moneyball_test$TEAM_PITCHING_SO)) 

############## Fielding ###########
# Double Plays and Errors 
par(mfrow=c(2,2))
hist(moneyball_test$TEAM_FIELDING_DP, col = "#A71930", xlab = "Double Plays", main = "Histogram of Double Plays")
hist(moneyball_test$TEAM_FIELDING_E, col = "#09ADAD", xlab = "Errors Committed", main = "Histogram of Errors Committed")
boxplot(moneyball_test$TEAM_FIELDING_DP, col = "#A71930", main = "Boxplot of Double Plays")
boxplot(moneyball_test$TEAM_FIELDING_E, col = "#09ADAD", main = "Boxplot of Errors Committed")
par(mfrow=c(1,1))

boxplot(moneyball_test$TEAM_FIELDING_E)

a<-IQR(moneyball_test$TEAM_FIELDING_E)
b<-quantile(moneyball_test$TEAM_FIELDING_E, .75)
lb1<-(b+(1.5*a))
lb1
moneyball_test$FlagE <- as.factor(ifelse(moneyball_test$TEAM_FIELDING_E < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
moneyball_test$TEAM_FIELDING_E <- as.numeric(ifelse(moneyball_test$FlagE  == 1, quantile(moneyball_test$TEAM_FIELDING_E,c(.90)), moneyball_test$TEAM_FIELDING_E)) 


#lets fix double plays
boxplot(moneyball_test$TEAM_FIELDING_DP)
hist(moneyball_test$TEAM_FIELDING_DP) #seems evenly disributed. let's just fix the NA's


x<-c(moneyball$TEAM_FIELDING_DP)
median<-median(x, na.rm = TRUE) #define the median ratio
moneyball_test$flag_DP <- as.numeric(ifelse(is.na(moneyball_test$TEAM_FIELDING_DP), 1, 0)) #create a flag that identifies the na values, and adjust them to be the median
moneyball_test$TEAM_FIELDING_DP[is.na(moneyball_test$TEAM_FIELDING_DP)] = (median) 

summary(moneyball_test)

moneyball_test<-moneyball_test[-c(18:48)]
summary(moneyball_test)


# Stand Alone Scoring
moneyball_test$P_TARGET_WINS <- -2.866e+05 + -6.439e-05 * OBPSLGfour +
  
  -4.746e+02 * mult +
  5.317e+06  * score +
  5.780e+06  * opprp +
  -1.204e+05 * pitchouts +
  -7.472e+05 * totalbases +
  5.555e+06  * pitchouts +
  -2.890e+01 * OBPSLG +
  -1.068e+03 * BA
  -3.915e+03 * WHIP +
  6.315e+01 * defense +
  7.373e+02 * homerunratio +
  5.405e+02 * moneyball$SB_PCT +
  6.052e+00 * log_TEAM_BASERUN_SB +
  1.454e+02  *  moneyball$log_TEAM_BATTING_1B  +
  2.914e+00 * moneyball$log_TEAM_BATTING_3B +
  9.718e+00 * moneyball$log_TEAM_BATTING_HR +
  7.837e+02 * moneyball$log_TEAM_FIELDING_E +
  -1.757e+05 *  log(pitchouts) +
  5.262e-05 * OBPSLGfour:mult +
  -3.879e+02 * mult:score + 
  -2.835e+06  * opprp:runprediction +
  5.264e+04 *  opprp:pitchouts +
  -5.148e+05 * runprediction:pitchouts +
  3.381e+05 * opprp:totalbases +
  -8.451e+05 * runprediction:totalbases +
  1.440e+05 * pitchouts:totalbases +
  9.454e+10 * totalbases:slugpgame +
  -3.010e+06 * opprp:pitchratio  +
  -3.445e+06 * runprediction:pitchratio +
  -4.566e+05  * pitchouts:pitchratio+
  -9.770e+05 * totalbases:pitchratio +
  4.125e+01 * OBPSLG:BA +
  1.200e+02 * OBP:WHIP  +
  -5.418e+05 * slugging:homerunratio +
  -3.945e+05 * slugging:moneyball$SB_PCT +
  -7.823e+02  * homerunratio:moneyball$SB_PCT +
  -3.817e+02 * moneyball$log_TEAM_FIELDING_E:log(pitchouts) +
  2.719e+05 * opprp:runprediction:pitchouts + 
  4.519e+05 * opprp:runprediction:totalbases+
  -6.998e+04 * opprp:pitchouts:totalbases +
  6.777e+04  * runprediction:pitchouts:totalbases +
  -4.658e+10 * opprp:totalbases:slugpgame +
  1.721e+10  * runprediction:totalbases:slugpgame +
  -1.468e+10 * pitchouts:totalbases:slugpgame +
  1.858e+06  * opprp:runprediction:pitchratio +
  2.457e+05 * opprp:pitchouts:pitchratio +
  2.821e+05 * runprediction:pitchouts:pitchratio +
  5.321e+05 * opprp:totalbases:pitchratio +
  6.066e+05 * runprediction:totalbases:pitchratio +
  6.006e+04 *  pitchouts:totalbases:pitchratio +
  2.915e+10  * totalbases:slugpgame:pitchratio +
  5.757e+05 * slugging:homerunratio:moneyball$SB_PCT +
  -3.567e+04  * opprp:runprediction:pitchouts:totalbases +
  -9.446e+09 *  opprp:runprediction:totalbases:slugpgame +
  7.386e+09 *  opprp:pitchouts:totalbases:slugpgame +
  -1.511e+05  * opprp:runprediction:pitchouts:pitchratio +
  -3.290e+05 * opprp:runprediction:totalbases:pitchratio +
  -3.242e+04 * opprp:pitchouts:totalbases:pitchratio +
  -3.702e+04  * runprediction:pitchouts:totalbases:pitchratio +
  -1.602e+10 * opprp:totalbases:slugpgame:pitchratio +
  -1.825e+10 * runprediction:totalbases:slugpgame:pitchratio +
  1.988e+04 *  opprp:runprediction:pitchouts:totalbases:pitchratio +
  9.991e+09 * opprp:runprediction:totalbases:slugpgame:pitchratio
  


#subset of data set for the deliverable "Scored data file"
prediction <- moneyball_test[c("INDEX","P_TARGET_WINS")]

#####
#Note, this next function will output a CSV file in your work environment called write.csv.
#####

#Prediction File 
write.csv(moneyball, file = "C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\exceltry.csv")


