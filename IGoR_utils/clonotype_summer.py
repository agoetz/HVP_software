import argparse

parser = argparse.ArgumentParser(description='Sum over clonotype counts')

parser.add_argument('-i', dest='input_file', help='Input file') 

args = parser.parse_args()
input_file = args.input_file

counter = 0
with open(input_file, 'r') as fin:
    # Skip header
    fin.readline()
    for line in fin:
        tmp1, tmp2, cnt = line.split()
        counter += int(cnt)

print(counter)
