library(shiny)
library(ggplot2)
library(datasets)

head(datasets::WorldPhones)
head(demand)


ui <- fluidPage(
  selectInput(titlePanel("구별 아파트 공급물량"),
              label=h3("구 선택하기"),
              choices = list("종로구" = "종로구","중구" = "중구" ,"용산구" = "용산구" ,"성동구"= "성동구" ,"광진구" = "광진구" ,
                             "동대문구" = "동대문구" ,"중랑구" = "중랑구" ,"성북구" = "성북구","강북구" = "강북구","도봉구"="도봉구",
                             "노원구" = "노원구","은평구" = "은평구","서대문구" = "서대문구","마포구" = "마포구" ,"양천구" = "양천구",
                             "강서구" = "강서구","구로구" = "구로구","금천구" = "금천구","영등포구" = "영등포구" ,"동작구" = "동작구",
                             "관악구" = "관악구","서초구" = "서초구","강남구" = "강남구","송파구" = "송파구","강동구" = "강동구"),
              selected =1),
  hr(),
  fluidRow(column(3,verbatimTextOutput("value"))),
  helpText("부동산데이터 출처"),

plotOutput(outputId = "main_plot", height ="300px")
)
)

server <-function(input,output){
  output$mainPlot <-renderPlot({
    hist())})
} 



shinyApp(ui=ui,server=server) 
