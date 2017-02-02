#Pandaseq benchmarks

##Sofware
PEAR v0.9.10 [May 30 2016]

##Hardware
Dual socket 12-core Intel E5-2680 v3 @ 2.50GHz (SDSC Comet supercomputer)

##Data set
Vanderbilt pre-pilot paired end reads (corresponds to 98,913,801 reads)

13389_S1_L002_R1_001.fastq.gz

13389_S1_L002_R2_001.fastq.gz

##Output
myout.assembled.fastq
myout.discarded.fastq
myout.unassembled.forward.fastq
myout.unassembled.reverse.fastq

##Results

PEAR is a threaded code and we measured the run time as a function of
thread count. Find that going beyond two threads does not improve
performance and may even impact performance.

Pandaseq developers claim that the code is I/O bound. To test this
claim, we repeated the benchmarks using the local SSDs available on
the compute nodes. We copied input data to the SSDs and/or wrote
results results to SSDs. The timings below, which do not include the
time needed to move data and/or results to disk, show that this has no
measureable impact on pandaseq performance.


|Cores    | t (s)    |
| ------- |:--------:|
|  1      |          |
|  2      |          |
|  4      | 18804    |
|  8      | 10521    |
| 16      |  5658    |
| 24      |  3953    |
