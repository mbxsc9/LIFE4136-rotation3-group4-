#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20g
#SBATCH --time=24:00:00
#SBATCH --job-name=VCF_FILTER
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk

# load Conda Environment
source $HOME/.bash_profile
conda activate rotation3

#Loads required modules
module load bcftools-uoneasy/1.18-GCC-13.2.0
module load vcftools-uoneasy/0.1.16-GCC-12.3.0

#Input and output file paths
VCF_IN=XXX/vcf/dog.vcf.gz
OUTDIR=XXX/vcf_filtered

#Creates/checks output directory
mkdir -p "$OUTDIR"

#Retains filtered VCF data and retains a sepearate bialleic only SNPs file
VCF_OUT="$OUTDIR"/doggies_filtered.vcf.gz
VCFB="$OUTDIR"/doggies_filtered_biallelic.vcf.gz

#Set filters
#Minor allele frequency
MAF=0.05
#Missing data filter calls 70%
MISS=0.70
#Quality filter
QUAL=30
# Defining a mininmum and maximum read-depth threshold. 
MIN_DEPTH=1
MAX_DEPTH=50

#Use vcftools to filter data
vcftools --gzvcf $VCF_IN \
  --remove-indels \
  --maf $MAF \
  --max-missing $MISS \
  --minQ $QUAL \
  --min-meanDP $MIN_DEPTH \
  --max-meanDP $MAX_DEPTH \
  --minDP $MIN_DEPTH \
  --maxDP $MAX_DEPTH \
  --recode --stdout | bgzip -c > $VCF_OUT

#Indexs the filtered SNPs
bcftools index $VCF_OUT

#Keeps biallelic SNPs, gets rid of indels, writes file to compressed vcf
bcftools view -Oz --max-alleles 2 --exclude-types indels -o $VCFB $VCF_OUT

#Indexs the biallelic SNPs
bcftools index $VCFB

#Counts the number of SNPs in the output
bcftools view -H $VCFB | wc -l > $VCFB.SNPS.txt

conda deactivate
