rm(list=ls())


install.packages("readr")
library(readr)
search()
library(dplyr)
guess_encoding("demand.csv")

demand<-read.csv("demand.csv",fileEncoding = "UTF-8", sep =",")
str(demand)
head(demand)
load("RESULTS_APT_SALES14_FIN.RData")
load("RESULTS_APT_SALES15_FIN.RData")
load("RESULTS_APT_SALES16_FIN.RData")
load("RESULTS_APT_SALES17_FIN.RData")
load("RESULTS_APT_SALES18_FIN.RData")
load("RESULTS_APT_SALES19_FIN2.RDATA")


table(RESULTS_APT_SALES18_19$날짜)

RESULT_FINAL<-rbind(RESULTS_APT_SALES14_FIN,RESULTS_APT_SALES15_FIN,RESULTS_APT_SALES16_FIN,
                    RESULTS_APT_SALES17_FIN)


str(RESULT_FINAL)
str()
summary(RESULT_FINAL)
summary(RESULTS_APT_SALES14_FIN)
str(RESULTS_APT_SALES14_FIN)
str(RESULTS_APT_SALES15_FIN)
str(RESULTS_APT_SALES16_FIN)
str(RESULTS_APT_SALES17_FIN)
str(RESULTS_APT_SALES18_FIN,list.len=ncol(RESULTS_APT_SALES18_FIN)))


colSums(is.na(RESULTS_APT_SALES14_FIN))
colSums(is.na(RESULTS_APT_SALES15_FIN))
colSums(is.na(RESULTS_APT_SALES16_FIN))
colSums(is.na(RESULTS_APT_SALES17_FIN))
colSums(is.na(RESULTS_APT_SALES18_FIN))

table(RESULTS_APT_SALES14_FIN$날짜)
table(RESULTS_APT_SALES15_FIN$날짜)
table(RESULTS_APT_SALES16_FIN$날짜)
table(RESULTS_APT_SALES17_FIN$날짜)
table(RESULTS_APT_SALES18_FIN$날짜)
table(RESULTS_APT_SALES19_FIN2$날짜)
is.data.frame(RESULTS_APT_SALES14_FIN)




table(is.na(RESULTS_APT_SALES14_17))

str(RESULTS_APT_SALES14_17)
colSums(is.na(RESULTS_APT_SALES14_17))
RESULTS_APT_SALES14_17[RESULTS_APT_SALES14_17$gu==c(NA), ]
      
st2 <-filter(RESULTS_APT_SALES14_17,is.na(GU))
st3 <-filter(RESULTS_APT_SALES14_17,is.na(GU_CODE))
st2_1<-filter(RESULTS_APT_SALES14_17,!is.na(GU))
st3_1<-filter(RESULTS_APT_SALES14_17,!is.na(GU_CODE))
str(RESULTS_APT_SALES14_FIN)
str(RESULTS_APT_SALES18_FIN)
table(st2$DATE)
table(st3$DATE)
table(st2_1$DATE)

table(RESULTS_APT_SALES14_17$DATE)
table(RESULTS_APT_SALES18_19$날짜)
table(RESULTS_APT_SALES15_FIN$날짜)
table(is.na(RESULTS_APT_SALES14_FIN))
