About the Folders:

Sub-folder `processing_code` contains R script `processingcode.R` [#1] which reads in the raw data files, performs data cleaning tasks, and prepares various output files for later use. This R file is the first to run in the series.

Sub-folder `analysis_code` contains several files for the analysis work. The Quarto file `exploratory_analysis.qmd` [#2] does some exploratory analysis of the variables prior to any statistical methods. The R script `joinpoint_analysis.R` [#3] does some statistical analysis and saves the results (see notes re: some limitations with repeating). The Quarto file `analysis.qmd` [#4] produces tables and figures for the final analysis. 