#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=makebam
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --mem=100g
#SBATCH --time=18:00:00
#SBATCH --mail-user=mbxsc9@nottingham.ac.uk
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation2/group4/Scripts/Logs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation2/group4/Scripts/Logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --array=0-114   # Adjust based on number of lines in root_names.txt; first sample is "0"!

# Load software
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
module load picard-uoneasy/3.0.0-Java-17

##set the file path
INFILES=/share/BioinfMSc/Hannah_resources/doggies/fastqs
OUTDIR=/share/BioinfMSc/life4136_2526/rotation3/group4/bam
SAMPLE_LIST=/share/BioinfMSc/life4136_2526/rotation3/group4
REF=/share/BioinfMSc/life4136_2526/rotation3/group4/reference_gene/Canis_lupus_familiaris.ROS_Cfam_1.0.dna.toplevel.fa
mkdir -p "$OUTDIR"

# Load sample names into an array
mapfile -t ROOTS < "$SAMPLE_LIST/names.txt"

SAMPLE=${ROOTS[$SLURM_ARRAY_TASK_ID]}
# Set file paths
# Fastp trimmed reads
FILE1="$INFILES/${SAMPLE}_1.fastq.gz"
FILE2="$INFILES/${SAMPLE}_2.fastq.gz"
OUTFILE="$OUTDIR/${SAMPLE}.sort.bam"

echo "Aligning ${SAMPLE} with bwa"
bwa mem -M -t 8 "$REF" "$FILE1" \
        "$FILE2" | samtools view -b | \
        samtools sort -T "$OUTDIR/${SAMPLE}" -o "$OUTFILE"

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
