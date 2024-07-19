# Kelliher_et_al_2022
Custom ImageJ macro and R scripts used in Kelliher et al 2022

### This code is associated with the 2022/2023 manuscript: "Nutritional compensation of the circadian clock is a conserved process influenced by gene expression regulation and mRNA stability".

pubmed link: https://pubmed.ncbi.nlm.nih.gov/36603054/

PLoS Biology publication: https://doi.org/10.1371/journal.pbio.3001961

bioRxiv preprint: https://www.biorxiv.org/content/10.1101/2022.05.09.491261v2

## To analyze Princeton Instruments .spe files, use the "ImageJ Macros" directory

A sample dataset is included: "2020-06-05_run 2020 June 12 03_17_19 150.spe"

### input dataset to analyze Princeton Instruments camera data have MOVED from Google Drive (Dartmouth) to OneDrive (UMass Boston) as of 2023

Please download the input data file from this OneDrive shared link: https://liveumb-my.sharepoint.com/:f:/g/personal/christina_kelliher_umb_edu/EokwgBHPdllHsY6ALm02IwcBYZA8RccuNH_Jq-DvdzywAA?e=m6q0jK

~~Please download the input data file from Google Drive: https://drive.google.com/drive/folders/1hdB1eWsTfNJr_K98bRY17Umur4HA5NPJ?usp=sharing~~

    Experiment strain # 1785-1: Neurospora crassa OR74A, FGSC2489, csr-1::frqCBoxp-luciferase::barR
    Experiment date: 2020-06-05 to 2020-06-12
    Experiment temperature: 24.9 +/- 0.4 C

    Key to race tubes (top to bottom of movie):
    1_top_rack. 0% glucose medium, technical replicate 1
    2_top_rack. 0% glucose medium, technical replicate 2
    3_top_rack. 0.05% w/v glucose medium, technical replicate 1
    4_top_rack. 0.05% w/v glucose medium, technical replicate 2
    5_top_rack. 0.1% w/v glucose medium, technical replicate 1
    6_top_rack. 0.1% w/v glucose medium, technical replicate 2
    1_bottom_rack. 0.25% w/v glucose medium, technical replicate 1
    2_bottom_rack. 0.25% w/v glucose medium, technical replicate 2
    3_bottom_rack. 0.5% w/v glucose medium, technical replicate 1
    4_bottom_rack. 0.5% w/v glucose medium, technical replicate 2
    5_bottom_rack. 1% w/v glucose medium, technical replicate 1
    6_bottom_rack. 1% w/v glucose medium, technical replicate 2

Install or open ImageJ or Fiji on your local machine: https://imagej.nih.gov/ij/; https://fiji.sc/

    If using ImageJ: install two plugins to manipulate SPE files: https://imagej.nih.gov/ij/plugins/spe.html; https://imagej.nih.gov/ij/plugins/file-handler.html

    File -> Open... "2020-06-05_run 2020 June 12 03_17_19 150.spe"
    
    Image -> Adjust -> Brightness/Contrast... to visualize the data by eye
    
    Plugins -> Macros -> Run...

You may also install the Macros downloaded from directory into ImageJ or Fiji by copying/moving the files into the Fiji Application folder:

    ImageJ.app/ or Fiji.app/macros/toolsets/Toolset Image Analysis Larrondo's Lab 1.0.txt
    ImageJ.app/ or Fiji.app/macros/toolsets/evenLinear_growth_front_tracking_macro.txt
    ImageJ.app/ or Fiji.app/macros/toolsets/oldTissue_growth_front_tracking_macro.txt
    
### There are 3 ways to analyse a Neurospora race tube dataset contained in the Princeton Instruments .spe file

### Analysis Type 1: Whole Race Tube ("analysis_whole_race_tube" directory)

Using this method, the user will specify a rectangle across one entire race tube. The Macro will automatically sub-divide the user's rectangle into a given number of segments. The Macro results file will return Average Bioluminescent Intensity values for each rectangle from each frame of the dataset, as well as a background region rectangle specified by the user.

Written tutorial for the "Toolset Image Analysis Larrondo's Lab 1.0.txt" Macro

    File -> Open... "2020-06-05_run 2020 June 12 03_17_19 150.spe"
    
    Image -> Adjust -> Brightness/Contrast... -> Auto
    
    Click the Red ">>" Icon on the toolbar and select "Toolset Image Analysis Larrondo's Lab 1.0" from the dropdown menu

    Click the new "RT" icon on the toolbar, click anywhere on Frame # 1 of the movie to start the analysis
    
    Enter the number of Frames in the popup: 150
    
    Choose the number of rectangle sub-divisions to use: 48
    
    Choose the race tube orientation: h
    
    Select the top left corner of the rectangle: x = 0, y = 75
    
    Select the top left corner of the rectangle: x = 1023, y = 75
    
    Select the bottom left corner of the rectangle: x = 0, y = 124
    
    Check the rectangle and sub-divisions, enter "Yes": y
    
    To save the config, enter "Yes": y
    
    Select a rectangle for the background region, example: 170 wide x 50 height rectangle in the top-right corner
    
    Enter "Yes" for image saturation: y
    
    Enter "Yes" to save Results file: y
    
    Close the SPE file and repeat for the next race tube (manually re-naming each Result file as needed)
    
