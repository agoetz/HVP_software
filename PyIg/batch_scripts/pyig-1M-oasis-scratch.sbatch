#!/bin/bash
#SBATCH --partition=compute
#SBATCH --nodes=1          
#SBATCH --ntasks-per-node=24
#SBATCH --time=12:00:00
#SBATCH --account=ddp267
#SBATCH --job-name=pyig-1M-oasis-scratch
#SBATCH --output=pyig-1M-oasis-scratch.log
#SBATCH --export=ALL
#SBATCH --mail-user=agoetz@sdsc.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail

module purge
module load biopython

LOCAL_PYTHON_PATH=/home/agoetz/.local
export PATH=$LOCAL_PYTHON_PATH/bin:$PATH
export PYTHONPATH=$LOCAL_PYTHON_PATH/lib/python2.7/site-packages:$PYTHONPATH

export TMPDIR=/oasis/scratch/comet/$USER/temp_project/scratch

echo "============================="
echo ">>> running pyig on 1M.fasta"
echo "============================="

time pyig 1M.fasta
