## written in 2019-April by CMK
## run RaceTube_Slice_Averages.R on a directory of files
## modified on 2019-08-28 by CMK for growth front output

runMult_RT_slice_avgs_v3<-function(directory, frame=150) {
  
  source("~/Documents/RaceTube_Slice_Averages_grFront_v3.R")
  
  goPath<-as.character(directory)
  
  setwd(goPath)
  
  all_files <- list.files()
  
  output_files <- grep("csv", all_files)
  
  num_output_files <- length(grep("csv", all_files))
  
  for(i in 1:as.numeric(num_output_files)){
    
    curFile <- as.character(all_files[output_files[i]])
    
    name <- gsub(".csv","",curFile)
    
    out <- RT_slice_avgs_v3(curFile, numFrames = frame, bckgrCorr=TRUE)
    
    write.table(out, paste(goPath, name, "_out.txt", sep=""), quote=F, row.names=F, sep="\t")
    
  }
  
  all_files_2 <- list.files()
  
  output_files_2 <- grep("txt", all_files_2)
  
  num_output_files_2 <- length(grep("txt", all_files_2))
  
  whole_tube <- matrix(nrow=frame, ncol=as.numeric(num_output_files_2))
  
  for(i in 1:as.numeric(num_output_files_2)){
    
    curFile_2 <- as.character(all_files_2[output_files_2[i]])
    
    name_2 <- gsub(".txt","",curFile_2)
    
    curData <- as.data.frame(read.table(curFile_2, header=T))
    
    whole_tube[,i] <- curData[,2]
    
  }
  
  sub_files <- all_files_2[output_files_2]
  sub_names <- gsub(".txt","",sub_files)
  header <- c("TPs",sub_names)
  
  last_frame <- frame - 1
  TPs <- seq(0,last_frame, by=1)
  
  final_whole_tube <- cbind(TPs, whole_tube)
  final_whole_tube <- as.data.frame(final_whole_tube)
  names(final_whole_tube) <- header
  
  return(final_whole_tube)
  
}