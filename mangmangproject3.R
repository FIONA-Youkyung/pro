rm(list=ls())
install.packages("readr")
library(readr)
search()
library(dplyr)
getwd()
setwd("c:/dev/lab_r/data/pro/")
guess_encoding("pro/demand.csv")
guess_encoding("pro/pop.csv")
rm(list =ls())

demand<-read.csv("demand.csv",fileEncoding = "UTF-8", sep =",")
pop<-read.csv("pro/pop.csv",fileEncoding = "UTF-8", sep =",",stringsAsFactors = FALSE)
str(demand)
head(demand)

str(pop)
head(pop)
table(pop$인구이동월)


pop$인구이동월<-sprintf("%01d", pop$인구이동월)
pop$날짜<-paste(pop$인구이동연,pop$인구이동월)
head(pop)

load("pro/APT_SALES_15.RData")
load("pro/APT_SALES_16.RData")
load("pro/RESULTS_APT_SALES17_FIN.RData")
load("pro/RESULTS_APT_SALES18_FIN2.RData")
load("pro/RESULTS_APT_SALES19_FIN3.RDATA")
load("pro/APT_SALES_ROSS.RData")

table(APT_SALES_15$시군구코드)
table(APT_SALES_16$시군구코드)
table(RESULTS_APT_SALES17_FIN$시군구코드)
table(RESULTS_APT_SALES18_FIN2$시군구코드)
table(RESULTS_APT_SALES19_FIN3$시군구코드)

FINALDATA2<-rbind(APT_SALES_15,APT_SALES_16,RESULTS_APT_SALES17_FIN,RESULTS_APT_SALES18_FIN2,RESULTS_APT_SALES19_FIN3,
                 APT_SALES_ROSS)


str(FINALDATA)
colSums(is.na(FINALDATA))
save(FINALDATA2,file="C:/dev/lab_r/data/pro/FINALDATA2.RData")


summary(RESULTS_APT_SALES14_FIN)

str(RESULTS_APT_SALES14_FIN)
str(RESULTS_APT_SALES15_FIN)
str(RESULTS_APT_SALES16_FIN)
str(RESULTS_APT_SALES16_FIN1)
str(RESULTS_APT_SALES17_FIN)
str(RESULTS_APT_SALES18_FIN2)
str(RESULTS_APT_SALES19_FIN3)

colSums(is.na(RESULTS_APT_SALES14_FIN))
colSums(is.na(RESULTS_APT_SALES15_FIN))
colSums(is.na(RESULTS_APT_SALES16_FIN))
colSums(is.na(RESULTS_APT_SALES17_FIN))
colSums(is.na(RESULTS_APT_SALES18_FIN2))
colSums(is.na(RESULTS_APT_SALES19_FIN3))

table(RESULTS_APT_SALES14_FIN$날짜)
table(RESULTS_APT_SALES15_FIN$날짜)
table(RESULTS_APT_SALES16_FIN$날짜)
table(RESULTS_APT_SALES16_FIN2$날짜)
table(RESULTS_APT_SALES17_FIN$날짜)
table(RESULTS_APT_SALES18_FIN2$날짜)
table(RESULTS_APT_SALES19_FIN3$날짜)
is.data.frame(RESULTS_APT_SALES14_FIN)

RESULTS_APT_SALES16_FIN2$날짜[is.na(RESULTS_APT_SALES16_FIN2$날짜)]<-201606



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
