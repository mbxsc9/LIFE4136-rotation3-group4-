LIFE4136 Rotation 3 Group 4

Project Overiew
[Tool installation](#tool-installation)

# The GWAS pipeline
This pipeline will allow to run Genome Wide Association analyses on Genomics Data. Binary phenotypes, you can run this workflow to identify variants that are enriched for the phenotype. 

# Introduction
To identify SNPs or traits, this pipeline works with plink.

Given the phenotype file and some additional arguments as input, the pipeline performs several steps of appropriate sire Quality control (QC) on high-coverage whole genome data and then runs mixed model association analyss. 

Create a phenofiles.txt from the .csv files
The phenofile is the required input for the GWAS pipeline.
This is a space- or tab-separated text file that contain the sample information. The file must have a header as this will be used as this will be used to specifiy the coluns to use in your command. 

```
begin using the .csv chose the sample_accession. 
```  
The pheno_doggies_height.txt created from the mearged.csv file. This reads sample_accession in first and second columns and three columns has the phenotype information of mean height which ranges from 35.56 to 76.2. 
- Sample ID column: The pipeline will read the sample ID from the column specified with option --sampleIDcol. If you're running the pipeline on Genomics England data, the sample ID should be the platekey ID because this is what is specified in the aggregate genomic data. For other data, you can use whatever ID is appropriate for that data
- Sex specification column: The pipeline will read the sex info from the column specified with option --sexCol. Males must be specified as 0 and females as 1.
- Phenotype specification column: The pipeline will read the phenotype from the column specified with option --phenoCol (see below)
```
| SAMN03801644 | SAMN03801644	| 35.56 |
| SAMEA2376414 | SAMEA2376414 |	35.56 |
```
# degging
look the doggies.fam and see the format. 
if the .fam has breed or run_accession and their id. It need to replace so, plink can read the data. 

# Create a lsit of genomic files to run the GWAS on
The pipeline requires a list of genomic files, thses can be VCF.
List requirement:
- The list must containt comma-spearated file location.
- The file must exit and not be empty.
- Specify chromosome

# Plink 
This option will designate the plink files identify high qaulity independent SNPs. To simplify the process the flag will set a prefix for the files and expand these to cover the suffixes needed. 
This fileset will be used to construct the GRM and fit the nul model when running the mixed model association analysis.

The suffix pattern will be:
.{bed,bim,fam}
This corresponds to the triplet of files that are used by plink.

# Files and data required:
- Short Reads: Illumia Data
- Paired end data
- *_1.fastq.gz
- *_2.fastq.gz
- Total 115 different unknown dog breeds.
- Total 230 fastq.gz files.
- Phenetopic data were collected from 115 unknown dog breeds.
- 115 individuals were evaluated using GWAS.
- 

Introdution 
A Genome-wide associationstudy (GWAS) is conducted to identify the geneomic regions and nearby candidate genes influencing these traits. 

Genome-wide association studies (GWAS) are observation studies that analysis the entire genome of large population to identify genetic variants, typically single nucleotide polymorphism (SNPs), assocuated with specific traits or disease. By comparing DNA from individuals with a disease (cases) to those without controls (Refernce genome), GWAS identify genetic risk factors, providing insights into disease biology and informing precision medicine.
Plink 
Using the high-throughput technology to scan hundards of thousands to million of SNPs simultaneously across the genome. 

Results is visualised in Manhattan Plot, where significant SNPs appear as high points. (above a signficant thresholds). 

# Objective of our study:
To pinpoint genetic variation linked to complex disease and trait (height).
The objective of our study is to develop a comprehensive bioinformatic pipeline that utilise short-reads (Illumina) sequencing data to assemble and analysing dog geneome data. 
look for SNPs.




Tool versions and links
The following table list these tools along with their versions and links to their offical documentation or home pages
## Tool installation
| Tool Name  |  Version | Link  |
|---|---|---|
| MultiQC | 1.24 | [MultiQC](https://github.com/MultiQC/MultiQC) |
| fastp | 0.23.4 | [fastp](https://github.com/opengene/fastp) |
| Samtools | 1.18 | [Samtools](https://github.com/samtools/samtools) |
| BWA | 0.7.17 | [BWAS](https://github.com/lh3/bwa) |
| Picard | 3.0.0 | [Picard](https:/github.com/broadinstitute/picard)|
| bcftools | 1.18 | [bcftools](https://github.com/samtools/bcftools) |
| VCFtools | 0.1.16 | [VCFtools](https://github.com/vcftools/vcftools) |
| PLINK | 1.90 | [PLINK](https://github.com/chrchang/plink-ng) |

# 1. Configure channels (only needed once)
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

Tools installation
Need to create a new conda environment and activate using the following command
```
conda create python=3.8 -n rotation3
conda activate rotation3
```
Install required tools using commands
```
conda install bioconda::multiqc
conda install bioconda::fastp
conda install bioconda::samtools
conda install bioconda::bwa
conda install bioconda::picard
conda install bioconda::bcftools
conda install bioconda::vcftools
conda install bioconda::plink
```
```
conda deactivate
```
```
conda env list
```
create a yml file share conda environment
```
conda env create -f rotation3.yml
```


Modules 
```
- module load fastp-uoneasy/0.23.4-GCC-12.3.0
- module load samtools-uoneasy/1.18-GCC-12.3.0
- module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
- module load picard-uoneasy/3.0.0-Java-17
- module load bcftools-uoneasy/1.18-GCC-13.2.0
- module load vcftools-uoneasy/0.1.16-GCC-12.3.0
```

R-Studio 
```
install.packages("qqman")
install.packages("tidyverse")
```
```
library(qqman)
library(tidyverse)
```


Further analysis tools
| Tools | Versions | Link |
|---|---|---|
| qqman | 0.1.9 | [qqman](https://github.com/stephenturner/qqman) |
| tidyverse | 2.0.0 | [tidyverse](https://github.com/tidyverse) |

Reference 
you can download the reference file [here](https://www.ensembl.org/Canis_lupus_familiaris/Info/Index). 


View the Output
As output, the pipeline produces GWAS summary statistics, manhattan and qqplot figures.








Data Overiew:
Data given by the teacher
Dogs genomic data

Conda environment

Module list

Requirement.txt

Project Overview

Backgrow

install plink 2 if it does n't won
```
conda install bioconda::plink2
```

