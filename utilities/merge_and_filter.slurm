#!/bin/bash
#!/bin/bash
#SBATCH -p compute
#SBATCH -N 1
#SBATCH --ntasks-per-node=24
#SBATCH -t 03:00:00
#SBATCH -J filter
#SBATCH -A ddp267
#SBATCH --export=ALL

# Name:  fastq_splitter.sh
# Usage: fastq_splitter.sh /full/path/to/reverse_or_forward_read [chunks]
#
# Splits large paired end, compressed fastq files into manageable
# chunks (24 chunks by default)
#
# fastq_splitter.sh /full/path/RB01_run61_IgG3_R1.fastq.gz
#
# RB01_run61_IgG3/
#   RB01_run61_IgG3_x000_1.fastq
#   RB01_run61_IgG3_x000_2.fastq
#   RB01_run61_IgG3_x001_1.fastq
#   RB01_run61_IgG3_x001_2.fastq
#   ...
#
# Script can take forward or reverse read and will correctly find the
# pairs. The only assumption is that the forward and reverse reads are
# in the same directory and differ only in last character before
# .fastq.gz

# Get the full path to one of the paired end reads from command line
echo "input file: $1"
fullname=$1

# Set path to usearch executable
USEARCH=/home/sinkovit/Usearch/usearch9.2.64_i86linux32
FILTER=/home/sinkovit/AndreFilter/seeq-clean-fastq.sh

# Set the number of reads and line count
# (For fastq files, line count = 4 x number of reads)

chunks=24
if [ $# == 2 ]; then
    chunks=$2
fi

# Trim down to a base without path, extensions or read direction, For example: 
# /full/path/sample_run62_12345_1.fastq.gz --> sample_run62_12345
base=$(basename "$fullname")
base="${base%.*}"
base="${base%.*}"
base="${base%_*}"

t0=`date +%s` # Before splitting files

# Get the names for the forward and reverse reads
forward=${fullname/?.fastq.gz/1.fastq.gz}
reverse=${fullname/?.fastq.gz/2.fastq.gz}
echo "Forward read " ${forward}
echo "Reverse read " ${reverse}

# Uncompress forward/reverse reads and get uncompressed file lengths in parallel
zcat ${forward} | tee ${base}_forward.fastq | wc -l | cut -d ' ' -f 1 > ${base}_ff & 
zcat ${reverse} | tee ${base}_reverse.fastq | wc -l | cut -d ' ' -f 1 > ${base}_rf &
wait

length_forward=`cat ${base}_ff`
length_reverse=`cat ${base}_rf`

echo "length_forward " ${length_forward}
echo "length_reverse " ${length_reverse}

let "lines = ${length_forward} / $chunks"
let "lines = $lines / 4"
let "lines = $lines + 1"
let "lines = $lines * 4"

# Split forward and reverse reads in parallel
split -l ${lines} -a3 -d ${base}_forward.fastq ${base}_forward_ &
split -l ${lines} -a3 -d ${base}_reverse.fastq ${base}_reverse_ &
wait

# Rename forward and reverse read chunks
for chunk in ${base}_forward_???; do
    newname=${chunk/_forward/}
    mv ${chunk} ${newname}_1.fastq
done

for chunk in ${base}_reverse_???; do
    newname=${chunk/_reverse/}
    mv ${chunk} ${newname}_2.fastq
done

rm ${base}_forward.fastq
rm ${base}_reverse.fastq

t1=`date +%s` # After splitting files / before usearch

# Launch usearch jobs
for forward in ${base}_???_1.fastq; do
    reverse=${forward/_1.fastq/_2.fastq}
    abase=${forward/_1.fastq/}
    echo $abase
    $USEARCH -fastq_mergepairs ${forward} -reverse ${reverse}    \
                           -fastq_minmergelen  50                \
                           -report "${abase}-SUMMARY.txt"        \
                           -tabbedout "${abase}-REPORT.tab"      \
                           -fastq_maxdiffs  10                   \
                           -alnout  "${abase}.aln"               \
                           -fastqout "${abase}.fastq"            \
                           -threads 1 &
done

# Wait for all usearch jobs to complete
wait

t2=`date +%s` # After usearch / before filter

# Launch filter jobs
for fastq in ${base}_???.fastq; do
    $FILTER ${fastq} &
done

# Wait for all filter jobs to complete
wait

t3=`date +%s` # After filter / before cleanup

cat ${base}_???.fastq       > ${base}.fastq &
cat ${base}_???_clean.fastq > ${base}_clean.fastq &
cat ${base}_???-SUMMARY.txt > ${base}-SUMMARY.txt &
wait

rm ${base}_???.fastq ${base}_???_clean.fastq
rm ${base}_???_[12].fastq
rm ${base}_???.aln
rm ${base}_???-REPORT.tab
rm ${base}_???-SUMMARY.txt
rm ${base}_ff ${base}_rf

t4=`date +%s` # After cleanup

let "tsplit  = $t1 - $t0"
let "tmerge  = $t2 - $t1"
let "tfilter = $t3 - $t2"
let "tclean  = $t4 - $t3"
let "ttotal  = $t4 - $t0"

echo
echo "----- timings (seconds) -----"
echo "split:  $tsplit"
echo "merge:  $tmerge"
echo "filter: $tfilter"
echo "clean:  $tclean"
echo "TOTAL:  $ttotal"
