#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=2:00:00
#SBATCH --job-name=imputation
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL

# Activate the conda environment
source $HOME/.bash_profile
conda activate Rotation3

Define Input
Filtered_vcf=XXX/doggies_filtered.vcf.gz
beagle.jar=XXX/beagle.29Oct24.c8e.jar
OUTDIR=XXX/vcf_filtered/vcf_imputation

# Create new out directory
mkdir -p "$OUTDIR"

# Running Beagle
java -Xmx30g -jar "$beagle.jar" \
gt="$Filtered_vcf" \
out="$OUTDIR"/doggies_snps_imputed.vcf.gz

conda deactivate
