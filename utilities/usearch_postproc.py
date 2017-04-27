# Program usearch_postproc.py
#
# Description: Parses the aggregated output from multiple usearch runs
# to get collective statistics on the number of pairs, number of
# merged pairs, alignments with zero diffs, etc.
#
# Author: Robert Sinkovits, San Diego Supecomputer Center

import argparse
import six

parser = argparse.ArgumentParser(description='Get aggregate statitics from multiple usearch runs')

parser.add_argument(dest='infile',
                    help='Single file containing contacenation of multiple usearch runs')

args          = parser.parse_args()
infile        = args.infile

# Define search strings for parsing the usearch output
usearch_list = [
    'Pairs (' ,
    'Merged (' ,
    'Alignments with zero diffs (' ,
    'Too many diffs (' ,
    'Fwd tails Q <=' ,
    'Rev tails Q <=' ,
    'Fwd too short (' ,
    'Rev too short (' ,
    'No alignment found (' ,
    'Alignment too short (' ,
    'Merged too short (' ,
    'Staggered pairs ('              
    ]

# Define printable output names
usearch_outnames = {
    'Pairs (' :                      'Pairs' ,
    'Merged (' :                     'Merged' ,
    'Alignments with zero diffs (' : 'Alignments with zero diffs' ,
    'Too many diffs (' :             'Too many diffs' ,
    'Fwd tails Q <=' :               'Fwd tails Q <=' ,
    'Rev tails Q <=' :               'Rev tails Q <=' ,
    'Fwd too short (' :              'Fwd too short' ,
    'Rev too short (' :              'Rev too short' ,
    'No alignment found (' :         'No alignment found' ,
    'Alignment too short (' :        'Alignment too short' ,
    'Merged too short (' :           'Merged too short' ,
    'Staggered pairs (' :            'Staggered pairs'
    }
    
# Initialize dictionary for accumulating counts
usearch_counts = {}
for elem in usearch_list:
    usearch_counts[elem] = 0
    
# Loop over records in concatenated usearch output
with open(infile, 'r') as fin:
    for line in fin:
        line = line.rstrip()
        line = line.lstrip()
        fields = line.split(' ')
        for elem in usearch_list:
            if line.find(elem) >= 0:
                usearch_counts[elem] += int(fields[0])

# Print results
for elem in usearch_list:
    pct = float(usearch_counts[elem]) / float(usearch_counts['Pairs (']) * 100.0
    six.print_('{:12d} {} {}{:.2f}{}'.format(int(usearch_counts[elem]), usearch_outnames[elem], '(', pct, '%)'))
