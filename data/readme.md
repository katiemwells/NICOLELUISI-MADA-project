About the Folders:

The sub-folder `raw_data` contains source data downloaded from AIDSVu (sub-folder `AIDSVu`). Subfolders within the `AIDSVu` folder are separated by geographic area (`National/NewDx`, `Region/NewDx`, `State/NewDx`). Note that state-level analyses are not included in this project but keeping these files handy for later. 

The sub-folder `processed_data` contains all processed data files used throughout the project. 
- The `allnewdx.rds` file contains the cleaned and combined data processed by the `processingcode.R` script. 
- The `.txt` files that begin with `"jp_"` are subsets reformatted and exported with the `processingcode.R` script for use in the Joinpoint program. 
- The `.xlsx` files that begin with `"djp_"` are data files processed by the desktop version of the external Joinpoint program. These files contain the results from the Joinpoint analysis in various sheets by type. The files are read in to the `analysis.qmd` file to produce tables and figures. 