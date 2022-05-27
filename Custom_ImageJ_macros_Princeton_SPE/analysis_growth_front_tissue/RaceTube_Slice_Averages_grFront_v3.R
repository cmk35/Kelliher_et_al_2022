## written in 2019-Jan by CMK
## re-construct Larrondo Lab "Racetube Analysis Sheet" Excel Macro in R
## modified on 2019-08-28 for growth front modifications

RT_slice_avgs_v3 <- function(path_to_dataset, numFrames=144, bckgrCorr=TRUE){
  
  data <- as.data.frame(read.csv(as.character(path_to_dataset)))
  ## R reads in *.csv from Fiji output with header and row #s
  
  last_line_data <- as.numeric(numFrames)
  grFront <- data[1:last_line_data,]
  grFront_mean <- grFront[,3]
  grFront_mtx <- as.matrix(grFront_mean)
  ## *.csv file has data first chunk
  
  last_line <- as.numeric(nrow(data))
  first_line_bckgr <- last_line - (numFrames - 1)
  bckgr <- data[first_line_bckgr:last_line,]
  bckgr_mean <- bckgr[,3]
  bckgr_mtx <- as.matrix(bckgr_mean)
  ## *.csv file has at the end background only quantified from 0 - end time course
  
  output <- matrix(nrow=numFrames, ncol=2)
  TPs <- seq(from=0, to=(numFrames-1), by=1)
  
  if(bckgrCorr == TRUE){
    
    curr_bckgr_means <- grFront_mtx - bckgr_mtx
    output[,1] <- TPs
    output[,2] <- curr_bckgr_means
    
  } else {
    
    output[,1] <- TPs
    output[,2] <- grFront_mtx
  }
  
  ## concatenate all into one file
  
  header_1 <- c("Frame", "Avg_GrFront")
  final_output <- as.data.frame(output)
  names(final_output) <- header_1
  
  return(final_output)
}