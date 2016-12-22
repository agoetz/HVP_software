#Pandaseq benchmarks

##Sofware
pandaseq (GitHib commit 6f92f31)

##Hardware
Dual socket 12-core Intel E5-2680 v3 @ 2.50GHz (SDSC Comet supercomputer)

##Data set
Vanderbilt pre-pilot paired end reads (corresponds to 98,913,801 reads)

13389_S1_L002_R1_001.fastq.gz

13389_S1_L002_R2_001.fastq.gz

##Output
13389_S1_L002_aligned_7000611.fasta (97,838,096 reads)

13389_S1_L002_unaligned_7000611.fasta (1,075,705 reads)

##Results

Pandaseq is a threaded code and we measured the run time as a function
of thread count. Find that going beyond two threads does not improve
performance and may even impact performance.

Pandaseq developers claim that the code is I/O bound. To test this
claim, we repeated the benchmarks using the local SSDs available on
the compute nodes. We copied input data to the SSDs and/or wrote
results results to SSDs. The timings below, which do not include the
time needed to move data and/or results to disk, show that this has no
measureable impact on pandaseq performance.

|Cores    | t (no SSD)    | t (SSD in)    | t (SSD out)  | t (SSD inout) |
| ------- |:-------------:|:-------------:|:------------:|:-------------:|
| 1       | 4156.19       | 4174.25       | 4096.18      | 4236.49       |
| 2       | 2622.80       | 2566.23       | 2752.10      | 2605.08       |
| 3       | 2649.50       | 2659.42       | 2755.59      | 2690.42       |
| 8       | 2789.92       | 2729.27       | 2763.49      | 2830.39       |
