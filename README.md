# LIFE4136 Rotation 3 Group 4
- This is a repository that includes the workflow used for Genome-wide association studies analysis as a part of the UoN MSc Bioinformatics - LIFE4136 module.

# Contents
- [Introduction](#introduction)
- [Objective of our study](#objective-of-our-study)
- [Prerequisites and Dependencies](#prerequisites-and-dependencies)
  - [Download the reference file](#download-the-reference-file)
  - [Tools Installation](#tools-installation)
- [Cloning Repository](#cloning-repository)
  - [Creating Conda Environment](#creating-conda-environment)
  - [R-Studio](#r-Studio)
  - [Requirement.txt](#requirement.txt)
- [Workflow Overview](#workflow-overview)
- [Troubleshooting](#troubleshooting)
- [Authors](#authors)

## Introduction
- Genome-wide association studies (GWAS) are observational studies that analyze entire genomes within large populations to identify genetic variations, particularly single nucleotide polymorphisms (SNPs), associated with specific traits or diseases. GWAS compare DNA from individuals with certain traits to a reference genome, revealing genetic risk factors that inform biological insights and precision therapy. The high-throughput technology Plink is used for scanning numerous SNPs, with significant SNPs appearing as peaks in a Manhattan plot above a critical threshold.

##  Objective of our study:
- This pipeline will allow running Genome-Wide Association analyses on Genomics Data (Canis_lupus_familiaris). This workflow can identify and pinpoint genetic variation linked with the height trait. The objective of our study is to develop a comprehensive bioinformatic pipeline that utilises short-read (Illumina) sequencing data to assemble and analyse dog genome data and identify genomic regions that influence these traits and looks for SNPs. We have developed an automated GWAS pipeline by combining multiple analysis tools, including bcftools, vcftools, Plink, samtools and further analysis using the R packages to create a Manhattan plot. The pipeline is flexible and has a reproducible workflow. 


## Prerequisites and Dependencies
Files and data required:

Short Reads: Illumia Data
- Paired end data
- ```*_1.fastq.gz```
- ```*_2.fastq.gz```

Total data
- Total ```230 fastq.gz``` files.
- 115 individuals were evaluated using GWAS.

## Download the reference file
- ```.fasta```, ```gff``` for mapping and annotations. you can download the reference file in the website [NCBI Datasets](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_011100685.1/).
- ```GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna```
- ```GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.gff.g```

VCF Imputation
- Download beagle to imputate the vcf [here](https://faculty.washington.edu/browning/beagle/b5_4.html#download). 
-	Beagle 5.4 program file: version ``` beagle.29Oct24.c8e.jar```

## Tools Installation

Tool versions and links

This list outlines the necessary tools and their versions for the workflow, along with the links to their github.

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

## Cloning Repository
Clone this github repository in your working directory using this command
```
git clone https://github.com/mbxsc9/LIFE4136-rotation3-group4-.git
```

## Creating Conda Environment
To create a new conda environment necessary for the project, use this command.
```
conda create python=3.8 -n rotation3
conda activate rotation3
```
Install the listed tools into the environment for use.
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
Command to deactivate the conda environment. 
```
conda deactivate
```
To check for the list of available conda environments, use this command.
```
conda env list
```
Create a ```.yml``` file to export and share the conda environment
```
conda env create -f rotation3.yml
conda env ecport > rotation3.yml
```
# Configure channels - only needed once
```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```
Modules 
- These modules are loadable when the specific tool is absent in the conda environment.
```
module load fastp-uoneasy/0.23.4-GCC-12.3.0
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
module load picard-uoneasy/3.0.0-Java-17
module load bcftools-uoneasy/1.18-GCC-13.2.0
module load vcftools-uoneasy/0.1.16-GCC-12.3.0
```

list modules available in HPC
```
module avail
```

## R-Studio 
Commands to install the required packages
```
install.packages("qqman")
install.packages("tidyverse")
```

Further analysis tools
| Tools | Versions | Link |
|---|---|---|
| qqman | 0.1.9 | [qqman](https://github.com/stephenturner/qqman) |
| tidyverse | 2.0.0 | [tidyverse](https://github.com/tidyverse) |

Statistical packages for visualisation and analysis.
```
library(qqman)
library(tidyverse)
```
## Requirement.txt
- ```bam_list.txt```
- ```chr.names.txt```
- ```mergeddata.csv```
- ```names.txt```
- ```pheno_doggies_height.txt```
- ```beagle.29Oct24.c8e.jar```

Merged data includes information on doggies phenotypes.
- The doggie phenotypes infomations is avaiable in this [GITHUB](https://github.com/tmfilho/akcdata/tree/master) link. 

## Workflow Overview
This pipeline includes multiple steps: Data preparation and quality control.

1. Quality Control
- To check the quality of the dogs' reads and generate a comprehensive HTML report summarising raw sequence data quality, GC content, adapter contamination and plots for per-base quality.
- Script: ```1.0 FASTQC.sh```
- Input: ```*_1.fastq.gz```, ```*_2.fastq.gz``` (Within the shared directory)
- Output: ```*.html``` and ```*.zip``` files.

2. Trimming
- The reads were trimmed using fastp, which automatically detects adapter sequences from paired-end Illumina data and removes them. Also, it generates an HTML report showing raw sequence data quality before and after trimming.
- Script: ```2.0 Fastq_trimmed.sh```
- Input: ```*_1.fastq.gz```, ```*_2.fastq.gz```
- Output: ```*_R1.trimmed.fq.gz```, ```*_R2.trimmed.fq.gz``` and ```*.html``` report.

3. MultiQC
- The MultiQC tool is used to create a single report visualising the quality of the reads across multiple samples, enabling the identification of any contaminated reads.
- Script: ```2.1 multi_qc.sh```
- Input:```*_R1.trimmed.fq.gz```, ```*_R2.trimmed.fq.gz```
- Output: ```*.log```, ```*.txt``` of heatmap, content_plot and other. ```multiqc_report.html```.

4. Indexing the reference genome using BWA
- BWA aligns millions of short sequencing reads to a large FASTA format reference sequence. This allows downstream analysis. 
- Script: ```3.0 Index_reference_gene.sh```
- Input: ```Canis_lupus_familiaris.ROS_Cfam_1.0.dna.toplevel.fa```
- Output: ```*.amb```, ```*.ann```, ```*.bwt```, ```*.pac```, and ```*.sa```.

5. Creating bam files using the trimmed.fastq and indexed reference files.
- Samtools converts raw sequencing-trimmed reads (FASTQ) into reference-aligned, sorted files for further analysis. Also, used samtools to remove unmapped and low-confidence alignments.
- Script: ```3.1 bam.sh```
- Input: ```*_R1.trimmed.fq.gz```, ```*_R2.trimmed.fq.gz```
- Output: ```*.bam```, ```*.sorted.bam```, ```*.sorted.bam.bai```
- Script: ```3.2 bam_filter.sh```
- Input: ```${SAMPLE}.sort.bam```
- Output: ```${SAMPLE}.filtered.bam``` 

6. VCF mpileup and calling
- To identify SNPs, indels and variant calls files using bcftools. Also, concatenate all the VCFs into one file.
- Script: ```4.0 VCF_mpileup_calling.sh```, 
- Input: ```${SAMPLE}.filtered.bam```
- Output: ```${SAMPLE}.vcf.gz ```
- Script: ```4.1 Variant_concat.sh```
- Input: ```${SAMPLE}.vcf.gz ```
- Output: ```dog.vcf.gz```


7. VCF filter and Imputation
- VCF filtering removes low-quality reads within ```.min_depth=1 and max_depth=50``` and ```.qual=30```. VCF imputation substitutes missing genotypes by comparing with the reference genome. 
- Script: ```4.2 VCF_filter.sh```
- Input: ```dog.vcf.gz```
- Output: ```doggies_filtered.vcf.gz```
- Script: ```4.3 vcf_imputation.sh```
- Input: ```doggies_filtered.vcf.gz``` and ```beagle.29Oct24.c8e.jar```
- Output: ```doggies_snps_imputed.vcf.gz```

8. Clean and index the imputed vcf
- Using bcftools to only get biallelic SNPs and only keeps SNPs that are variants.
- Script: ```5.0 Clean_index_vcf```
- Input: ```doggies_snps_imputed.vcf.gz``` | Output:```doggies_snps.imputed.vcf.gz```
- Index Input: ```doggies_snps.vcf.gz``` | Index Output: ```doggies_snps.vcf.gz.csi```.

9. Creating a phenotype ```.txt``` file.
- Plink cannot read ```.csv``` files. The ```.txt``` need to match with the ```.fam``` created by the plink. In this analysis, sample_accession is used to identify the sample genome.
- Script: ```5.1 phenotype_select.sh``` 
- Input: ```mergeddata.csv```
- Outp-ut: ```doggies_height.txt```

10. Using plink for filtering low quality SNPs.
- QC filtering to remove low-quality SNPs and individuals, which can distort the final analysis. This outputs missing genotype datasets with poorly genotyped SNPs and rare variants.
- Script: ```6.0 QC_genotype.sh```
- Input: ```doggies_snps.imputed.vcf.gz```
- Output: ```doggies_missing``` and doggies_raw ```.bed```, ```.bim```, ```.fam```.
- Script: ```6.1 qc_missingness.sh ```
- Input:```doggies_raw``` | ```.bed```, ```.bim```, ```.fam```.
- Output: ```doggies_qc```

11. GWAS PLINK
- Using Plink to run a linear regression results in a quantitative height trait.
- Scripts: ```7.0 gwas_plink```
- Input: ```doggies_raw``` and ```pheno_doggies_height.txt```
- Output: ```gwas_height_doggies.assoc.linear```, ```.nosex```, ```.log```

12. Pruning
- We first LD-prune SNPs and do PCA on the independent markers to capture ancestry variation and remove false positives. Then, PCA summarises gnome-wide genetic variation into principal components (PCs).
- Scripts: ```8.0 pruning.sh```
- Input: ```doggies_raw```
- Output: prune ```.prune.in```, ```.log```, ```.prune.out```, ```.nosex```
- Pca20
- Input: prune ```.prune.in```, ```.prune.out```, ```doggies_raw```
- Output: pca20 ```..eigenval```, ```.eigenvec```, ```.log```

13. GWAS_PCA
- Genome-wide association studies (GWAS) reruns utilise a linear model that incorporates principal components (PCs) as covariates.
- Scripts: ```9.0 GWAS_PCA.sh```
- Input: ```pheno_doggies_height.txt ```, ```pca20.eigenvec```, ```doggies_qc``` | ```doggies_raw```
- Output: ```gwas_doggies_height_pca3.assoc.linear```, ```.nosex```, ```.log```

GWAS using R-studio:
- A Manhattan map highlighting certain SNP peaks on various chromosomes is produced using R-Studio. 
- Script: ```9.2 manhattanplots.R```
- Input: ```gwas_doggies_height_pca3.assoc.linear```
- Output ```manhattan plot```

  
## Troubleshooting
1. If the pipeline fails, check the following:
- plink.log for general errors.
- Common issues:
  - Input file format errors (VCF/PLINK) --> validate input files and pathways (XXX).
  - Missing reference FASTA file --> download using the provided website link.
  - Insufficient resources (memory/CPU) --> adjust resource parameters in the profile configs.
 
2. If the pipeline ran successfully but results look off:
- Check the number of jobs in each process.
- Define input file pathway correctly.
- Check sample QC in ../Multiqc/ to ensure expected sample counts after QC.

3. Check if all the conda environments are installed and updated.

4. Check if all the requirement.txt files are available.
- create a ```pheo_doggies_height.txt``` form.
- Must be a space- or tab-separated text file that contains the sample information.
- ```.txt``` needs to match the ```doogies.fam``` information. This study used, ```sample_accession``` however, ```run_accession``` or ```gene_id``` can be used depending on ```.fam``` output.

```
| SAMN03801644 | SAMN03801644	| 35.56 |
| SAMEA2376414 | SAMEA2376414 |	35.56 |
```

5. For better GWAS analysis, [plink2](https://github.com/chrchang/plink-ng) can be installed in the conda environment.

```
conda install bioconda::plink2
```
6. Make sure the individuals number matches the ```doggies_names.txt``` or other ```.txt``` which allows to  ```#SBATCH --array=0-114```
```
# Load sample names into an array
mapfile -t ROOTS < ../doggies_names.txt

# Get the current sample name based on SLURM_ARRAY_TASK_ID
SAMPLE=${ROOTS[$SLURM_ARRAY_TASK_ID]}
```
7. For the PCA GWAS script ```9.0 GWAS_PCA.sh```, we used the ```doggies_raw``` files insteads of the ```doggies_qc``` files beacause the QC step removed important SNPs and individuals that were needed for the analysis.
- Use ```doggies_qc``` for better analysis.

## Authors

- Smriti Chaudhary - mbxsc9@nottingham.ac.uk
- Layla Meghjee - mbxlm9@nottingham.ac.uk
- Jiaan Randhawa-Heer - mbxjr7@nottingham.ac.uk



