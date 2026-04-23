#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=50g
#SBATCH --time=1:00:00
#SBATCH --job-name=plink_gwas
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk

# Activate conda environment
source $HOME/.bash_profile
conda activate rotation3

#loading the plink module
module load plink-uoneasy/2.00a3.7-foss-2023a

# Define input
# INPUT1=XXX/plink_data/plink_QC_Genotype
INPUT=XXX/plink_data
OUTPUT=XXX/plink_data/LD_pruning


# plink checks for 
# Pair of SNPs with a correlation coefficient of more than 0.2 are removed. 
# use "$INPUT1"/doggies_qc for better analysis.
plink --bfile "$INPUT"/doggies_raw \
 --allow-extra-chr --indep-pairwise 50 5 0.2 \
 --out "$OUTPUT"/prune

# use "$INPUT1"/doggies_qc for better analysis.
# Plink calculates the first 20 PCs using only the purned SNPs.
plink --bfile "$INPUT"/doggies_raw \
 --allow-extra-chr --extract "$OUTPUT"/prune.prune.in \
 --pca 20 --out "$OUTPUT"/pca20 # calculate 20 PCs

 conda deactivate 
