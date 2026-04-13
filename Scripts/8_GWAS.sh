#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=50g
#SBATCH --time=1:00:00
#SBATCH --job-name=plink_gwas
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation3/group4/Scripts/Logs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation3/group4/Scripts/Logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxsc9@nottingham.ac.uk

source $HOME/.bash_profile
conda activate rotation3

#loading the plink module
module load plink-uoneasy/2.00a3.7-foss-2023a

INPUT=/share/BioinfMSc/life4136_2526/rotation3/group4/plink_data
TXT=/share/BioinfMSc/life4136_2526/rotation3/group4/plink_data/gwas_plink
OUTPUT=/share/BioinfMSc/life4136_2526/rotation3/group4/plink_data/LD_pruning


plink --bfile "$INPUT"/doggies_raw \
 --allow-extra-chr --allow-no-sex --pheno "$TXT"/pheno_doggies_height.txt \
 --covar "$OUTPUT"/pca20.eigenvec \
 --covar-number 1-3 \
 --linear --out "$OUTPUT"/gwas_doggies_height_pca3
