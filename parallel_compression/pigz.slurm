#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --ntasks-per-node=24
#SBATCH -t 5:00:00
#SBATCH -J pigz
#SBATCH -A ddp267
#SBATCH --export=ALL

# Define paths to (de)compression executables, (un)compressed files
EXE_COMPRESS=/home/sinkovit/Compression/PIGZ/pigz
EXE_UNCOMPRESS=/home/sinkovit/Compression/PIGZ/unpigz
COMPRESSED_FILE=13389_S1_L002_R2_001.fastq.gz
UNCOMPRESSED_FILE=13389_S1_L002_R2_001.fastq

RESULT=pigz_timings
echo "--- pigz/unpigz benchmarks ---" > $RESULT
echo >> $RESULT

for cores in 1 2 3 4 8 16 24; do
  echo "$cores core (compress/uncompress)" >> $RESULT
  ls -lh $UNCOMPRESSED_FILE >> $RESULT
  echo -n "compress: " >> $RESULT
  /usr/bin/time -f '%e' $EXE_COMPRESS -p $cores $UNCOMPRESSED_FILE >> $RESULT 2>&1
  ls -lh $COMPRESSED_FILE >> $RESULT
  echo -n "uncompress: " >> $RESULT
  /usr/bin/time -f '%e' $EXE_UNCOMPRESS -p $cores $COMPRESSED_FILE >> $RESULT 2>&1
  echo  >> $RESULT
done

#echo "1 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 1 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 1 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "2 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 2 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 2 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "3 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 3 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 3 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "4 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 4 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 4 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "8 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 8 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 8 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT

#echo "16 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 16 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "uncompress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 16 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
#
#echo "24 core (compress/uncompress)" >> $RESULT
#ls -lh $UNCOMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_COMPRESS -p 24 $UNCOMPRESSED_FILE >> $RESULT 2>&1
#ls -lh $COMPRESSED_FILE >> $RESULT
#echo -n "compress: " >> $RESULT
#/usr/bin/time -f '%e' $EXE_UNCOMPRESS -p 24 $COMPRESSED_FILE >> $RESULT 2>&1
#echo  >> $RESULT
