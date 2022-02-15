# Data Import and Variable Type Changes
setwd("D:/Class/Online MSBA/ML1 Online/Mod1")
balldata <- read.csv("C:\\Users\\thoma\\OneDrive\\Documents\\ML1\\Module 1\\buad5122-m1-moneyball-data.csv") #read in the dataset

# Need to make sure our data is understood correctly by R, there are both numerical and categorical variables
#read in text strings as factor, rest as numeric
balldata$INDEX<-as.factor(balldata$INDEX)
balldata$TEAM_BATTING_H<-as.numeric(balldata$TEAM_BATTING_H)
balldata$TEAM_BATTING_2B<-as.numeric(balldata$TEAM_BATTING_2B)
balldata$TEAM_BATTING_3B<-as.numeric(balldata$TEAM_BATTING_3B)
balldata$TEAM_BATTING_HR<-as.numeric(balldata$TEAM_BATTING_HR)
balldata$TEAM_BATTING_BB<-as.numeric(balldata$TEAM_BATTING_BB)
balldata$TEAM_BATTING_SO<-as.numeric(balldata$TEAM_BATTING_SO)
balldata$TEAM_BASERUN_SB<-as.numeric(balldata$TEAM_BASERUN_SB)
balldata$TEAM_BASERUN_CS<-as.numeric(balldata$TEAM_BASERUN_CS)
balldata$TEAM_BATTING_HBP<-as.numeric(balldata$TEAM_BATTING_HBP)
balldata$TEAM_PITCHING_H<-as.numeric(balldata$TEAM_PITCHING_H)
balldata$TEAM_PITCHING_HR<-as.numeric(balldata$TEAM_PITCHING_HR)
balldata$TEAM_PITCHING_BB<-as.numeric(balldata$TEAM_PITCHING_BB)
balldata$TEAM_PITCHING_SO<-as.numeric(balldata$TEAM_PITCHING_SO)
balldata$TEAM_FIELDING_E<-as.numeric(balldata$TEAM_FIELDING_E)
balldata$TEAM_FIELDING_DP<-as.numeric(balldata$TEAM_FIELDING_DP)

# Checks to see if the data frame is built correctly
str(balldata)

# Summary of data (as inputted)
summary(balldata)

