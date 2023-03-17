About the Files:

`exploratory_analysis.qmd`: This Quarto file loads the processed, cleaned data, and does some exploratory analysis of the variables prior to any statistical methods.

`joinpoint_analysis.R`: This R script file loads the processed, cleaned data, does some analysis and saves the results. 
NOTE: This analysis uses a proprietary software package available from the NIH (https://surveillance.cancer.gov/joinpoint/). The R callable software must be requested from NIH and installed on the users local machine. The "nih.joinpoint"" package referenced here will NOT work unless the R callable version of the software is installed on the users machine. Because of this and some issues with specific R callable options, the desktop version of the software was used for some analyses. All result tables from the external joinpoint analyses are available in the data/processed_data folder so tables and plots can be reproduced.

`analysis.qmd`: This Quarto file loads the processed, cleaned data, and produces tables and figures for the final analysis. 