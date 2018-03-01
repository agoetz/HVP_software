#!/bin/bash
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -t 24:00:00
#SBATCH -J IGoR_parse
#SBATCH --export=ALL
#SBATCH -A ddp267

python3 igor_to_clonotypes.py -v genomicVs.fasta -j genomicJs.fasta -c generated_seqs_noerr_CDR3_info.csv -r generated_realizations_noerr.csv
