#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=fastp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=50g
#SBATCH --time=4:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --output=XXX/slurm-%x-%j.out 
#SBATCH --error=XXX/Logs/slurm-%x-%j.err
#SBATCH --array=0-114   # Adjust based on number of lines in doggies_names.txt; first sample is "0"!

# 1 Gb .fq.gz unzips to approximately 4 Gb, fastp needs memory for both R1 and R2
# 1 pair ran in ~3 minutes using these settings, certainly possible to speed it up
# Load fastp
module load fastp-uoneasy/0.23.4-GCC-12.3.0

# Load sample names into an array
mapfile -t ROOTS <XXX/doggies_names.txt

# Get the current sample name based on SLURM_ARRAY_TASK_ID
SAMPLE=${ROOTS[$SLURM_ARRAY_TASK_ID]}

# Define input files 
# replace XXX with the pathway to the doggies fastq files 
FILE1=XXX/${SAMPLE}_1.fastq.gz
FILE2=XXX/${SAMPLE}_2.fastq.gz

# Output directory
OUTDIR=XXX/fastq_trimmed
# Create output directory. 
mkdir -p "$OUTDIR"

# Run fastp: Outputs trimmed sequences and an HTML report
fastp \
  --in1 "$FILE1" \ # imports reads 1 
  --in2 "$FILE2" \ # imports reads 2
  --out1 "$OUTDIR/${SAMPLE}_R1.trimmed.fq.gz" \
  --out2 "$OUTDIR/${SAMPLE}_R2.trimmed.fq.gz" \ # Trimmed Outputs
  -l 50 \
  -h "$OUTDIR/${SAMPLE}.html" \ # Fastqc reports 
  &> "$OUTDIR/${SAMPLE}.log"

echo "Finished fastp for $SAMPLE"




