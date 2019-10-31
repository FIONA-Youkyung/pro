#카카오 계정에서 주소별 위도, 경도 위치 표시 
Sys.getenv('KAKAO_MAP_API_KEY')

library(httr)
library(tidyverse)
library(jsonlite)
library(dplyr)
library(ggplot2)


# HTTP 요청을 실행합니다. 

head(res2[["content"]])

res <- GET(url = 'https://dapi.kakao.com/v2/local/search/address.json',
           query = list(query = addr),
           add_headers(Authorization = Sys.getenv('KAKAO_MAP_API_KEY')))

# HTTP 응답 결과를 확인합니다. 
print(x = res)

str(RESULT_FINAL)

RESULT_FINAL <-cbind(RESULT_FINAL,addr)

head(RESULT_FINAL$addr)

rm(res)
res <-list()


res <-GET(url = 'https://dapi.kakao.com/v2/local/search/address.json',
          query = list(query ='종로구 사직로8길 00004'),
          add_headers(Authorization = Sys.getenv('KAKAO_MAP_API_KEY')))


print(x=res)

str(RESULT_FINAL)

#데이터 테이블에 다른 테이블에 있는 데이터 붙이기 

demand<-read.csv("pro/demand.csv",fileEncoding = "UTF-8", sep =",")
str(demand)

demand$demandration <- (demand$수요량/demand$입주량)
str(demand)



#각 변수별로 데이터 시각화 하기 

library(ggplot2)
demand2<-read.csv("pro/demand2.csv",fileEncoding = "UTF-8", sep =",")
demand2[500,4]<-2139
save(demand2,file="C:/dev/lab_r/data/pro/demand2.RData")
head(demand2)


ggplot(data=demand, aes(x=연도, y=입주량))+geom_col(fill="#F8766D",binwidth = 1)+
  facet_grid(.~구)

str(demand2)
demand_ds <-demand2 %>% group_by(연도,구,분류)
demand_ds
demand_ds$연도 <-factor(demand_ds$연도)

ggplot(data=demand_ds,aes(x=연도,y=입주량,color=분류, group=분류))+
      geom_line()+
      geom_point()+
      facet_wrap(~구)+
      theme_bw() +
      theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())+
      labs(title = '구별 아파트 수요공급량',
           x='연도',
           y='양')+
      theme(text=element_text(size=16,family="Arial"))
#구별 아파트 수요 공급량 그래프1
ggplot(data=demand_ds,aes(x=연도,y=입주량, color = 분류,group =분류))+
  geom_line()+
  geom_point()+
  facet_wrap(~구)+
  theme_bw() +
  theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())+
  labs(title = '구별 아파트 수요공급량',
       x='연도',
       y='물량')+
  theme(text=element_text(size=16,family="Arial"))

#구별 아파트 수요 공급량 그래프2
demand3 <-read.csv("pro/demand3.csv",fileEncoding = "UTF-8", sep =",")
head(demand3)
demand3$연도 <-factor(demand3$연도)

demand3[242:250,2] <- "강동구"
demand3[242:250,2]

ggplot(data=demand3, aes(x=연도,y=누적,color =구, group = 구))+
      geom_col()+
      facet_wrap(~구)+
      labs(title = '구별 연도별 누적 아파트 수요공급량',
       x='연도',
       y='물량')+
       theme(text=element_text(size=16,family="Arial"))+
      theme(axis.text.x = element_text(colour="grey20", size=6, angle=90, hjust=.5, vjust=.5))


ggplot(data=demand3, aes(x=연도,y=차이,color =구, group = 구))+
  geom_col()+
  facet_wrap(~구)+
  labs(title = '구별 연도별 아파트 초과공급량',
       x='연도',
       y='물량')+
  theme(text=element_text(size=16,family="Arial"))+
  theme(axis.text.x = element_text(colour="grey20", size=6, angle=90, hjust=.5, vjust=.5))


# 원데이터에 전용 면적별, 거래년도별 가격 추이 보기 
str(RESULT_FINAL)

RESULT_FINAL$전용면적 <-as.numeric(RESULT_FINAL$전용면적)
RESULT_FINAL$거래금액 <-as.numeric(RESULT_FINAL$거래금액)
RESULT_FINAL$시군구코드 <-factor(RESULT_FINAL$시군구코드)
RESULT_FINAL$시군구 <-factor(RESULT_FINAL$시군구)
RESULT_FINAL$년 <-factor(RESULT_FINAL$년)

str(RESULT_FINAL)



RESULT_FINAL$분류 <- ifelse(RESULT_FINAL$전용면적 >135.0,RESULT_FINAL$분류<-"대형",
ifelse(RESULT_FINAL$전용면적>=95.0,RESULT_FINAL$분류<-"중대형",
ifelse(RESULT_FINAL$전용면적>=62.8,RESULT_FINAL$분류<-"중소형",RESULT_FINAL$분류<-"소형")))

