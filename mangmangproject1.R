library(XML)
library(data.table)
library(stringr)
library(ggplot2)

rm(list =ls())

service_key <-"RR4OiP5FElPvLBxp7%2FgTitOIlfK09e7y7xRz5k%2B%2BabGSGFAZHNtgOqmTJ7AXr65wSivFDeQVVIK9sfupQS2zVA%3D%3D"


#지역코드 
locCode <-c("11110","11140","11170","11200","11215","11230","11260","11290","11305","11320","11350",
            "11380","11410","11440","11470","11500","11530","11545","11560","11590","11620","11650","11680","11710","11740")

locCode_nm <-c("종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구",
               "노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구")

datalist <-c("201510","201511","201512","201601","201602","201603","201604","201605","201606","201607","201608","201609")

str(locCode)

locCode <-c("11110")
locCode <-as.numeric(locCode)
locCode_nm<-c("종로구")
datalist <-c("201509","201609","201709","201809","201909")

loc <-cbind(locCode,locCode_nm)
loc
Num_of_Rows <- 100

# 지역코드 x 날짜 별로 자료를 요청하는 url 생성
urllist <- list()
cnt <-0

for(i in 1:length(locCode)){
  for(j in 1:length(datalist)){
    cnt=cnt+1
    urllist[cnt] <-paste0("http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev?LAWD_CD=",locCode[i],
                          "&DEAL_YMD=",datalist[j],
                          "&numOfRows=",Num_of_Rows,
                          "&serviceKey=",service_key)
  }
}

# 5 개 지역 x 12 개월 = 총 60 개의 url 요청
# (Open API 서비스에 따라 접속 횟수를 제한하기도 하므로 따로 저장)
# (아파트매매 실거래 상세 자료의 경우 하루 1000건)

raw.data <- list()
rootNode <- list()

for(i in 1:length(urllist)){
  raw.data[[i]] <- xmlTreeParse(urllist[i], useInternalNodes = TRUE,encoding = "utf-8") # 생성한 URL 대로 XML 을 요청한다
  rootNode[[i]] <- xmlRoot(raw.data[[i]])
}


# 저장한 XML을 분석가능한 형태로 수정

total<-list()

for(i in 1:length(urllist)){
  
  item <- list()
  item_temp_dt<-data.table()
  
  items <- rootNode[[i]][[2]][['items']] # items 항목만 골라낸다
  
  size <- xmlSize(items) # 몇개의 item 이 있는지 확인한다
  
  for(j in 1:size){
    item_temp <- xmlSApply(items[[j]],xmlValue)
    item_temp_dt <- data.table( GU      = locCode_nm[i%/%12+1],
                                GU_CODE = locCode[i%/%12+1],
                                DATE = datalist[(i-1)%%12+1],
                                VAR1=item_temp[1],
                                VAR2=item_temp[2],
                                VAR3=item_temp[3],
                                VAR4=item_temp[4],
                                VAR5=item_temp[5],
                                VAR6=item_temp[6],
                                VAR7=item_temp[7],
                                VAR8=item_temp[8],
                                VAR9=item_temp[9],
                                VAR10=item_temp[10],
                                VAR11=item_temp[11],
                                VAR12=item_temp[12],
                                VAR13=item_temp[13],
                                VAR14=item_temp[14],
                                VAR15=item_temp[15],
                                VAR16=item_temp[16],
                                VAR17=item_temp[17],
                                VAR18=item_temp[18],
                                VAR19=item_temp[19],
                                VAR20=item_temp[20],
                                VAR21=item_temp[21],
                                VAR22=item_temp[22],
                                VAR23=item_temp[23],
                                VAR24=item_temp[24])
    
    item[[j]]<-item_temp_dt
  }
  total[[i]] <- rbindlist(item)
}

APT_SALES_ROSS <- rbindlist(total)


names(APT_SALES_ROSS) <- c("시군구코드","시군구","날짜","거래금액","건축년도","년","도로명","도로명건물본번호코드","도로명건물부번호코드",
                              "도로명시군구코드","도로명일련번호코드","도로명지상지하코드","도로명코드","법정동",
                              "법정동본번코드","법정동부번코드","법정동시군구코드","법정도읍면동코드","법정동지번코드",
                              "아파트","월","일","일련번호","전용면적","지번","지역코드","층")
head(APT_SALES_ROSS)

table(is.na(APT_SALES_16))
table(is.na(APT_SALES_16$시군구코드))
table(APT_SALES_16$시군구코드)


save(APT_SALES_ROSS,file="C:/dev/lab_r/data/pro/APT_SALES_ROSS.RData")
