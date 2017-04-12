#!/bin/bash

# Name:  fastq_splitter.sh
# Usage: fastq_splitter.sh /full/path/to/reverse_or_forward_read
#
# Splits large paired end, compressed fastq files into manageable
# chunks (currently hardcoded to 2M reads), each in their own
# subdirectoires. For example
#
# fastq_splitter.sh /full/path/RB01_run61_IgG3_R1.fastq.gz
#
# RB01_run61_IgG3/
#   RB01_run61_IgG3_x000/
#     RB01_run61_IgG3_x000_1.fastq
#     RB01_run61_IgG3_x000_2.fastq
#   RB01_run61_IgG3_x001/
#     RB01_run61_IgG3_x001_1.fastq
#     RB01_run61_IgG3_x001_2.fastq
#   ...
#
# Script can take forward or reverse read and will correctly find the
# pairs. The only assumption is that the forward and reverse reads are
# in the same directory and differ only in last character before
# .fastq.gz

# Get the full path to one of the paired end reads from command line
fullname=$1

# Trim down to a base without path, extensions or read direction, For example: 
# /full/path/sample_run62_12345_1.fastq.gz --> sample_run62_12345
newdir=$(basename "$fullname")
newdir="${newdir%.*}"
newdir="${newdir%.*}"
newdir="${newdir%_*}"

# Create the new directory where we'll put the split data
echo "Creating new directory " $newdir
mkdir -p $newdir

# Get the names for the forward and reverse reads
forward=${fullname/?.fastq.gz/1.fastq.gz}
reverse=${fullname/?.fastq.gz/2.fastq.gz}
echo "Forward read " $forward
echo "Reverse read " $reverse

# Change to new directory and split files
# Create new subdirectories for each chunk
cd $newdir
zcat $forward | split -l 8000000 -a3 -d
for chunk in x???; do
    mkdir ${newdir}_${chunk}
    mv $chunk ${newdir}_${chunk}/${newdir}_${chunk}_1.fastq
done

zcat $reverse | split -l 8000000 -a3 -d
for chunk in x???; do
    mv $chunk ${newdir}_${chunk}/${newdir}_${chunk}_2.fastq
done
