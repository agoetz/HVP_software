#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH --ntasks-per-node=3
#SBATCH -t 2:00:00
#SBATCH -J pseq_out
#SBATCH -A ddp267
#SBATCH --export=ALL

# Benchmarking and scaling study note:
# Number of threads is controlled by the pandaseq -T option and is set
# equal to the value assigned to ntasks-per-node

# Define paths to data directory, scratch directory, executable and results file
DPATH=/oasis/scratch/comet/sinkovit/temp_project/HVP/Vanderbilt_data
SSDPATH=/scratch/$USER/$SLURM_JOB_ID 
EXE=/home/sinkovit/PANDASEQ/bin/pandaseq
RESULT=pseq_ssdout.$SLURM_JOB_ID.$SLURM_NTASKS_PER_NODE

# Initialize the content of the timing results file
echo -n '' > $RESULT

# Workflow
# (1) Execute pandaseq: read from oasis, write to SSD
# (2) Copy results from SSD to oasis

echo -n "pandaseq time (s): " >> $RESULT
/usr/bin/time -f '%e' $EXE -f $DPATH/13389_S1_L002_R1_001.fastq.gz \
                           -r $DPATH/13389_S1_L002_R2_001.fastq.gz \
                           -w $SSDPATH/13389_S1_L002_aligned_$SLURM_JOB_ID.fasta \
                           -u $SSDPATH/13389_S1_L002_unaligned_$SLURM_JOB_ID.fasta \
                           -G $SSDPATH/13389_S1_L002_log._$SLURM_JOB_ID.txt.bz2 \
                           -T $SLURM_NTASKS_PER_NODE >> $RESULT 2>&1

# Copy the results from SSD and record time
echo -n "copy data to SSD time (s): " >> $RESULT
/usr/bin/time -f '%e' cp $SSDPATH/13389_S1_L002_aligned_$SLURM_JOB_ID.fasta \
                         $SSDPATH/13389_S1_L002_unaligned_$SLURM_JOB_ID.fasta \
                         $SSDPATH/13389_S1_L002_log._$SLURM_JOB_ID.txt.bz2 . \
                         >> $RESULT 2>&1
