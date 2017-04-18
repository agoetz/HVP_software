# PyIg benchmarks

## Software
PyIg from Crowe lab (github commit 43aa909836f)

## Hardware
Dual socket 12-core Intel E5-2680 v3 @ 2.50GHz with 128GB RAM and
320GB local SSD scratch space (SDSC Comet supercomputer)

## Data sets
FASTA files with 1,000,000 to 99,212,714 sequences, generated with
Pandaseq from Vanderbilt pre-pilot paired end reads.
* `13389_S1_L001_aligned.fasta` (or first N entries)

## Results
Parallelization is based on Python’s multiprocessing module, which is
limited to SMP nodes. The easiest way to parallelize across multiple
nodes would be to simply split FASTA files and process on separate
nodes. Below are  results with default PyIg settings for a single
Comet compute node using local SSD scratch disk space and 6 to 24
processes.

| Sequences | Processes |   Time   | Sequences/s | Sequences/SU |
|----------:|----------:|:--------:|------------:|-------------:|
| 1,000,000 |         6 | 02:02:47 |         136 |       81,444 |
| 1,000,000 |        12 | 01:07:01 |         249 |       74,608 |
| 1,000,000 |        24 | 00:35:19 |         472 |       70,788 |
| 2,000,000 |        24 | 01:10:48 |         471 |       70,621 |
| 4,000,000 |        24 | 02:22:38 |         467 |       70,110 |
| 8,000,000 |        24 | 04:46:14 |         466 |       69,873 |
|99,212,147 |        24 | > 48h    |             |              |

As expected the runtime is approximately linear in the number of
sequences. On 1 Comet node we obtain a performance of around 70k
sequences per core hour. The initial splitting of the FASTA file by
PyIg is a serial process, which somewhat affects scaling.

For large number of sequences the local SSD scratch space is
insufficient. Benchmarks using the Data Oasis parallel filesystem
in place of the local SSD as scratch space show no difference in
performance.

