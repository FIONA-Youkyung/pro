library(XML)
library(data.table)
library(stringr)
library(ggplot2)

rm(list =ls())

service_key <- "NPzUo7mqkq13NjGIx4k7rRIAAsmawhKYwVHb11qcoYGyhavfY%2BN699pqv8KXMqmHGpCvKIuOi%2BDKHYHzMUou0w%3D%3D "

#지역코드 
locCode <-c("11110","11140","11170","11200","11215","11230","11260","11290","11305","11320","11350",
            "11380","11410","11440","11470","11500","11530","11545","11560","11590","11620","11650","11680",
            "11710","11740")

locCode_nm <-c("종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구",
               "노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구",
               "관악구","서초구","강남구","송파구","강동구")

datalist <-c("201710","201711","201712","201801","201802","201803","201804","201805","201806","201807","201808","201809")


loc <-cbind(locCode,locCode_nm)
loc

Num_of_Rows <-100
urllist <-list()
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

raw.data <- list()

rootNode <- list()

for(i in 1:length(urllist)){
  raw.data[[i]] <- xmlTreeParse(urllist[i], useInternalNodes = TRUE,encoding = "utf-8") # 생성한 URL 대로 XML 을 요청한다
  rootNode[[i]] <- xmlRoot(raw.data[[i]])
}

total<-list()

xmlApply()

for(i in 1:length(urllist)){
  
  item <- list()
  item_temp_dt<-data.table()
  
  items <- rootNode[[i]][[2]][['items']] # items 항목만 골라낸다
  
  size <- xmlSize(items) # 몇개의 item 이 있는지 확인한다
  
  for(j in 1:size){
    item_temp <- xmlApply(items[[j]],xmlValue)
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


RESULTS_APT_SALES18_FIN <- rbindlist(total)
load

names(RESULTS_APT_SALES18_FIN) <- c("시군구코드","시군구","날짜","거래금액","건축년도","년","도로명","도로명건물본번호코드","도로명건물부번호코드",
                              "도로명시군구코드","도로명일련번호코드","도로명지상지하코드","도로명코드","법정동",
                              "법정동본번코드","법정동부번코드","법정동시군구코드","법정도읍면동코드","법정동지번코드",
                              "아파트","월","일","일련번호","전용면적","지번","지역코드","층")
head(RESULTS_APT_SALES18_FIN)
table(is.na(RESULTS_APT_SALES17_FIN))
str(RESULTS_APT_SALES15_FIN)
table(is.na(RESULTS_APT_SALES17_FIN$시군구코드))

save(RESULTS_APT_SALES17_FIN,file="C:/dev/lab_r/data/pro/RESULTS_APT_SALES17_FIN.RData")
