###############################
# Joinpoint analysis script
#
# This script loads the processed, cleaned data, does some analysis and saves the results 

######################################
######################################

# NOTE: 

# This analysis uses a proprietary software package available from the NIH (https://surveillance.cancer.gov/joinpoint/)
# The R callable software must be requested from NIH and installed on the users local machine
# The nih.joinpoint package referenced here will NOT work unless the R callable version of the software is installed 

# Because of this and some issues with specific R callable options, the desktop version of the software was used for some analyses
# All result tables from external joinpoint analyses are available in the data/processed_data folder so tables and plots can be reproduced 

######################################
######################################

# Load packages
library(ggplot2) 
library(kableExtra)
library(here)
library(tidyverse)
#devtools::install_github("DanChaltiel/nih.joinpoint")
library(nih.joinpoint)

# Path to data using HERE package
data_location <- here::here("data","processed_data","processeddata.rds")

######################################
# Data fitting/statistical analysis
######################################

# Joinpoint program settings/options
options(joinpoint_path="C:/Program Files (x86)/Joinpoint Command/jpCommand.exe")
run_opt = run_options(model="ln", max_joinpoints=3, n_cores=3)
export_opt = export_options()


# Overall APC
jp_tot_run = joinpoint(jp_tot, x=Year, y=Rate, by=Geo,
                       run_opts=run_opt, export_opts=export_opt)
jp_total_results<-jp_tot_run[["apc"]]

jp_total_results<-jp_total_results %>% dplyr::select(-c("model", "segment", "apc_significant"))
jp_total_results<-jp_total_results %>% arrange(match(geo, c("United States", "Northeast", "Midwest", "South", "West")), (segment_start))
kable(jp_total_results,caption = "Joinpoint Results, Overall by Geographic Region", 
      col.names=c("Region", "Start Year", "End Year", "Annual % Change (APC)", "APC 95LCL", "APC 95UCL", 
                  "Test Statistic",  "p-value"), align="rc") %>% 
  row_spec(row = 0, color = "white", background = "#004987") %>% kable_styling(full_width=T, bootstrap_options = "striped", font_size=10)  

# Commenting out file save since analysis using proprietary software will not be reproduced
#table_file1 = here("results", "joinpoint_rcallable_result_tables", "jp_total_results.rds")
#saveRDS(jp_total_results, file = table_file1)


# APC by Race
jp_race_run = joinpoint(jp_race, x=Year, y=Rate, by=c(Geo,Race),
                       run_opts=run_opt, export_opts=export_opt)
jp_race_results<-jp_race_run[["apc"]]

jp_race_results<-jp_race_results %>% dplyr::select(-c("model", "segment", "apc_significant"))
jp_race_results<-jp_race_results %>% arrange(match(geo, c("United States", "Northeast", "Midwest", "South", "West")), (race), (segment_start))
kable(jp_race_results,caption = "Joinpoint Results, Overall by Race and Geographic Region", 
      col.names=c("Region", "Race", "Start Year", "End Year", "Annual % Change (APC)", "APC 95LCL", "APC 95UCL", 
                  "Test Statistic",  "p-value"), align="rc") %>% 
  row_spec(row = 0, color = "white", background = "#004987") %>% kable_styling(full_width=T, bootstrap_options = "striped", font_size=10)  

# Commenting out file save since analysis using proprietary software will not be reproduced
#table_file2 = here("results", "joinpoint_rcallable_result_tables", "jp_race_results.rds")
#saveRDS(jp_race_results, file = table_file2)


# APC by Age
jp_age_run = joinpoint(jp_age, x=Year, y=Rate, by=c(Geo,Age),
                        run_opts=run_opt, export_opts=export_opt)
jp_age_results<-jp_age_run[["apc"]]

jp_age_results<-jp_age_results %>% dplyr::select(-c("model", "segment", "apc_significant"))
jp_age_results<-jp_age_results %>% arrange(match(geo, c("United States", "Northeast", "Midwest", "South", "West")), (age), (segment_start))
kable(jp_age_results,caption = "Joinpoint Results, Overall by Age and Geographic Region", 
      col.names=c("Region", "Age", "Start Year", "End Year", "Annual % Change (APC)", "APC 95LCL", "APC 95UCL", 
                  "Test Statistic",  "p-value"), align="rc") %>% 
  row_spec(row = 0, color = "white", background = "#004987") %>% kable_styling(full_width=T, bootstrap_options = "striped", font_size=10)  

# Commenting out file save since analysis using proprietary software will not be reproduced
#table_file3 = here("results", "joinpoint_rcallable_result_tables", "jp_age_results.rds")
#saveRDS(jp_age_results, file = table_file3)


# APC by Sex
jp_sex_run = joinpoint(jp_sex, x=Year, y=Rate, by=c(Geo,Sex),
                       run_opts=run_opt, export_opts=export_opt)
