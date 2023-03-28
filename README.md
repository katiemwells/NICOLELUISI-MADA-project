# About the Project:

The purpose of this analysis is to analyze US trends in new HIV diagnoses over the past 10 years. This analysis will focus on new HIV diagnoses between 2008-2020; subgroups will include region, age group, gender, and race/ethnicity.

# How to Reproduce This Analysis:

1. Source data files are provided in `data/raw_data/AIDSVu`.

2. Within `code/processing_code` the R script `processingcode.R` can be used to read in the raw data files, perform data cleaning tasks, and prepare various output files for later use. 

3. Within `code/analysis_code` the Quarto file `exploratory_analysis.qmd` can be used to load the processed, cleaned data, and do some exploratory analysis of the variables.

4. **IMPORTANT!** The statistical analysis for this project requires the use of a proprietary software package that must be requested from the NIH and installed on the users local machine. In order to make the rest of the code reproducible (*approved by Dr Handel*), the results from that analysis have been provided in datasets within `data/processed_data`. In addition to using the desktop software application referenced here, a command line version was also used and the script is included here fir reference (`code/analysis_code/joinpoint_analysis.R`) but users will NOT be able to run this code without errors if the software is not installed. Because all analysis results were provided in datasets, users can proceed with step 5 and reproduce all final result materials. 

5. Within `code/analysis_code` the Quarto file `analysis.qmd` can be used to load the processed, cleaned data, and produce tables and figures for the final analysis. 


# About the Folders:

The sub-folder `code` contains script files to clean, process, and analyze data.

The sub-folder `data` contains raw source data and any other processed data files. The sub-folder `raw_data` contains source data downloaded from AIDSVu (sub-folder `AIDSVu`). Subfolders within the `AIDSVu` folder are separated by geographic area (`National/NewDx`, `Region/NewDx`, `State/NewDx`).

The sub-folder `products` contains the manuscript and other materials. At this time (project Part 3) most of these files are not yet in use, with the exception of the Quarto manuscript file. 

The sub-folder `results` contains any output files from the analysis for tables, figures, etc.



