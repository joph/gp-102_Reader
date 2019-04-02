library(tidyverse)


scriptDir<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste0(scriptDir,"/../"))


infile <- "pois/"

filelist <- setdiff(list.files(infile,full.names=T),
                    list.dirs(infile,recursive=F))

file <- filelist[1] %>% 
        readLines %>% 
        tibble() %>% 
        rename(line = 1) %>% 
        mutate(date=substr(line,12,12+9)) %>% 
        mutate(latitude=parseCoord(line,76)) %>% 
        mutate(longitude=parseCoord(line,80))
  


parseCoord <- function(str,pos){
  str_out = substr(str,pos,pos+4) %>% rawToChar()
  
  return(paste0(substr(str_out, 1, 3),'.',substr(str_out, 2)))
}

