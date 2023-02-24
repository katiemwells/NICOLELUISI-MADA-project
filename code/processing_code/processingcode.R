###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder
#
# Note the ## ---- name ---- notation
# This is done so one can pull in the chunks of code into the Quarto document
# see here: https://bookdown.org/yihui/rmarkdown-cookbook/read-chunk.html


## ---- packages --------
#load needed packages. make sure they are installed.
library(readxl) #for loading Excel files
library(dplyr) #for data processing/cleaning
library(tidyr) #for data processing/cleaning
library(skimr) #for nice visualization of data 
library(here) #to set paths
library(plotly)
library(gt)

## ---- loaddata --------
#path to data
#note the use of the here() package and not absolute paths
nat_newdx_files <- list.files(path = (here("data","raw_data", "AIDSVu", "National", "NewDx")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows  
reg_newdx_files <- list.files(path = (here("data","raw_data", "AIDSVu", "Region", "NewDx")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#st_newdx_files <- list.files(path = (here("data","raw_data", "AIDSVu", "State", "NewDx")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 

#nat_pnr_files <- list.files(path = (here("data","raw_data", "AIDSVu", "National", "PNR")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#nat_prep_files <- list.files(path = (here("data","raw_data", "AIDSVu", "National", "PrEP")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#reg_pnr_files <- list.files(path = (here("data","raw_data", "AIDSVu", "Region", "PNR")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#reg_prep_files <- list.files(path = (here("data","raw_data", "AIDSVu", "Region", "PrEP")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#st_pnr_files <- list.files(path = (here("data","raw_data", "AIDSVu", "State", "PNR")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 
#st_prep_files <- list.files(path = (here("data","raw_data", "AIDSVu", "State", "PrEP")), pattern = "*.xlsx", full.names = T) %>% lapply(readxl::read_excel, skip = 2, col_names = T) %>% bind_rows 

## ---- combinedata --------
#national<-Reduce(function(x,y) merge(x,y,by="Year",all=T),
#       list(nat_newdx_files, nat_pnr_files, nat_prep_files))
#region<-Reduce(function(x,y) merge(x,y,by=c("Year", "Region"),all=T),
#                 list(reg_newdx_files, reg_pnr_files, reg_prep_files))
#state<-Reduce(function(x,y) merge(x,y,by=c("Year", "GEO ID"),all=T),
#               list(st_newdx_files, st_pnr_files, st_prep_files))

## ---- exploredata --------

# national
names(nat_newdx_files)
national_sub_newdx <- nat_newdx_files %>% dplyr::select("Year", "Geography", "New Diagnoses National Rate",
                        "New Diagnoses Male Rate", "New Diagnoses Female Rate",                                                                   
                        "New Diagnoses Black Rate", "New Diagnoses White Rate", "New Diagnoses Hispanic Rate", "New Diagnoses Asian Rate",                                                                    
                        "New Diagnoses American Indian/Alaska Native Rate", "New Diagnoses Multiple Race Rate", "New Diagnoses Native Hawaiian/Other Pacific Islander Rate",                                   
                        "New Diagnoses Age 13-24 Rate", "New Diagnoses Age 25-34 Rate", "New Diagnoses Age 35-44 Rate", "New Diagnoses Age 45-54 Rate", "New Diagnoses Age 55+ Rate")
names(national_sub_newdx) <- c("Year", "Geo", "Overall_Rate","Male_Rate", "Female_Rate", "Black_Rate", "White_Rate", "Hispanic_Rate", "Asian_Rate",                                                                    
                            "AIAN_Rate", "MultRace_Rate", "NHPI_Rate", "Age13t24_Rate", "Age25t34_Rate", "Age35t44_Rate", "Age45t54_Rate", "Age55p_Rate")

dplyr::glimpse(national_sub_newdx)
summary(national_sub_newdx)
head(national_sub_newdx)
skimr::skim(national_sub_newdx)

# regional
names(reg_newdx_files)
regional_sub_newdx <- reg_newdx_files %>% dplyr::select("Year", "Region", "Regional Rate", "Male Rate", "Female Rate", "Black Rate", "White Rate", "Hispanic Rate", "Asian Rate",
                                                        "American Indian/Alaska Native Rate", "Multiple Races Rate", "Native Hawaiian/Other Pacific Islander Rate",                                   
                                                        "Age 13-24 Rate", "Age 25-34 Rate", "Age 35-44 Rate", "Age 45-54 Rate", "Age 55+ Rate") 
names(regional_sub_newdx) <- c("Year", "Geo", "Overall_Rate","Male_Rate", "Female_Rate", "Black_Rate", "White_Rate", "Hispanic_Rate", "Asian_Rate",                                                                    
                               "AIAN_Rate", "MultRace_Rate", "NHPI_Rate", "Age13t24_Rate", "Age25t34_Rate", "Age35t44_Rate", "Age45t54_Rate", "Age55p_Rate")

dplyr::glimpse(regional_sub_newdx)
summary(regional_sub_newdx)
head(regional_sub_newdx)
skimr::skim(regional_sub_newdx)


## ---- cleandata1 --------

# national
# create rate ratios and round 
# sex
national_sub_newdx$female_male_rateratio<-round(national_sub_newdx$Female_Rate/national_sub_newdx$Male_Rate, digits=1)
# race/ethnicity
national_sub_newdx$black_white_rateratio<-round(national_sub_newdx$Black_Rate/national_sub_newdx$White_Rate, digits=1)
national_sub_newdx$hispanic_white_rateratio<-round(national_sub_newdx$Hispanic_Rate/national_sub_newdx$White_Rate, digits=1)
national_sub_newdx$asian_white_rateratio<-round(national_sub_newdx$Asian_Rate/national_sub_newdx$White_Rate, digits=1)
national_sub_newdx$aian_white_rateratio<-round(national_sub_newdx$AIAN_Rate/national_sub_newdx$White_Rate, digits=1)
national_sub_newdx$multrace_white_rateratio<-round(national_sub_newdx$MultRace_Rate/national_sub_newdx$White_Rate, digits=1)
national_sub_newdx$nhpi_white_rateratio<-round(national_sub_newdx$NHPI_Rate/national_sub_newdx$White_Rate, digits=1)
# age
national_sub_newdx$age13t24_age35t44_rateratio<-round(national_sub_newdx$Age13t24_Rate/national_sub_newdx$Age35t44_Rate, digits=1)
national_sub_newdx$age25t34_age35t44_rateratio<-round(national_sub_newdx$Age25t34_Rate/national_sub_newdx$Age35t44_Rate, digits=1)
national_sub_newdx$age45t54_age35t44_rateratio<-round(national_sub_newdx$Age45t54_Rate/national_sub_newdx$Age35t44_Rate, digits=1)
national_sub_newdx$age45t54_age55p_rateratio<-round(national_sub_newdx$Age55p_Rate/national_sub_newdx$Age35t44_Rate, digits=1)

# regional
# create rate ratios and round 
# sex
regional_sub_newdx$female_male_rateratio<-round(regional_sub_newdx$Female_Rate/regional_sub_newdx$Male_Rate, digits=1)
# race/ethnicity
regional_sub_newdx$black_white_rateratio<-round(regional_sub_newdx$Black_Rate/regional_sub_newdx$White_Rate, digits=1)
regional_sub_newdx$hispanic_white_rateratio<-round(regional_sub_newdx$Hispanic_Rate/regional_sub_newdx$White_Rate, digits=1)
regional_sub_newdx$asian_white_rateratio<-round(regional_sub_newdx$Asian_Rate/regional_sub_newdx$White_Rate, digits=1)
regional_sub_newdx$aian_white_rateratio<-round(regional_sub_newdx$AIAN_Rate/regional_sub_newdx$White_Rate, digits=1)
regional_sub_newdx$multrace_white_rateratio<-round(regional_sub_newdx$MultRace_Rate/regional_sub_newdx$White_Rate, digits=1)
regional_sub_newdx$nhpi_white_rateratio<-round(regional_sub_newdx$NHPI_Rate/regional_sub_newdx$White_Rate, digits=1)
# age
regional_sub_newdx$age13t24_age35t44_rateratio<-round(regional_sub_newdx$Age13t24_Rate/regional_sub_newdx$Age35t44_Rate, digits=1)
regional_sub_newdx$age25t34_age35t44_rateratio<-round(regional_sub_newdx$Age25t34_Rate/regional_sub_newdx$Age35t44_Rate, digits=1)
regional_sub_newdx$age45t54_age35t44_rateratio<-round(regional_sub_newdx$Age45t54_Rate/regional_sub_newdx$Age35t44_Rate, digits=1)
regional_sub_newdx$age45t54_age55p_rateratio<-round(regional_sub_newdx$Age55p_Rate/regional_sub_newdx$Age35t44_Rate, digits=1)

#regional_northeast_sub_newdx <- regional_sub_newdx %>% filter(Geo %in% c("Northeast"))
#regional_midwest_sub_newdx <- regional_sub_newdx %>% filter(Geo %in% c("Midwest"))
#regional_south_sub_newdx <- regional_sub_newdx %>% filter(Geo %in% c("South"))
#regional_west_sub_newdx <- regional_sub_newdx %>% filter(Geo %in% c("West"))


## ---- savedata --------
allnewdx<-rbind(national_sub_newdx,regional_sub_newdx)
save_data_location <- here::here("data","processed_data","allnewdx.rds")
saveRDS(allnewdx, file = save_data_location)


## ---- notes --------




