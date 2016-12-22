#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH --ntasks-per-node=3
#SBATCH -t 2:00:00
#SBATCH -J pseq
#SBATCH -A ddp267
#SBATCH --export=ALL

DPATH=/oasis/scratch/comet/sinkovit/temp_project/HVP/Vanderbilt_data
EXE=/home/sinkovit/PANDASEQ/bin/pandaseq
RESULT=pseq.$SLURM_JOB_ID.$SLURM_NTASKS_PER_NODE

# Number of threads is controlled by the pandaseq -T option and is set
# equal to the value assigned to ntasks-per-node

echo -n "pandaseq time (s): " > $RESULT
/usr/bin/time -f '%e' $EXE -f $DPATH/13389_S1_L002_R1_001.fastq.gz \
                           -r $DPATH/13389_S1_L002_R2_001.fastq.gz \
                           -w 13389_S1_L002_aligned_$SLURM_JOB_ID.fasta \
                           -u 13389_S1_L002_unaligned_$SLURM_JOB_ID.fasta \
                           -G 13389_S1_L002_log._$SLURM_JOB_ID.txt.bz2 \
                           -T $SLURM_NTASKS_PER_NODE >> $RESULT 2>&1
