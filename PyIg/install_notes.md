# Obtaining PyIg

Download from private github repository of James Crowe's lab
<https://github.com/crowelab/PyIg>

# Requirements

* Python version 2.7 or higher
* BioPython

# Installation

Following installation procedure is specific for the current
development version in branch `andres_igblastn_parser`:

```
git clone https://github.com/crowelab/PyIg.git
cd PyIg
git checkout andres_igblastn_parser
pip install --user -e .
```

## User environment configuration on Comet

```
module purge
module load biopython
LOCAL_PYTHON_PATH=~/.local
export PATH=$LOCAL_PYTHON_PATH/bin:$PATH
export PYTHONPATH=$LOCAL_PYTHON_PATH/lib/python2.7/site-packages:$PYTHONPATH
```

# Usage notes

PyIg generates temporary files in the OS default temp dir, which can
be controlled by setting the environment variable `TMPDIR`.

Example that runs PyIg on a FASTA file test.fasta:

`pyig [-m M] [-cz N] [-f FORM] test.fasta`

will execute igblastn on all sequences in `test.fasta` using all
available compute cores and generate output file `test.json.gz`. 
A csv output format can be chosen instead of json by setting `-f
csv`.
The number of compute cores can be limited to M by flag `–m M`.  The
number of sequences to work on at once can be limited to N by flag
`–cz N`. This can become important in order not to run out of memory,
although the default is sufficient for all workloads tested on Comet.
