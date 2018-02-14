import argparse
from Bio.Seq import Seq
from Bio.Alphabet import IUPAC

parser = argparse.ArgumentParser(description='Parse V(D)J fasta files and IGoR output to create clonotypes file containing gene names and CDR3 amino acid translations')

parser.add_argument('-v', dest='vgenes_file', help='V gene fasta file') 
parser.add_argument('-j', dest='jgenes_file', help='J gene fasta file') 
parser.add_argument('-c', dest='cdr3_file', help='CDR3 file') 
parser.add_argument('-r', dest='realize_file', help='realization file') 

args = parser.parse_args()
vgenes_file = args.vgenes_file
jgenes_file = args.jgenes_file
cdr3_file = args.cdr3_file
realize_file = args.realize_file

print('V genes      ', vgenes_file)
print('J genes      ', jgenes_file)
print('CDR3         ', cdr3_file)
print('Realizations ', realize_file)

# Parse the V genes file and store arrays of allele and gene names

v_alleles = []
v_genes = []
with open(vgenes_file, 'r') as fin:
    for line in fin:
        if line.find('>') == 0:
            annot = line.split('|')
            allele = annot[1]
            star_loc = allele.find('*')
            gene = allele[0:star_loc]
            v_alleles.append(allele)
            v_genes.append(gene)

# Parse the J genes file and store arrays of allele and gene names

j_alleles = []
j_genes = []
with open(jgenes_file, 'r') as fin:
    for line in fin:
        if line.find('>') == 0:
            annot = line.split('|')
            allele = annot[1]
            star_loc = allele.find('*')
            gene = allele[0:star_loc]
            j_alleles.append(allele)
            j_genes.append(gene)

# Parse the IGoR realizations file and convert V and J allele indexes to gene names

v_choice = []
j_choice = []
with open(realize_file, 'r') as fin:
    # Skip header
    fin.readline()
    for line in fin:
        parsed = line.split(';')
        v_index = parsed[1]
        v_index = int(v_index.replace('(', '').replace(')', ''))
        v_choice.append(v_genes[v_index])
        j_index = parsed[2]
        j_index = int(j_index.replace('(', '').replace(')', ''))
        j_choice.append(j_genes[j_index])

# Parse the CDR3 file and print clonotype (V gene, J gene, AA CDR3) if:
# (a) J gene is inframe
# (b) CDR3 anchors are found
# (c) Amino acid translation of CDR3 contains no stop codons

cdr3_aa = []
with open(cdr3_file, 'r') as fin:
    # Skip header
    fin.readline()
    for line in fin:
        seq_index, nt_cdr3, anchors_found, is_inframe = line.split(',')
        seq_index = int(seq_index)
        anchors_found = int(anchors_found)
        is_inframe = int(is_inframe)
        if anchors_found and is_inframe:
            aa_cdr3 = Seq(nt_cdr3, IUPAC.unambiguous_dna).translate()
            if aa_cdr3.find('*') == -1:
                print(v_choice[seq_index], j_choice[seq_index], aa_cdr3)