#Evaluate 3B Min
balldata$Flag_TEAM_BATTING_3B_zero <- as.factor(ifelse(balldata$TEAM_BATTING_3B != 0, 0, 1)) 
balldata$TEAM_BATTING_3B <- as.numeric(ifelse(balldata$Flag_TEAM_BATTING_3B_zero == 1, quantile(balldata$TEAM_BATTING_3B,c(.05)), balldata$TEAM_BATTING_3B))  #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is
#Evaluate HR Min
balldata$Flag_TEAM_BATTING_HR_zero <- as.factor(ifelse(balldata$TEAM_BATTING_HR != 0, 0, 1))
balldata$TEAM_BATTING_HR <- as.numeric(ifelse(balldata$Flag_TEAM_BATTING_HR_zero == 1, quantile(balldata$TEAM_BATTING_HR,c(.05)), balldata$TEAM_BATTING_HR)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

#did not change base on balls based off former rules, in some years it could take 10 or 8 balls before a team walks

# Evaluation of Batting Strike Out variable in more detail


#Lets get rid of the NA's
balldata$H_TO_SO_R<- balldata$TEAM_BATTING_SO/balldata$TEAM_BATTING_H
summary(balldata$H_TO_SO_R)
x<-c(balldata$H_TO_SO_R)
median_so_ratio<-median(x, na.rm = TRUE) #define the median ratio of strike outs to hits
balldata$Flag_TEAM_BATTING_SO <- as.numeric(ifelse(is.na(balldata$TEAM_BATTING_SO), 1, 0)) #create a flag that identifies the na values
balldata$TEAM_BATTING_SO[is.na(balldata$TEAM_BATTING_SO)] = (median_so_ratio*balldata$TEAM_BATTING_H) #if they are flagged, have it being the median value


hist(balldata$TEAM_BATTING_SO)
#now lets get rid of the zeros in strike outs

balldata$Flag_TEAM_BATTING_SO_zero <- as.factor(ifelse(balldata$TEAM_BATTING_SO != 0, 0, 1))
balldata$TEAM_BATTING_SO <- as.numeric(ifelse(balldata$Flag_TEAM_BATTING_SO_zero == 1, quantile(balldata$TEAM_BATTING_SO,c(.05)), balldata$TEAM_BATTING_SO)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

#now lets get rid of the zeros in strike outs

balldata$Flag_TEAM_BATTING_BB_zero <- as.factor(ifelse(balldata$TEAM_BATTING_BB != 0, 0, 1)) 
balldata$TEAM_BATTING_BB <- as.numeric(ifelse(balldata$Flag_TEAM_BATTING_BB_zero == 1, quantile(balldata$TEAM_BATTING_BB,c(.05)), balldata$TEAM_BATTING_BB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is


hist(balldata$TEAM_BATTING_SO)

# Evaluation of Team Stolen Bases variable in more detail

#Lets get rid of the NA's
balldata$SB_CS_R<- balldata$TEAM_BASERUN_SB/balldata$TEAM_BASERUN_CS
summary(balldata$SB_CS_R)
x<-c(balldata$SB_CS_R)
median_sb_ratio<-median(x, na.rm = TRUE) #define the median ratio
balldata$Flag_TEAM_BASERUN_SB <- as.numeric(ifelse(is.na(balldata$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
balldata$TEAM_BASERUN_SB[is.na(balldata$TEAM_BASERUN_SB)] = (median_sb_ratio*balldata$TEAM_BASERUN_CS) #if they are flagged, have it being the ratio

balldata$Flag_TEAM_BASERUN_SB2 <- as.numeric(ifelse(is.na(balldata$TEAM_BASERUN_SB), 1, 0)) #create a flag that identifies the na values
balldata$TEAM_BASERUN_SB[is.na(balldata$TEAM_BASERUN_SB)] = median(balldata$TEAM_BASERUN_SB, na.rm = TRUE) #if they are flagged, have it being the ratio


hist(balldata$TEAM_BASERUN_SB)

balldata$Flag_TEAM_BASERUN_SB_zero <- as.factor(ifelse(balldata$TEAM_BASERUN_SB != 0, 0, 1)) 
balldata$TEAM_BASERUN_SB <- as.numeric(ifelse(balldata$Flag_TEAM_BASERUN_SB_zero == 1, quantile(balldata$TEAM_BASERUN_SB,c(.05)), balldata$TEAM_BASERUN_SB)) #anyone that has the 1, adjust them to the fifth percentile. If it is equal to one, change the value of age to the fifth percentile, if it is zero, leave it as is

hist(balldata$TEAM_BATTING_SO)

balldata$FlagSB <- as.factor(ifelse(balldata$TEAM_BASERUN_SB < 415, 0, 1)) #a team has stolen a max of 415 bases in a season, so if they have more lets return it to the 95th percentile
balldata$TEAM_BASERUN_SB <- as.numeric(ifelse(balldata$FlagSB  == 1, quantile(balldata$TEAM_BASERUN_SB,c(.95)), balldata$TEAM_BASERUN_SB))
#Lets get rid of the NA's in caught 

hist(balldata$TEAM_BASERUN_SB)


#Let's fix caught stealing
#Lets get rid of the NA's
balldata$SB_CS_R<- balldata$TEAM_BASERUN_CS/balldata$TEAM_BASERUN_SB
summary(balldata$SB_CS_R)
x<-c(balldata$SB_CS_R)
median_cs_ratio<-median(x, na.rm = TRUE) #define the median ratio
balldata$Flag_TEAM_BASERUN_CS <- as.numeric(ifelse(is.na(balldata$TEAM_BASERUN_CS), 1, 0)) #create a flag that identifies the na values
balldata$TEAM_BASERUN_CS[is.na(balldata$TEAM_BASERUN_CS)] = (median_cs_ratio*balldata$TEAM_BASERUN_SB) #determine the number of times caught stealing by multiplying the ratio by the number of stolen bases they ran

boxplot(balldata$TEAM_BASERUN_CS)

#lets fix the outliers
balldata$FlagCS <- as.factor(ifelse(balldata$TEAM_BASERUN_CS < 191, 0, 1)) 
balldata$TEAM_BASERUN_CS <- as.numeric(ifelse(balldata$FlagCS  == 1, quantile(balldata$TEAM_BASERUN_CS,c(.95)), balldata$TEAM_BASERUN_CS)) #no team has been caught stealing more than 191 times, so lets reduce from there
balldata$FlagCS1 <- as.factor(ifelse(balldata$TEAM_BASERUN_CS > 8, 0, 1))  #no team has been caught stealing more than 8 times, so lets reduce from there
balldata$TEAM_BASERUN_CS <- as.numeric(ifelse(balldata$FlagCS1  == 1, quantile(balldata$TEAM_BASERUN_CS,c(.05)), balldata$TEAM_BASERUN_CS)) 



#NA's in Hit By Pitch
boxplot(balldata$TEAM_BATTING_HBP) #evenly distributed with one outlier, which is actually lower then the actual (don't know how to fix this)
#lets make the NA's median, since we don't have any data to base it off of (perhaps team_pitching_HBP)
balldata$Flagbat_HBP <- as.factor(ifelse(is.na(balldata$TEAM_BATTING_HBP), 1, 0)) #create a flag that identifies the missing values
balldata$TEAM_BATTING_HBP[is.na(balldata$TEAM_BATTING_HBP)] = median(balldata$TEAM_BATTING_HBP, na.rm = TRUE) #if they are flagged, have it being the median value


#lets fix team pitching hits
boxplot(balldata$TEAM_PITCHING_BB)
#no team has hit more than 1,783 hits in a season, so we assume that a team has not given up that many as well

balldata$FlagPH <- as.factor(ifelse(balldata$TEAM_PITCHING_H < 1783, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
balldata$TEAM_PITCHING_H <- as.numeric(ifelse(balldata$FlagPH  == 1, quantile(balldata$TEAM_PITCHING_H,c(.90)), balldata$TEAM_PITCHING_H)) 


#lets fix team pitching HR, we will say three as that is the least amount of homeruns a team has ever had
balldata$FlagPHR <- as.factor(ifelse(balldata$TEAM_PITCHING_HR > 3, 0, 1)) #creates a new factor variable, generated based off the idea that if the individual has a credit card that is younger than 18, this will produce a flag in the variable name
balldata$TEAM_PITCHING_HR <- as.numeric(ifelse(balldata$FlagPHR  == 1, quantile(balldata$TEAM_PITCHING_HR,c(.90)), balldata$TEAM_PITCHING_HR)) 


#lets fix walks
x<-IQR(balldata$TEAM_PITCHING_BB)
y<-quantile(balldata$TEAM_PITCHING_BB, .25)
lb<-(y-(1.5*x))
a<-IQR(balldata$TEAM_PITCHING_BB)
b<-quantile(balldata$TEAM_PITCHING_BB, .75)
lb1<-(b+(1.5*a))
lb1
lb
balldata$FlagPBB <- as.factor(ifelse(balldata$TEAM_PITCHING_BB > lb, 0, 1)) #since the range is so wide, let adjust using the IQR
balldata$TEAM_PITCHING_BB <- as.numeric(ifelse(balldata$FlagPBB  == 1, quantile(balldata$TEAM_PITCHING_BB,c(.10)), balldata$TEAM_PITCHING_BB)) 
balldata$FlagPBB1 <- as.factor(ifelse(balldata$TEAM_PITCHING_BB < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
balldata$TEAM_PITCHING_BB <- as.numeric(ifelse(balldata$FlagPBB1  == 1, quantile(balldata$TEAM_PITCHING_BB,c(.90)), balldata$TEAM_PITCHING_BB)) 

boxplot(balldata$TEAM_PITCHING_SO)


#lets fix strikeouts
x<-c(balldata$TEAM_PITCHING_SO)
median<-median(x, na.rm = TRUE) #define the median ratio
balldata$Flag_TEAM_Pitching_strikeouts <- as.numeric(ifelse(is.na(balldata$TEAM_PITCHING_SO), 1, 0)) #create a flag that identifies the na values
balldata$TEAM_PITCHING_SO[is.na(balldata$TEAM_PITCHING_SO)] = (median) 


x<-IQR(balldata$TEAM_PITCHING_SO)
y<-quantile(balldata$TEAM_PITCHING_SO, .25)
lb<-(y-(1.5*x))

lb
balldata$FlagPSO <- as.factor(ifelse(balldata$TEAM_PITCHING_SO > lb, 0, 1))#since the range is so wide, let adjust using the IQR
balldata$TEAM_PITCHING_SO <- as.numeric(ifelse(balldata$FlagPSO  == 1, quantile(balldata$TEAM_PITCHING_SO,c(.10)), balldata$TEAM_PITCHING_SO)) 
balldata$FlagPSO1 <- as.factor(ifelse(balldata$TEAM_PITCHING_SO < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
balldata$TEAM_PITCHING_SO <- as.numeric(ifelse(balldata$FlagPSO1  == 1, quantile(balldata$TEAM_PITCHING_SO,c(.90)), balldata$TEAM_PITCHING_SO)) 

#lets fix fielding errors
boxplot(balldata$TEAM_FIELDING_E)

a<-IQR(balldata$TEAM_FIELDING_E)
b<-quantile(balldata$TEAM_FIELDING_E, .75)
lb1<-(b+(1.5*a))
lb1
balldata$FlagE <- as.factor(ifelse(balldata$TEAM_FIELDING_E < lb1, 0, 1)) #since the range is so wide, let adjust using the IQR
balldata$TEAM_FIELDING_E <- as.numeric(ifelse(balldata$FlagE  == 1, quantile(balldata$TEAM_FIELDING_E,c(.90)), balldata$TEAM_FIELDING_E)) 


#lets fix double plays
boxplot(balldata$TEAM_FIELDING_DP)
hist(balldata$TEAM_FIELDING_DP) #seems evenly disributed. let's just fix the NA's


x<-c(balldata$TEAM_FIELDING_DP)
median<-median(x, na.rm = TRUE) #define the median ratio
balldata$flag_DP <- as.numeric(ifelse(is.na(balldata$TEAM_FIELDING_DP), 1, 0)) #create a flag that identifies the na values, and adjust them to be the median
balldata$TEAM_FIELDING_DP[is.na(balldata$TEAM_FIELDING_DP)] = (median) 

summary(balldata)

write.csv(moneyball_data_update, file = "CDataOutput.csv")
