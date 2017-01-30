#!/bin/bash
#SBATCH -p shared
#SBATCH -N 1
#SBATCH --ntasks-per-node=24
#SBATCH -t 3:00:00
#SBATCH -J pear
#SBATCH -A ddp267
#SBATCH --export=ALL

DPATH=/oasis/scratch/comet/sinkovit/temp_project/HVP/Vanderbilt_data
EXE=/home/sinkovit/HVP_exe/PEAR/bin/pear
CORES=24
RESULT=pear.$SLURM_JOB_ID.$CORES
export LD_PRELOAD=/home/sinkovit/zlib-1.2.8/libz.so

echo -n "pear time (s): " > $RESULT
/usr/bin/time -f '%e'       $EXE -j $CORES -o myout \
                           -f $DPATH/13389_S1_L002_R1_001.fastq.gz \
                           -r $DPATH/13389_S1_L002_R2_001.fastq.gz \
                            >> $RESULT 2>&1