Once all 12x race tubes from a given run are analyzed invidually, use the two R scripts: "runMult_RT_slice_avgs_csv.R" which calls "RaceTube_Slice_Averages.R" to background-correct and concatenate all race tubes together into one Results file

### Analysis Type 2: Growth Front Tissue Region of Race Tube ("analysis_growth_front_tissue" directory)

Using this method, the user will specify a fraction of the entire race tube to define the fungal "growth front". Choosing a very small region risks missing the signal. Choosing a very large region will be most similar to Whole Tube quantification described above. The user-specified rectangle will then progress linearly along the tube and quantify ONLY Average Bioluminescent Intensity values inside the rectangle from each frame of the dataset, as well as a background region rectangle specified by the user.

Written tutorial for the "evenLinear_growth_front_tracking_macro.txt" Macro

    File -> Open... "2020-06-05_run 2020 June 12 03_17_19 150.spe"
    
    Image -> Adjust -> Brightness/Contrast... -> Auto
    
    Plugins -> Macros -> Run... "evenLinear_growth_front_tracking_macro.txt"
    
    Enter the number of Frames RIGHT BEFORE the growth front runs off the field of view in the popup: 113
    
    Choose the rectangle fraction of the entire tube to use: 7
    
    Select the top left corner of the rectangle: x = 0, y = 75
    
    Select the top left corner of the rectangle: x = 1023, y = 75
    
    Select the bottom left corner of the rectangle: x = 0, y = 124
    
    Select the location of fungal inoculation to begin quantifying the growth front: x = 10
    
    Check the rectangle, enter "Yes": y
    
    To save the config, enter "Yes": y
    
    Watch as the rectangle moves linearly across the time course movie and ensure the fungal growth front is located in the yellow box!
    
    Select a rectangle for the background region, example: 170 wide x 50 height rectangle in the top-right corner
    
    Enter "Yes" for image saturation: y
    
    Enter "Yes" to save Results file: y
    
    Close the SPE file and repeat for the next race tube (manually re-naming each Result file as needed)
    
Once all 12x race tubes from a given run are analyzed invidually, use the two R scripts: "runMult_RT_slice_avgs_grFront_v3.R" which calls "RaceTube_Slice_Averages_grFront_v3.R" to background-correct and concatenate all race tubes together into one Results file

IMPORTANT NOTE: the above R script takes "Number of frames" as an input, only analyze in batch race tubes that have the same number of frames quantified (e.g. 113 / 150 frames for above example)

### Analysis Type 2: Old/Aging Tissue Region of Race Tube ("analysis_aging_old_tissue" directory)

Using this method, the user will specify a fraction of the entire race tube to define the fungal "old tissue". Choosing a very small region risks missing the signal. Choosing a very large region will be most similar to Whole Tube quantification described above. The user-specified rectangle will then appear near the point of inoculation and quantify ONLY Average Bioluminescent Intensity values inside the rectangle from each frame of the dataset, as well as a background region rectangle specified by the user.

Written tutorial for the "oldTissue_growth_front_tracking_macro.txt" Macro

    File -> Open... "2020-06-05_run 2020 June 12 03_17_19 150.spe"
    
    Image -> Adjust -> Brightness/Contrast... -> Auto
    
    Plugins -> Macros -> Run... "oldTissue_growth_front_tracking_macro.txt"
    
    Enter the number of Frames in the popup: 150
    
    Choose the rectangle fraction of the entire tube to use: 7
    
    Select the top left corner of the rectangle: x = 0, y = 75
    
    Select the top left corner of the rectangle: x = 1023, y = 75
    
    Select the bottom left corner of the rectangle: x = 0, y = 124
    
    Select the location of fungal inoculation to begin quantifying the old tissue: x = 10
    
    Check the rectangle, enter "Yes": y
    
    To save the config, enter "Yes": y
    
    Watch as the rectangle tracks the oldest region of growth across the time course movie in the yellow box!
    
    Select a rectangle for the background region, example: 170 wide x 50 height rectangle in the top-right corner
    
    Enter "Yes" for image saturation: y
    
    Enter "Yes" to save Results file: y
    
    Close the SPE file and repeat for the next race tube (manually re-naming each Result file as needed)
    
Once all 12x race tubes from a given run are analyzed invidually, use the two R scripts: "runMult_RT_slice_avgs_grFront_v3.R" which calls "RaceTube_Slice_Averages_grFront_v3.R" to background-correct and concatenate all race tubes together into one Results file

## To analyze 3' End Seq data, use the "custom 3' end Seq" directory

### questions? email Tina Kelliher at: christina.kelliher@umb.edu
