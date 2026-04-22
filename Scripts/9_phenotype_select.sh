#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8g
#SBATCH --time=1:00:00
#SBATCH --job-name=phenotype_txt
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk

# load conda environment
source $HOME/.bash_profile
conda activate rotation3

# Define Input
INPUT=XXX/plink_data
OUTDIR=XXX/plink_data

mkdir -p "$OUTDIR"

# Adapt phenotype file.
# Converting .csv file into .txt as plink cannot read .csv file.
# .txt file with family ID and indivual ID. Matching with the .bam file
awk -F',' BEGIN { OFS ="\t" } 'NR>1 {print $1, $4, $9}' "$INPUT"/mergeddata.csv > "$OUTDIR"/doggies_height.txt

# awk -F',' 'NR>1 {print $1, %1, $10}' armour_data.csv > doggies_height.txt
