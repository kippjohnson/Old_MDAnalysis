#####################################################################################
# SaltBridgeCompiler.R
#####################################################################################
#
#
# Usage: Set the working directory to a directory filled with the output of VMD's
#        salt-bridge output (i.e., a number of files with the frame in column one and
#        distance of salt bridge in column two) and then run. It makes sense to choose
#        cutoff as the same cutoff used in the tool and "percent_cutoff" as a value
#        near 25%. If there are any salt bridges you wish to exclude, remove them from
#        the working directory.
#
#        In the line: saltBrCount <- matrix(data=NA,nrow=length(dir()), ncol= ) 
#           
#        Choose "ncol=" to be the final frame that you wish to analyze.
#
#		 This is in R because I wanted to graph it quickly.
#
#####################################################################################

setwd("/Users/kwj/Desktop/LAST-effort/SaltBr/2LMN-40/")
structureName <- "2LMN-40"

filenames <- list.files(".", pattern="*.dat", full.names=TRUE)

cutoff <- 3.2 # length of cutoff in Å
percent_cutoff <- 0.25 # percent of steps needed to be under cutoff
	 				   # to count as salt_bridge

saltBrCount <- matrix(data=NA,nrow=length(dir()), ncol=464) #row=number of files
                                                            #column=each ts
i <- 0
for(name_i in filenames){
  i = i + 1
  
  tmp <- read.table(name_i, sep=" ")
  
  if(length(which(tmp[,2] <= cutoff ))/length(tmp[,2]) >= percent_cutoff){
    print(name_i)} # Print what salt bridges you are actually using (for reference)
  
  if(length(which(tmp[,2] <= cutoff )/length(tmp[,2]) >= percent_cutoff){
    
    for(ts in 1:length(tmp[,1])){
      
      if(tmp[ts,2] <= cutoff){

        saltBrCount[i, ts] <- 1
      }else{
        saltBrCount[i, ts] <- 0
      }
    }
  }
}

fileCount <- dim(saltBrCount)[1] # Not used, just handy
tsCount <- dim(saltBrCount)[2]
sumSaltBr_2LMN40 <- numeric() # Name change advised

for(j in 1:tsCount){
  sumSaltBr_2LMN40[j] <- sum(saltBrCount[,j], na.rm=TRUE)
}

plot(sumSaltBr_2LMN40, type="l",main=paste(structureName),xlab="Frame",ylab="Number of Salt Bridges")