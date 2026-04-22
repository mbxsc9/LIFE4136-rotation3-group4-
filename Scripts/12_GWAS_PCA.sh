#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=50g
#SBATCH --time=1:00:00
#SBATCH --job-name=plink_gwas_PCA
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk

# Activating conda environment
source $HOME/.bash_profile
conda activate rotation3

#loading the plink module
module load plink-uoneasy/2.00a3.7-foss-2023a

# Define input
INPUT=XXX/plink_data
TXT=XXX/plink_data/gwas_plink
OUTPUT=XXX/plink_data/LD_pruning

# Run GWAS using plink's linear model.
# LD pruning to remove SNPs that are highly correlated with each other. left with independent markers suitable for population structure analysis.
# PCA on pruned SNPs. calculate 20 PCs. 
plink --bfile "$INPUT"/doggies_raw \
 --allow-extra-chr --allow-no-sex --pheno "$TXT"/pheno_doggies_height.txt \
 --covar "$OUTPUT"/pca20.eigenvec \
 --covar-number 1-3 \
 --linear --out "$OUTPUT"/gwas_doggies_height_pca3
