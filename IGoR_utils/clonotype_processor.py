import argparse
from collections import Counter

parser = argparse.ArgumentParser(description='Process clonotype file')

parser.add_argument('-i', dest='input_file', help='Input file') 

args = parser.parse_args()
input_file = args.input_file


# Process clonotype file and keep track of number of unique clonotypes
# as a function of number of reads

c = Counter()
reads = 0
max_len = 53

cdr3_len_hist = [0] * max_len
fout = open(input_file + '_rarefaction', 'w')
fout.write("   Reads    unique clonotypes\n")
with open(input_file, 'r') as fin:
    for clonotype in fin:
        clonotype = clonotype.strip()
        c[clonotype] += 1
        reads += 1
        vgene, jgene, cdr3 = clonotype.split()
        if c[clonotype] == 1:
            cdr3_len = len(cdr3)
            cdr3_len_hist[cdr3_len] += 1
        if reads%100000 == 0:
            fout.write('{:10d} {:10d}\n'.format(reads, len(c.keys())))

fout.write('{:10d} {:10d}\n'.format(reads, len(c.keys())))
fout.close

# Output CDR3 length histograms
fout = open(input_file + '_cdr3_len', 'w')
fout.write(' len ' + '   #(w/ anchor) ' + '   #(w/0 anchor)\n')
fout.write('{:5d}      {:10d}      {:10d}\n'.format(0, cdr3_len_hist[0], cdr3_len_hist[2]))
fout.write('{:5d}      {:10d}      {:10d}\n'.format(1, cdr3_len_hist[1], cdr3_len_hist[3]))
for i in range(2, max_len-2):
    fout.write('{:5d}      {:10d}      {:10d}\n'.format(i, cdr3_len_hist[i], cdr3_len_hist[i+2]))
fout.close()

# Output clonotypes and number of times clonotypes occur
fout = open(input_file + '_count', 'w')
for k,v in c.items():
    fout.write(k + ' ' + str(v) + '\n')
fout.close()

