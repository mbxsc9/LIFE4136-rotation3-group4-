#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12g
#SBATCH --time=12:00:00
#SBATCH --job-name=FAST_QC
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk

# Importing Conda Environment
source $HOME/.bash_profile
conda activate rotation3

## Define the input and the output
INPUT=../../Hannah_resources/doggies/fastqs
OUTDIR=XXX/QC

# Creating a new output directory
mkdir -p "$OUTDIR"

# Running Long Read QC Analysis
fastqc \
 -t 8 \
 -o "$OUTDIR" \
 "$INPUT"/*.fastq.gz


# Deactivate Conda
conda deactivate
