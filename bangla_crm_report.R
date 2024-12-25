#Bangladesh report from crm to google sheet
library(tidyverse)
library(googledrive)
library(googlesheets4)
library(RMySQL)
library(plyr)

drive_auth(cache  = ".secretsap",email = "ap.kheloyaar@gmail.com")
gs4_auth(token = drive_token())


#banglades crm database credentials
bang.server = "localhost"
bang.username = "u429143136_bangladesh"
bang.database = "u429143136_bangladesh"
bang.password = "@qqCTP3z9mP"
bang.host     = "srv1655.hstgr.io"

while(T){

  assign('success',TRUE,envir = .GlobalEnv)
  while(success){
    assign('looping',TRUE,envir = .GlobalEnv)
    tryCatch({
      assign('con',value =dbConnect(MySQL(),user=bang.username,password=bang.password,dbname=bang.database,host="srv1655.hstgr.io",port=3306),envir = .GlobalEnv )
      q <- dbReadTable(con,'call_status_clients')
      dbDisconnect(con)
      
      q<-q[q$Call_Date>=Sys.Date()-7,]
      q$Call_Date<-ymd(q$Call_Date)
      range_write("1MOAu_7phLqv_m6YiDmU_tzB3ocApGM-FOa446C6aDpI",data = q,sheet = 'data',col_names = T,reformat = T )
      cat('data is uploaded in the sheet \n')
    },error=function(e){
      assign('looping',FALSE,envir = .GlobalEnv)
      cat('There is some error in the process waitng from some time and trying again \n')
      Sys.sleep(10)
    })
    
    if(looping){
      assign('success',FALSE,envir=.GlobalEnv)
      
    }

  }

Sys.sleep(5*60)

}
