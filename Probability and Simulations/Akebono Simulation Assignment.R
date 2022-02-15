#Akebono vs. Koehl
n_sample <-100000

weather <- sample(x=c(7,4,2), size =n_sample, prob=c(.1,.6,.3), replace = T)

nFish<-sapply(weather, rpois, n=1)

pctYellow<- sample(x=c(0,.25,.35),size=n_sample, prob=c(.25,.50,.25), replace=T)
nYellow<-round(nFish*pctYellow)
nBlue<- nFish-nYellow

legalYellow<- unlist(lapply(sapply(nYellow, rnorm, mean=30, sd=18),function(l){sum(l[l>20])}))
legalBlue<- unlist(lapply(sapply(nBlue, rnorm, mean=35, sd=18),function(l){sum(l[l>20])}))

lbsYellow <- legalYellow * rbeta(n_sample, shape1=70, shape2=30)
lbsBlue <- legalBlue * rbeta(n_sample, shape1=70, shape2=30)

lbsYellow[which(weather==2)] <-lbsYellow[which(weather==2)]*0.75
lbsYellow[which(weather==7)] <-lbsYellow[which(weather==7)]*1.10
lbsBlue[which(weather==2)] <-lbsBlue[which(weather==2)]*0.75
lbsBlue[which(weather==7)] <-lbsBlue[which(weather==7)]*1.10

par(mfrow=c(3,1))
hist(c(lbsBlue,lbsYellow))
hist(lbsBlue,breaks=100)
hist(lbsYellow,breaks=100)

summary(lbsBlue)
summary(lbsYellow)
yellowCDF <- ecdf(lbsYellow)
par(mfrow=c(1,1))
plot(yellowCDF)