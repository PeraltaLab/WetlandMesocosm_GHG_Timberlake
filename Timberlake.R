setwd("~/Documents/2016_Summer_ECU/TMG-2016/TMG_GHG/T0_Adjustment")

#Read in data files
#flux=read.csv("~/Documents/2016_Summer_ECU/TMG-2016/TMG_GHG/T0_Adjustment/TMG_R_v2_grams_metersq_year.csv", header=T)
#modified the flux dataset by changing first treatments to their history
hflux=read.csv("~/Documents/2016_Summer_ECU/TMG-2016/TMG_GHG/T0_Adjustment/TMG_R_v2_grams_metersq_year_history.csv", header=T)
melich=read.csv("~/Documents/2016_Summer_ECU/TMG-2016/TMG_GHG/T0_Adjustment/MelichIII.csv", header=T)

#Descriptives: mean and stadard deviaiton for each gas (m squared per year)
library(doBy)
hsflux <- summaryBy(gCH4+gCO2+gN2O~History+Time, data=hflux, FUN=function(x) {c(m=mean(x), s =sd(x))})
tsflux <- summaryBy(gCH4+gCO2+gN2O~Treatment+Time, data=hflux, FUN=function(x) {c(m=mean(x), s =sd(x))})
psflux <- summaryBy(gCH4+gCO2+gN2O~plant+Time, data=hflux, FUN=function(x) {c(m=mean(x), s =sd(x))})

#summaryBy(Pppm+Kppm+Mgppm+Cappm+pH+Sppm+Bppm+Znppm+Mnppm+Feppm+Cuppm+HM~Treatment, data=melich, FUN=function(x) {c(m=mean(x), s =sd(x))})


library(ggplot2)
#barplots by Treatment
g<- ggplot(data=tsflux, aes(x=Treatment, y=gCH4.m, fill=Time))  + geom_bar(stat="identity", 
           position=position_dodge()) + geom_errorbar(aes(ymin=gCH4.m-gCH4.s, ymax=gCH4.m+gCH4.s), width=.2, 
           position=position_dodge(.9))  + ylab("CH4-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=tsflux, aes(x=Treatment, y=gCO2.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gCO2.m-gCO2.s, ymax=gCO2.m+gCO2.s), width=.2, 
            position=position_dodge(.9))  + ylab("CO2-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=tsflux, aes(x=Treatment, y=gN2O.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gN2O.m-gN2O.s, ymax=gN2O.m+gN2O.s), width=.2, 
            position=position_dodge(.9))  + ylab("N2O-N g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

#barplots by History
g<- ggplot(data=hsflux, aes(x=History, y=gCH4.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gCH4.m-gCH4.s, ymax=gCH4.m+gCH4.s), width=.2, 
            position=position_dodge(.9))  + ylab("CH4-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=hsflux, aes(x=History, y=gCO2.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gCO2.m-gCO2.s, ymax=gCO2.m+gCO2.s), width=.2, 
            position=position_dodge(.9))  + ylab("CO2-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=hsflux, aes(x=History, y=gN2O.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gN2O.m-gN2O.s, ymax=gN2O.m+gN2O.s), width=.2, 
            position=position_dodge(.9))  + ylab("N2O-N g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g


#barplots by Vegetation presence
g<- ggplot(data=psflux, aes(x=plant, y=gCH4.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gCH4.m-gCH4.s, ymax=gCH4.m+gCH4.s), width=.2, 
            position=position_dodge(.9))  + ylab("CH4-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=psflux, aes(x=plant, y=gCO2.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gCO2.m-gCO2.s, ymax=gCO2.m+gCO2.s), width=.2, 
            position=position_dodge(.9))  + ylab("CO2-C g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g

g<- ggplot(data=psflux, aes(x=plant, y=gN2O.m, fill=Time))  + geom_bar(stat="identity", 
            position=position_dodge()) + geom_errorbar(aes(ymin=gN2O.m-gN2O.s, ymax=gN2O.m+gN2O.s), width=.2, 
            position=position_dodge(.9))  + ylab("N2O-N g m-2 yr-1") + scale_fill_manual(values=c("#8b5a2b","#548b54")                                                                     )
g


#CH4

lm1 <- lm(gCH4~History*Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gCH4~Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gCH4~History*plant, data=hflux)
anova(lm1)

#CO2
lm1 <- lm(gCO2~History*Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gCO2~Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gCO2~History*plant, data=hflux)
anova(lm1)

#N2O
lm1 <- lm(gN2O~History*Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gN2O~Treatment*plant, data=hflux)
anova(lm1)

lm1 <- lm(gN2O~History*plant, data=hflux)
anova(lm1)

#ALL GASES
lm1 <- lm(gCH4 + gCO2 + gN2O~History*Treatment*plant)
anova(lm1)

#A line plot of CO2 for each treatment DIW and PN
#g <- ggplot(data=hsflux, aes(x=Date, y=gCH4.m, group=Treatment)) +
#  geom_line(aes(color=Treatment)) +  geom_point() + ylim(-10000, 100000) + geom_errorbar(aes(ymin=gCH4.m-gCH4.s, ymax=gCH4.m+gCH4.s), width=.1, 
#       position=position_dodge(0.05) )
#g 


#box plots
#p <- ggplot(hflux, aes(plant,gCH4)) + geom_boxplot()
#p
#p <- ggplot(hflux, aes(plant,gCO2)) + geom_boxplot()
#p
#p <- ggplot(hflux, aes(plant,gN2O)) + geom_boxplot()
#p
#p <- ggplot(melich, aes(Treatment, Pppm)) + geom_boxplot()
#p

#library(CatterPlots)
#purr <-catplot(xs=AvgTemp, ys=gCH4, data=flux, cat=2, catcolor=c(0,1,0,1))
#purr