jp_sex_results<-jp_sex_run[["apc"]]

jp_sex_results<-jp_sex_results %>% dplyr::select(-c("model", "segment", "apc_significant"))
jp_sex_results<-jp_sex_results %>% arrange(match(geo, c("United States", "Northeast", "Midwest", "South", "West")), (sex), (segment_start))
kable(jp_sex_results,caption = "Joinpoint Results, Overall by Sex and Geographic Region", 
      col.names=c("Region", "Sex", "Start Year", "End Year", "Annual % Change (APC)", "APC 95LCL", "APC 95UCL", 
                  "Test Statistic",  "p-value"), align="rc") %>% 
  row_spec(row = 0, color = "white", background = "#004987") %>% kable_styling(full_width=T, bootstrap_options = "striped", font_size=10) 

# Commenting out file save since analysis using proprietary software will not be reproduced
#table_file4 = here("results", "joinpoint_rcallable_result_tables", "jp_sex_results.rds")
#saveRDS(jp_sex_results, file = table_file4)


# APC for black-white rate ratios
jp_raceratio_run = joinpoint(jp_raceratios, x=Year, y=Rate, by=c(Geo,RaceRatio),
                       run_opts=run_opt, export_opts=export_opt)
jp_raceratio_results<-jp_raceratio_run[["apc"]]
#jp_raceratio_results<-jp_raceratio_run[["aapc"]]

jp_raceratio_results<-jp_raceratio_results %>% dplyr::select(-c("model", "segment", "apc_significant"))
jp_raceratio_results<-jp_raceratio_results %>% arrange(match(geo, c("United States", "Northeast", "Midwest", "South", "West")), (race_ratio), (segment_start))
kable(jp_raceratio_results,caption = "Joinpoint Results, Overall by Race Ratio and Geographic Region", 
      col.names=c("Region", "Race-Ratio", "Start Year", "End Year", "Annual % Change (APC)", "APC 95LCL", "APC 95UCL", 
                  "Test Statistic",  "p-value"), align="rc") %>% 
  row_spec(row = 0, color = "white", background = "#004987") %>% kable_styling(full_width=T, bootstrap_options = "striped", font_size=10) 

# Commenting out file save since analysis using proprietary software will not be reproduced
#table_file5 = here("results", "joinpoint_rcallable_result_tables", "jp_raceratio_results.rds")
#saveRDS(jp_raceratio_results, file = table_file5)











#############################################################################
#                                                                           #
# This Example R program will execute the command-line version of the       #
# Joinpoint software and will display the AAPC results from the Joinpoint   #
# analysis.  A similar approach can be used to display other Joinpoint      #
# analysis results of interest.  The Joinpoint documentation and the R      #
# documentation provide additional details that users may consider.  The    #
# JP_COMMAND_README.txt file provides information to help users of the      #
# command-line version of Joinpoint.                                        #
#                                                                           #
# The following two steps will enable users to call the command-line        #
# version of Joinpoint from this R program.                                 #
#                                                                           #
# First, unzip the zip file and ensure that the following directory or      # 
# folder:                                                                   #
#   C:/Joinpoint_Callable/R_Sample_Files                                    #
# contains the RExample.User.Created.Session.ini, RExample.JPOptions.ini,   #
# and Sample.Data.txt files.                                                #
#                                                                           #
# Second, use R to run this RExample.r program.  The R documentation        # 
# provides additional details (e.g. see the "source" function).             #
#                                                                           #
#############################################################################

# Specify a label for the example 
#example.label <- "RExample"

# Specify the working directory or folder  

#workdir <- "C:/Program Files (x86)/Joinpoint Command/"
#filedir <- "C:/Program Files (x86)/Joinpoint Command/R_Sample_Files/"
#setwd(workdir)

# Create an input file for the Joinpoint program, and run the Joinpoint program 
#jprun.ini.file = paste0(example.label, ".JPRun.ini")

#cat(file = jprun.ini.file, "[Joinpoint Input Files]\n", append = FALSE)
#cat(file = jprun.ini.file, paste0("Session File=", filedir, "RExample.User.Created.Session.ini\n"), append = TRUE)
#cat(file = jprun.ini.file, paste0("Output File=", filedir, example.label, ".jpo\n"), append = TRUE)
#cat(file = jprun.ini.file, paste0("Export Options File=", filedir, "RExample.JPOptions.ini\n"), append = TRUE)
#cat(file = jprun.ini.file, paste0("Run Options File=", filedir, "RExample.JPOptions.ini"), append = TRUE)

#system(paste("jpcommand.exe", jprun.ini.file))
#setwd(filedir)

# Read the AAPC results from the Joinpoint analysis
# AAPCdataframe <- read.table(paste0(example.label, ".aapcexport.txt"), header= TRUE)

# Display the AAPC results from the Joinpoint analysis
#print(attributes(AAPCdataframe))
#print(AAPCdataframe, digits=5)







