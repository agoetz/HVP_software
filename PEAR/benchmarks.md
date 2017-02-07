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
thread count. Although the scalability is generally good (21x speedup on 24 cores), the overall performance (measured by walltime) is low compared to Pandaseq



|Cores    | t (s)    |
| ------- |:--------:|
|  1      | 83298    |
|  2      | 43227    |
|  4      | 18804    |
|  8      | 10521    |
| 16      |  5658    |
| 24      |  3953    |

