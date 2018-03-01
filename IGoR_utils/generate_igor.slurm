#!/bin/bash
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -t 24:00:00
#SBATCH -J IGoR_gen
#SBATCH --export=ALL
#SBATCH -A ddp267

WDPATH=$PWD
IGOR=/home/sinkovit/IGoR_dev/exe/bin/igor_minout

CHAIN=beta
COUNT=1100000000
#SEED=1234
#OUTDIR=tcr_beta
SEED=12345678
OUTDIR=tcr_beta_rnd1

time $IGOR -threads -1 -set_wd $WDPATH -batch $OUTDIR -species human -chain $CHAIN -generate $COUNT --CDR3 --seed $SEED --noerr
