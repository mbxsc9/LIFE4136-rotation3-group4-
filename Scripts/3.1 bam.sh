#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=makebam
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --mem=100g
#SBATCH --time=18:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --output=XXX/slurm-%x-%j.out
#SBATCH --error=XXX/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --array=0-114   # Adjust based on number of lines in root_names.txt; first sample is "0"!

# load Conda Environment
source $HOME/.bash_profile
conda activate rotation3 

# Script to align sequences to canis_lupus_familiaris genome, outputting a bam file
# Script removes duplicates
# Load software and modules
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
module load picard-uoneasy/3.0.0-Java-17

#set the file path
INFILES=XXX/fastqs
OUTDIR=XXX/bam
# Creating the output directory
mkdir -p $OUTDIR

# Set the pathway to the reference genome.
REF=XXX/reference_gene/Canis_lupus_familiaris.ROS_Cfam_1.0.dna.toplevel.fa
# Need to index genome, once only
bwa index "$REF"

# Load sample names into an array
mapfile -t ROOTS < ../doggies_names.txt

# Get the current sample name based on SLURM_ARRAY_TASK_ID
SAMPLE=${ROOTS[$SLURM_ARRAY_TASK_ID]}
# Set file paths
# Fastp trimmed reads
FILE1="$INFILES/${SAMPLE}_1.fastq.gz"
FILE2="$INFILES/${SAMPLE}_2.fastq.gz"
OUTFILE="$OUTDIR/${SAMPLE}.sort.bam"

# Align reads using combination of bwa mem and samtools
# Use help options to understand syntax
echo "Aligning ${SAMPLE} with bwa"
bwa mem -M -t 8 "$REF" "$FILE1" \
        "$FILE2" | samtools view -b | \
        samtools sort -T "$OUTDIR/${SAMPLE}" -o "$OUTFILE"

# Use picard to remove "duplicates" - a duplicate read is a sequence that is exactly the same in both the forward and reverse directions
# A duplicate read in Illumina (or other short-read sequencing) refers to a read that is an exact copy of another read in the dataset, typically originating from the same original DNA fragment. 
# These duplicates are usually PCR duplicates, created during the amplification step in library preparation rather than representing independent molecules from the sample.
# Duplicates inflate read counts, making coverage appear higher than it truly is.
# Multiple identical reads from the same fragment can make a variant look more supported than it is.
java -Xmx1g -jar $EBROOTPICARD/picard.jar \
MarkDuplicates REMOVE_DUPLICATES=true \
ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT \
MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
INPUT="$OUTFILE" \
OUTPUT="$OUTDIR/${SAMPLE}.rmd.bam" \
METRICS_FILE="$OUTDIR/${SAMPLE}.rmd.bam.metrics"
samtools index "$OUTDIR/${SAMPLE}.rmd.bam"
rm "$OUTFILE"
