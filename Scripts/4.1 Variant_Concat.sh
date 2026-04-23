#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=16
#SBATCH --mem=32g
#SBATCH --time=2:00:00
#SBATCH --job-name=variant_concat
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL

# Load Conda Environment
source $HOME/.bash_profile
conda activate rotation3

# Load Software
module load bcftools-uoneasy/1.18-GCC-13.2.0

# Concatenate all vcf files into a single vcf file
bcftools concat --file-list ../vcf.list.txt -Oz --output ../vcf/dog.vcf.gz --threads 32
bcftools index ../vcf/dog.vcf.gz --threads 32 # Index the merged VCF file

conda deactivate
