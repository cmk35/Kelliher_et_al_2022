## written in 2019-Jan by CMK
## re-construct Larrondo Lab "Racetube Analysis Sheet" Excel Macro in R

RT_slice_avgs <- function(path_to_dataset, numSlices=40, numFrames=144, bckgrCorr=TRUE){
  
  # data <- as.data.frame(read.table(as.character(path_to_dataset)))
  ## R reads in *.xls from ImageJ output with header and row #s
  data <- as.data.frame(read.csv(as.character(path_to_dataset)))
  ## R reads in *.csv from Fiji output with header and row #s
  
  slices_seq <- seq(from=1, to=numSlices, by=1)
  last_line_slices <- as.numeric(numSlices * numFrames)
  slices <- data[1:last_line_slices,]
  #slices_mean <- slices[,2]
  slices_mean <- slices[,3]
  slices_df <- cbind(slices_seq,slices_mean)
  slices_df_2 <- as.data.frame(slices_df)
  slices_sort <- slices_df_2[order(slices_df_2$slices_seq),]
  ## *.xls file is organized with # slices quantified from each frame / TP
  
  last_line <- as.numeric(nrow(data))
  first_line_bckgr <- last_line - (numFrames - 1)
  bckgr <- data[first_line_bckgr:last_line,]
  #bckgr_mean <- bckgr[,2]
  bckgr_mean <- bckgr[,3]
  bckgr_mtx <- as.matrix(bckgr_mean)
  ## *.xls file has at the end background only quantified from 0 - end time course
  
  output <- matrix(nrow=numFrames, ncol=numSlices)
  
  count <- 1
  
  if(bckgrCorr == TRUE){
    for(i in 1:numSlices){
      
      curr_means <- slices_sort[count:(numFrames*i), 2]
      curr_bckgr_means <- curr_means - bckgr_mtx
      output[,i] <- curr_bckgr_means
      count <- count + numFrames
      
    }
    
  } else {
    for(i in 1:numSlices){
      
      curr_means <- slices_sort[count:(numFrames*i), 2]
      output[,i] <- curr_means
      count <- count + numFrames
      
    }
  
  }
  
  output_all <- output[,1:numSlices]
  average_all <- apply(output_all,1,mean)
  
  output_first10 <- output[,1:10]
  average_first10 <- apply(output_first10,1,mean)
  
  output_first20 <- output[,1:20]
  average_first20 <- apply(output_first20,1,mean)
  
  time <- seq(from=0, to=(numFrames-1), by=1)
  
  ## concatenate all into one file
  
  header_1 <- c("Frame", "Average_allFrames", "Average_first10Frames", "Average_first20Frames")
  header_2 <- slices_seq
  header <- c(header_1, header_2)
  output_cat <- cbind(time, average_all, average_first10, average_first20, output)
  final_output <- as.data.frame(output_cat)
  names(final_output) <- header
  
  return(final_output)
}