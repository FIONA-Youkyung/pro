rm(list=ls())
load("C:/dev/lab_r/Data/프로젝트/RESULTS_APT_SALES14_17.RData")
load("C:/dev/lab_r/Data/프로젝트/RESULTS_APT_SALES18_19.RData")
APT_SALES <-rbind(RESULTS_APT_SALES14_17,RESULTS_APT_SALES18_19)
str(APT_SALES)
table(APT_SALES$년)
sum(is.na(APT_SALES))
colSums(is.na(APT_SALES)) # 결측치가 어느 열에 있는지 확인해줌 
table(APT_SALES$지역코드)
table(APT_SALES$도로명시군구코드)

loc <-rename(loc,"도로명시군구코드"="locCode")
search()
library(dplyr)
str(loc)
loc <-as.data.frame(loc)
loc <- as.data.table(loc)

str(APT_SALES)
str(loc)
loc$도로명시군구코드<-as.character(loc$도로명시군구코드)
loc$locCode_nm <- as.character(loc$locCode_nm)
loc <- as.data.frame(loc)
str(loc)

#결측치 처리가 더 필요하지만, 데이터 추가적으로 받아본 후 처리하는 것으로 함. 
#다음 지도 api로부터 좌표계 가지고 오기 

daum_api_group <- as.data.table(APT_SALES)

for(i in 1:nrow(daum_api_group)){
  
  post_1 <- "서울시"
  post_2 <- daum_api_group[i, ]$도로명
  
  # post_1 <- iconv(post_1, from = "cp949", to = "UTF-8")
  # post_2 <- iconv(post_2, from = "cp949", to = "UTF-8")
  
  post <- paste(post_1, post_2)
  
  post_url <- URLencode(post)
  
  url <- paste0("https://apis.daum.net/local/geo/addr2coord?apikey=...&q=",
                post_url,
                "&output=json")
  
  url_query <- readLines(url)
  
  url_json <- fromJSON(paste0(url_query, collapse = ""))
  
  x_point <- url_json$channel$item$point_x
  y_point <- url_json$channel$item$point_y
  
  daum_api_group[i, x_ := x_point]
  daum_api_group[i, y_ := y_point]
  
}


