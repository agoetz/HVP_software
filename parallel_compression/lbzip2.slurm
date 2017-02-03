#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --ntasks-per-node=24
#SBATCH -t 12:00:00
#SBATCH -J lbzip2
#SBATCH -A ddp267
#SBATCH --export=ALL

# Define paths to (de)compression executables
EXE_COMPRESS=/home/sinkovit/Compression/LBZIP2/lbzip2
EXE_UNCOMPRESS=/home/sinkovit/Compression/LBZIP2/lbunzip2

# Uncomment following for FASTA tests
COMPRESSED_FILE=13389_S1_L002_aligned_7487995.fasta.bz2
UNCOMPRESSED_FILE=13389_S1_L002_aligned_7487995.fasta

# Uncomment following for FASTQ tests
#COMPRESSED_FILE=13389_S1_L002_R2_001.fastq.bz2
#UNCOMPRESSED_FILE=13389_S1_L002_R2_001.fastq

RESULT=lbzip2_timings
echo "--- lbzip2/lbunzip2 benchmarks ---" > $RESULT
echo >> $RESULT

for cores in 1 2 3 4 8 16 24; do
  echo "$cores core (compress/uncompress)" >> $RESULT
  ls -lh $UNCOMPRESSED_FILE >> $RESULT
  echo -n "compress: " >> $RESULT
  /usr/bin/time -f '%e' $EXE_COMPRESS -n $cores $UNCOMPRESSED_FILE >> $RESULT 2>&1
  ls -lh $COMPRESSED_FILE >> $RESULT
  echo -n "uncompress: " >> $RESULT
  /usr/bin/time -f '%e' $EXE_UNCOMPRESS -n $cores $COMPRESSED_FILE >> $RESULT 2>&1
  echo  >> $RESULT
done