str(RESULT_FINAL)
table(RESULT_FINAL$분류)

# 원데이터 거래 년도, 평형별 판가 분류 보기
# 결측치 처리하기 
## step1. 시군구 코드의 경우 동으로 확인했을 때, 모두 강동구로 확인되었음으로 일괄 강동구 변경

rm(list =ls())
load(file = "pro/FINALDATA2.RData")
colSums(is.na(FINALDATA2))
table(FINALDATA2$시군구코드)
table(FINALDATA2$날짜)

## step2. 결측치가 들어있는 데이터 사본을 만들어서 결측치 확인 
FINAL_NA <-filter(FINALDATA2,is.na(시군구코드))
FINAL_NA[is.na(FINAL_NA$시군구코드),1]<-"강동구"
FINAL_NA[is.na(FINAL_NA$시군구코드),1]<-"강동구"
FINALDATA2[is.na(FINALDATA2$시군구코드),1]<-"강동구"
colSums(is.na(FINALDATA2))


## step3. 전용면직에 결측치가 들어있는 데이터 사본 만들어서 결측치 확인 
FINAL_NA1 <-filter(FINALDATA2,is.na(전용면적))
table(FINAL_NA1$시군구코드)
# 결측치가 특정구에 몰려 있음으로 가격을 변수로 하여 평수 지정
FINALDATA2$분류 <- ifelse(FINALDATA2$전용면적 >135.0,FINALDATA2$분류<-"대형",
                       ifelse(FINALDATA2$전용면적>=95.0,FINALDATA2$분류<-"중대형",
                              ifelse(FINALDATA2$전용면적>=62.8,FINALDATA2$분류<-"중소형",FINALDATA2$분류<-"소형")))
table(FINALDATA2$분류)
str(FINALDATA2)

FINALDATA2$거래금액 <-gsub(",","",FINALDATA2$거래금액)
FINALDATA2$거래금액 <- str_trim(FINALDATA2$거래금액,side=c("both"))
FINALDATA2$거래금액 <-as.numeric(FINALDATA2$거래금액)
FINALDATA2$전용면적 <-as.numeric(FINALDATA2$전용면적)
FINALDATA2$시군구코드 <-factor(FINALDATA2$시군구코드)
FINALDATA2$시군구 <-factor(FINALDATA2$시군구)
FINALDATA2$년 <-factor(FINALDATA2$년)
FINALDATA2$날짜 <-factor(FINALDATA2$날짜)
FINALDATA2$분류 <-factor(FINALDATA2$분류)

# 평수별 중앙값을 기준으로 결측치 값을 채우기
with(FINALDATA2,tapply(거래금액,분류,summary))
colSums(is.na(FINALDATA2))
FINALDATA2[is.na(FINALDATA2$분류),]

FINAL_NA3 <-FINALDATA2[is.na(FINALDATA2$분류),]
FINAL_NA3
FINALDATA2$분류<-ifelse(is.na(FINALDATA2$분류)|FINALDATA2$거래금액 >=100000,FINALDATA2$분류<-"대형",
                                            ifelse(is.na(FINALDATA2$분류)|FINALDATA2$거래금액>=69500,FINALDATA2$분류<-"중대형",
                                                   ifelse(is.na(FINALDATA2$분류)|FINALDATA2$거래금액>=50500,FINALDATA2$분류<-"중소형",FINALDATA2$분류<-"소형")))

table(FINALDATA2$분류)
colSums(is.na(FINALDATA2))
str(FINALDATA2)

  ggplot(FINALDATA2, aes(x=날짜, y=거래금액,color=분류)) +
  geom_point()+
  scale_y_continuous(labels = scales::comma)+
  facet_wrap(~시군구코드)+
  labs(title = '구별 월별 분류별 거래금액 분포',
       x='월',
       y='거래금액')+
  theme(axis.text.x = element_text(colour="grey20", size=6, angle=90, hjust=.5, vjust=.5))

plot2

str(FINAL_1)
summary(FINAL_1$거래금액)


install.packages("Scale")
library(Scale)
FINAL_1<-filter(FINALDATA,시군구코드==c("서초구"))
FINAL_2<-filter(FINALDATA,시군구코드==c("강동구"))
FINAL_3<-filter(FINALDATA,시군구코드==c("영등포구"))

table(FINAL_3$날짜)


FINAL_NA <-filter(FINALDATA,is.na(시군구코드))
FINAL_NA2 <-filter(FINALDATA,is.na(시군구))
FINAL_NA3 <-filter(FINALDATA,is.na(전용면적))
FINAL_NA4 <-filter(FINALDATA,is.na(거래금액))

table(FINAL_NA4$시군구코드)
table(FINAL_NA$법정동)
table(FINAL_NA$날짜)
colSums(is.na(FINALDATA))
