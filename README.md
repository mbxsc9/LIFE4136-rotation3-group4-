LIFE4136 Rotatio

Project Overiew
[Tool installation](#tool-installation)


# Introduction
This pipeline will allow to run Genome Wide Association analyses on Genomics Data (Canis_lupus_familiaris). This workflow can identify variants that are enriched in specific phenotype (height). We have developed an automated GWAS pipeline by combining multiple analysis tools including: bcftools, vcftools, Plink, samtools and further analysis using the R packages (manhattan plot). The pipline is flexible and have a reproducible workflow. 

Genome-wide association studies (GWAS) are observation studies that analysis the entire genome of large population to identify genetic variants, typically single nucleotide polymorphism (SNPs), assocuated with specific traits or disease. By comparing DNA from individuals with a disease (cases) to those without controls (Refernce genome), GWAS identify genetic risk factors, providing insights into disease biology and informing precision medicine.

Using plink the high-throughput technology to scan hundards of thousands to million of SNPs simultaneously across the genome. 

Results is visualised in Manhattan Plot, where significant SNPs appear as high points. (above a signficant thresholds). 

#  Objective of our study:
To pinpoint genetic variation linked to complex disease and trait (height).
The objective of our study is to develop a comprehensive bioinformatic pipeline that utilise short-reads (Illumina) sequencing data to assemble and analysing dog geneome data and identify he geneomic regions and nearby candidate genes influencing these traits, look for SNPs.

# Prerequisites and Dependencies
Files and data required:

Short Reads: Illumia Data
- Paired end data
- ```*_1.fastq.gz```
- ```*_2.fastq.gz```

Total data
- Total ```230 fastq.gz``` files.
- 115 individuals were evaluated using GWAS.

Download the reference file
- ```.fasta```, ```gff``` for mapping and annotations. you can download the reference file in the website [NCBI Datasets](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_011100685.1/).
- ```GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna```
- ```GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.gff.g```

VCF Imputation
- Download beagle to imputate the vcf [here](https://faculty.washington.edu/browning/beagle/b5_4.html#download). 
-	Beagle 5.4 program file: version ``` beagle.29Oct24.c8e.jar```

Installation

Tool versions and links

This is a list of all the tools that will be required for this workflow along with their versions. A link has been added to look at their documentation.
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

# Cloning Repository
Clone this github repository in your working directory to use this command

```git clone https://github.com/mbxsc9/LIFE4136-rotation3-group4-.git ```

# Creating an Environment

Need to create a new conda environment using this command, which is required for this project. 
```
conda create python=3.8 -n rotation3
conda activate rotation3
```
Afterwards, install the listed tools into the environment for use.
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
Check for the list of conda environment available using this command.
```
conda env list
```
create a yml file to a share and export the conda environment
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

These modules can be loaded if the specific tool is not installed in the conda enviromnet.
```
- module load fastp-uoneasy/0.23.4-GCC-12.3.0
- module load samtools-uoneasy/1.18-GCC-12.3.0
- module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
- module load picard-uoneasy/3.0.0-Java-17
- module load bcftools-uoneasy/1.18-GCC-13.2.0
- module load vcftools-uoneasy/0.1.16-GCC-12.3.0
```

list modules avaliable in HPC
```
module avail
```

R-Studio 
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

Merged data with doges phenotypes information:
- The doges phenotypic infomations is avaiable in this [GITHUB](https://github.com/tmfilho/akcdata/tree/master) link. 

# Workflow Overview
This pipeline includes multiple steps: Data preparation and quality control.

1. Quality Control
To check the quality of the dogs reads and generates a comprehensive HTML report summarising raw sequence data quality, GC content, adapter contamination and plots for per-base quality.

- Script: ```1.0 FASTQC.sh```
- Input: ```*_1.fastq.gz```, ```*_2.fastq.gz``` (Within the shared directory)
- Output: ```.html``` and ```.zip``` files.

2. Trimming
The reads were trimmed using fastp which automatically detects adapter sequence from paired-end Illumina data and removes it. Also, genetrates a HTML report showing raw sequence data quality before and after trimming.

- Script: ```2.0 Fastq_trimmed.sh```
- Input: ```*_1.fastq.gz```, ```*_2.fastq.gz```
- Output: ```*_R1.trimmed.fq.gz```, ```_R2.trimmed.fq.gz``` and ```.html``` report.

3. MultiQC
MultiQC tool is used to create a single report visualsing the quality of the reads across multiple samples, enable to identify any contaminated reads.

- Script: ```2.1 multi_qc.sh```
- Input:```*_R1.trimmed.fq.gz```, ```_R2.trimmed.fq.gz```
- Output: ```.log```, ```.txt``` of heatmap, content_plot and other. ```multiqc_report.html```.

4. Indexing the reference genome using BWA
BWA aligns millions of short sequencing reads to a large FASTA format reference sequence. This allows downstream analysis. 

- Script: ```3.0 Index_reference_gene.sh```
- Input: ```Canis_lupus_familiaris.ROS_Cfam_1.0.dna.toplevel.fa```
- Output: ```.amb```, ```.ann```, ```.bwt```, ```.pac```, and ```.sa```.

5. Creating bam files using the trimmed.fastq and indexed reference files.
Samtools converts raw sequencing trimmed reads (FASTQ) into a reference-aligned, sorted files for further analysis. Also, used samtools to remove unmmapped and low-confidence alignments. 
- Script: ```3.1 bam.sh```
- Input: ```*_R1.trimmed.fq.gz```, ```_R2.trimmed.fq.gz```
- Output: ```*.bam```, ```*.sorted.bam```, ```.sorted.bam.bai``` 

- Script: ```3.2 bam_filter.sh```
- Input: ```${SAMPLE}.sort.bam```
- Output: ```${SAMPLE}.filtered.bam``` 

6. VCF mpileup and calling
To identify SNPs, indels and variant calls files using bcftools. Also, concat all the vcf into one file.

- Script: ```4.0 VCF_mpileup_calling.sh```, 
- Input: ```${SAMPLE}.filtered.bam```
- Output: ```${SAMPLE}.vcf.gz ```

- Script: ```4.1 Variant_concat.sh```
- Input: ```${SAMPLE}.vcf.gz ```
- Output: ```dog.vcf.gz```


7. VCF filter and Imputation
VCF filtering removes low-quality reads with ```.min_depth=1 and max_depth=50``` or ```.qual=30```. VCF imputation substitutes missing genotypes by comparing with the reference genome. 

- Script: ```4.2 VCF_filter.sh```
- Input: ```dog.vcf.gz```
- Output: ```doggies_filtered.vcf.gz```

- Script: ```4.3 vcf_imputation.sh```
- Input: ```doggies_filtered.vcf.gz``` and ```beagle.29Oct24.c8e.jar```
- Output: ```doggies_snps_imputed.vcf.gz```

8. Clean and index the imputed vcf
Using bcftools to only get biallelic SNPs and only keeps SNPs variant.
- Script: ```5.0 Clean_index_vcf```
- Input: ```doggies_snps_imputed.vcf.gz``` | Output:```doggies_snps.imputed.vcf.gz```
- Index Input: ```doggies_snps.vcf.gz``` | Index Output: ```doggies_snps.vcf.gz.csi```.

9. Creating a phenotype ```.txt``` file.
Plink cannot read ```.csv``` files. The ```.txt``` need to match the ```.fam``` created by the plink. In this analysis, sample_accession is used to identify the sample genome.

- Script: ```5.1 phenotype_select.sh``` 
- Input: ```mergeddata.csv```
- Output: ```doggies_height.txt```

10. Using plink for filtering low quality SNPs.
QC filtering to remove low quality SNPs and individuals which can distort the final analysis. This outputs a missing genotype datasets with pooly genotyped SNPs and rare variant.
- Script: ```6.0 QC_genotype.sh```
- Input: ```doggies_snps.imputed.vcf.gz```
- Output: ```doggies_missing``` and doggies_raw ```.bed```, ```.bim```, ```.fam```.

- Script: ```6.1 qc_missingness.sh ```
- Input:```doggies_raw``` | ```.bed```, ```.bim```, ```.fam```.
- Output: ```doggies_qc```

11. GWAS PLINK
Using plink to run a linear regression, results in quantitative height trait. 
- Scripts: ```7.0 gwas_plink```
- Input: ```doggies_raw``` and ```pheno_doggies_height.txt```
- Output: ```gwas_height_doggies.assoc.linear```, ```.nosex```, ```.log```

12. Pruning
We fist LD-prune SNPs and do PCA on the independent markers to capture ancestry variation and remove false positive. Then, PCA summarises gnome-wide genetic variation into pricipal components (PCs).
- Scripts: ```8.0 pruning.sh```
- Input: ```doggies_raw```
- Output: prune ```.prune.in```, ```.log```, ```.prune.out```, ```.nosex```

- Pca20
- Input: prune ```.prune.in```, ```.prune.out```, ```doggies_raw```
- Output: pca20 ```..eigenval```, ```.eigenvec```, ```.log```

13. GWAS_PCA
GWAS reruns using a linear model with additions of PCs as covariates.
- Scripts: ```9.0 GWAS_PCA.sh```
- Input: ```pheno_doggies_height.txt ```, ```pca20.eigenvec```, ```doggies_qc``` | ```doggies_raw```
- Output: ```gwas_doggies_height_pca3.assoc.linear```, ```.nosex```, ```.log```

GWAS using R-studio:
A manhatton map highlighting certain SNP peaks on various chromosomes is produced using r-studio. 
- Script: 9.2 manhattanplots.R
- Input: ```gwas_doggies_height_pca3.assoc.linear```
- Output ```manhattan plot```

  
# Troubleshooting
1. If the pipeline fails, check the following:
- plink.log for general errors.
- Common issues:
  - Input file format errors (VCF/PLINK) --> validate input files and pathways (XXX).
  - Missing reference FASTA file --> download using the provided website link.
  - Insufficient resources (memory/CPU) --> adjust resource parameters in the profile configs.
  
2. If pipleine ran succssessfully but results look off:
- Check the number of jobs in each process
- Define input file pathway correctly.
- Check sample QC in ../Multiqc/ to ensure expected samples counts after QC.

3. Check if all the conda environment is installed and updated.
   
4. Check if all the requirement.txt files are avaliable.
- create a ```pheo_doggies_height.txt``` from ```meargeddata.csv```.
- Must be space- or tab-separated text file that contain the sample information.
- ```.txt``` needs to match the ```doogies.fam``` information. This study used ```sample_accession``` but ```run_accession``` or ```gene_id``` can be used depending on ```.fam``` output.
```
| SAMN03801644 | SAMN03801644	| 35.56 |
| SAMEA2376414 | SAMEA2376414 |	35.56 |
```

5. For better GWAS analysis [plink2](https://github.com/chrchang/plink-ng) can be installed in the conda environment.
```
conda install bioconda::plink2
```

