import argparse

parser = argparse.ArgumentParser(description='Calculate overlap between sets clonotypes')

parser.add_argument('-a', dest='clono1', help='Clonotypes donor 1') 
parser.add_argument('-b', dest='clono2', help='Clonotypes donor 2') 
parser.add_argument('-o', dest='output_file', help='Output file') 

args = parser.parse_args()
clono1 = args.clono1
clono2 = args.clono2
output_file = args.output_file

file1 = open(clono1, 'r')
set1 = set(file1.readlines())
file2 = open(clono2, 'r')
set2 = set(file2.readlines())

overlap = set1.intersection(set2)

print('Unique clonotypes 1st donor ', len(set1))
print('Unique clonotypes 2nd donor ', len(set2))
print('Overlap clonotypes          ', len(overlap))

fout = open(output_file, 'w')
for c in overlap:
    fout.write(c)
fout.close()
