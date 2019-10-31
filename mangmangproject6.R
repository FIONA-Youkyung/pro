colSums(is.na(FINALDATA5))
str(FINALDATA5)
#======내가 원하는 변수만 가져와서 Data table 만들기 

search()
library(dplyr)

DATAFIN<-dplyr::select(FINALDATA5,시군구코드,도로명,도로명건물본번호코드,아파트,
                        년,월,일,날짜,거래금액,분류,건축년도)
str(DATAFIN)
DATAFIN$년<-as.numeric(DATAFIN$년)
DATAFIN$건물연수<-(DATAFIN$년-DATAFIN$건축년도)
DATAFIN$날짜<-as.factor(DATAFIN$날짜)
load("pro/popFIN.RData")

str(pop)
pop<-dplyr::rename(pop,시군구코드=인구이동구)


DATAFIN<-merge(DATAFIN,pop,by =c("날짜","시군구코드"))
head(DATAFIN)


str(DATAFIN)
table(DATAFIN$월)
DATAFIN$월<-as.numeric(DATAFIN$월)
DATAFIN$일<-as.numeric(DATAFIN$일)

table(DATAFIN$일)
str(naver.fin)
naver.fin$날짜 <-as.factor(naver.fin$날짜)
naver.fin$구<-as.factor(naver.fin$구)
naver.fin<-dplyr::rename(naver.fin,시군구코드=구)
str(naver.fin)
naverfin<-naver.fin

DATAFIN<-merge(DATAFIN,naverfin,by =c("날짜","시군구코드"))

str(DATAFIN)         

colSums(is.na(DATAFIN))

DATAFIN2<-dplyr::select(DATAFIN,날짜,시군구코드,도로명,도로명건물본번호코드,아파트,거래금액,분류,건물연수,구별이동,
                        비율,검색지수)
        