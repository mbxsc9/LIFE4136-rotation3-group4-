#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=fastp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=50g
#SBATCH --time=4:00:00
#SBATCH --mail-user=mbxsc9@nottingham.ac.uk
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation3/group4/Scripts/Logs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation3/group4/Scripts/Logs/slurm-%x-%j.err
#SBATCH --array=0-114   # Adjust based on number of lines in root_names.txt; first sample is "0"!

# 1 Gb .fq.gz unzips to approximately 4 Gb, fastp needs memory for both R1 and R2
# 1 pair ran in ~3 minutes using these settings, certainly possible to speed it up
# Load fastp
module load fastp-uoneasy/0.23.4-GCC-12.3.0

# Load sample names into an array
mapfile -t ROOTS </share/BioinfMSc/life4136_2526/rotation3/group4/names.txt

# Get the current sample name based on SLURM_ARRAY_TASK_ID
SAMPLE=${ROOTS[$SLURM_ARRAY_TASK_ID]}

# Define input files
FILE1=/share/BioinfMSc/Hannah_resources/doggies/fastqs/${SAMPLE}_1.fastq.gz
FILE2=/share/BioinfMSc/Hannah_resources/doggies/fastqs/${SAMPLE}_2.fastq.gz

# Output directory
OUTDIR=/share/BioinfMSc/life4136_2526/rotation3/group4/fastq_trimmed
mkdir -p "$OUTDIR"

# Run fastp: Outputs trimmed sequences and an HTML report
fastp \
  --in1 "$FILE1" \
  --in2 "$FILE2" \
  --out1 "$OUTDIR/${SAMPLE}_R1.trimmed.fq.gz" \
  --out2 "$OUTDIR/${SAMPLE}_R2.trimmed.fq.gz" \
  -l 50 \
  -h "$OUTDIR/${SAMPLE}.html" \
  &> "$OUTDIR/${SAMPLE}.log"

echo "Finished fastp for $SAMPLE"




