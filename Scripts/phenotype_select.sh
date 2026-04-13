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

INPUT=/share/BioinfMSc/life4136_2526/rotation3/group4/plink_data
OUTDIR=/share/BioinfMSc/life4136_2526/rotation3/group4/plink_data/gwas_plink

#awk -F',' BEGIN { OFS ="\t" } 'NR>1 {print $1, $4, $9}' "$INPUT"/mergeddata.csv > "$OUTDIR"/pheno_nplates.txt
