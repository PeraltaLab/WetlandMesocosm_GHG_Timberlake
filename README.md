# Timberlake_GHG_mesocosm

This repository contains open-source code, data, & text files.

For information regarding the project, please visit: 

Bledsoe, R.B., Finlay, C.G., and Peralta, A.L., 2024. Plant-microbe-mediated decrease of greenhouse gases under dynamic wetland hydrology. bioRxiv. *[PDF](https://www.biorxiv.org/content/10.1101/2020.06.29.178533v3)*  

Raw amplicon sequence files can be found at NCBI SRA [BioProject ID PRJNA636184](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA636184).

Peralta, A.L., Bledsoe, R.B., Muscarella, M.E., Huntemann, M., Clum, A., Foster, B., Foster, B., Roux, S., Palaniappan, K., Varghese, N. and Mukherjee, S., 2020. Metagenomes from Experimental Hydrologic Manipulation of Restored Coastal Plain Wetland Soils (Tyrell County, North Carolina). Microbiology resource announcements, 9(41), pp.e00882-20. *[PDF](https://journals.asm.org/doi/full/10.1128/MRA.00882-20)*  

Metagenome sequence files can be found at NCBI SRA [BioProject ID PRJNA641216](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA641216).

## We address the following questions

* **Aim:** To what extent do hydrologic status and plant presence influence microbial biodiversity and ecosystem functions related to biogenic greenhouse gas emissions?

### Repo Contents

* **analyses:** R Markdown files that include R script written by Regina Bledsoe, Colin Finlay, Ariane Peralta, and Mario Muscarella containing functions used in analysis of GHG, soil, and microbial sequence data:
 	1. metaG_CN.Rmd: code for analysis of metagenomic data, **for manuscript in review**
 	2. metaG_in_depth.Rmd: in-progress metagenomic analysis, **not a part of manuscript in review**
 	3. SoilPhys_GHGs_16S.Rmd: 16S, edaphic, and greenhouse gas analysis, **for manuscript in review**
  	4. GHG_LME.Rmd: linear-mixed effects models of greenhouse gases, **for manuscript in review**
  	5. WRC_GHG_Regression_T1_Flux.Rmd: regression of timepoint 1 (T1) vs. flux from a different experiment, to justify use of T1 in current experiment, **for manuscript in review**
  	6. /Previous_Versions: collection of previous .Rmd versions, **not a part of manuscript in review**

* **bin:** 
	* *MothurTools.R*: An R script written by Mario Muscarella (Indiana University, now at University of Alaska Fairbanks) containing functions used in the analysis of community sequence data.

* **data:** Files associated with GHG, soil, and microbial data sets. 

* **figures:** Figures (of GHG, soil, microbes-16S rRNA amplicon, microbes-shotgun metagenomes) generated according to R script located in R Markdown file.

* **supplemental:** Additional sequencing methods information and tables of metagenomic sequence data

## Funding Sources
This work was supported by East Carolina University and an NSF GRFP to R. Bledsoe, NSF DEB 1845845 to A.L.P. The metagenomes were produced by the DOE JGI under the Community Science Program (CSP) (JGI CSP grant 503952). The work conducted by the DOE JGI, a DOE Office of Science User Facility, is supported under contract DE-AC02-05CH11231.

## Contributors

[Dr. Regina Bledsoe](mailto:ginabbledsoe@gmail.com) [(website)](https://ginabbledsoe.wixsite.com/microbes): Principal Investigator, Former PhD Student in the [Peralta Lab](http://www.peraltalab.com) at East Carolina University

[Colin Finlay](mailto:finlayc21@students.ecu.edu): PhD Student in the [Peralta Lab](http://www.peraltalab.com) at East Carolina University

[Dr. Mario Muscarella](mario.e.muscarella@gmail.com) [(website)](http://mmuscarella.github.io/): Assistant Professor, University of Alaska Fairbanks

[Dr. Ariane Peralta](mailto:peraltaa@ecu.edu) [(website)](http://www.peraltalab.com): Associate Professor, Department of Biology, East Carolina University
