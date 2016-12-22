#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH --ntasks-per-node=3
#SBATCH -t 2:00:00
#SBATCH -J pseq_in
#SBATCH -A ddp267
#SBATCH --export=ALL

# Benchmarking and scaling study note:
# Number of threads is controlled by the pandaseq -T option and is set
# equal to the value assigned to ntasks-per-node

# Define paths to data directory, scratch directory, executable and results file
DPATH=/oasis/scratch/comet/sinkovit/temp_project/HVP/Vanderbilt_data
SSDPATH=/scratch/$USER/$SLURM_JOB_ID 
EXE=/home/sinkovit/PANDASEQ/bin/pandaseq
RESULT=pseq_ssdin.$SLURM_JOB_ID.$SLURM_NTASKS_PER_NODE

# Initialize the content of the timing results file
echo -n '' > $RESULT

# Workflow
# (1) Copy input from oasis to SSD
# (2) Execute pandaseq: read from SSD, write to SSD

# Copy the files to the SSD and record time
echo -n "copy data to SSD time (s): " >> $RESULT
/usr/bin/time -f '%e' cp \
              $DPATH/13389_S1_L002_R1_001.fastq.gz \
              $DPATH/13389_S1_L002_R2_001.fastq.gz \
              $SSDPATH >> $RESULT 2>&1

# Execute pandaseq and record time
echo -n "pandaseq time (s): " >> $RESULT
/usr/bin/time -f '%e' $EXE -f $SSDPATH/13389_S1_L002_R1_001.fastq.gz \
                           -r $SSDPATH/13389_S1_L002_R2_001.fastq.gz \
                           -w 13389_S1_L002_aligned_$SLURM_JOB_ID.fasta \
                           -u 13389_S1_L002_unaligned_$SLURM_JOB_ID.fasta \
                           -G 13389_S1_L002_log._$SLURM_JOB_ID.txt.bz2 \
                           -T $SLURM_NTASKS_PER_NODE >> $RESULT 2>&1
