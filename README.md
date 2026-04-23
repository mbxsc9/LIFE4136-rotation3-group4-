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
begin
```



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

