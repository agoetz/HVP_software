#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --ntasks-per-node=24
#SBATCH -t 5:00:00
#SBATCH -J lbzip2
#SBATCH -A ddp267
#SBATCH --export=ALL

# Define paths to (de)compression executables, (un)compressed files
EXE_COMPRESS=/home/sinkovit/Compression/LBZIP2/lbzip2
EXE_UNCOMPRESS=/home/sinkovit/Compression/LBZIP2/lbunzip2
COMPRESSED_FILE=13389_S1_L002_R2_001.fastq.bz2
UNCOMPRESSED_FILE=13389_S1_L002_R2_001.fastq

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

#echo "1 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 1 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 1 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "2 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 2 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 2 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "3 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 3 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 3 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "4 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 4 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 4 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "8 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 8 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 8 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT

#echo "16 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 16 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 16 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "24 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -n 24 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -n 24 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
