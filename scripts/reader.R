library(tidyverse)


scriptDir<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste0(scriptDir,"/../"))


infile <- "pois/"

filelist <- setdiff(list.files(infile,full.names=T),
                    list.dirs(infile,recursive=F))

fin_tibble<-NULL

for(filename in filelist){

  file<-readBin(filename,
           "integer",
           size=4,
           signed = 2,
           n=200,
           endian="little")

  latitude<-file[20]/100000
  longitude<-file[21]/100000
  
  str<-read.table(filename,skipNul = T)[1,1] %>% 
    substr(3,12) %>% 
    gsub("]","",.) %>% 
    gsub("\u0001","",.)
  
  t<-tibble(datetime=c(str),longitude=c(longitude),latitude=c(latitude))
  fin_tibble<-bind_rows(fin_tibble,t)  
}

fin_tibble %>% filter(longitude>0 & latitude>0) %>% 
  write.csv("results/points_csv.csv")

fin_tibble %>% filter(longitude>0 & latitude>0) %>% 
  write.csv2("results/points_csv2.csv")

