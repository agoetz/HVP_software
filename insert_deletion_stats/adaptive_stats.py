import glob

# Initialize arrays containing counts for numbers of insertions
# and deletions

vdel = [0] * 21
n1ins = [0] * 21
d5del = [0] * 21
d3del = [0] * 21
n2ins = [0] * 21
jdel = [0] * 21

# Loop over files and records within each file, skipping header line

for filename in glob.glob('Keck*tsv'):
    print(filename)
    with open(filename) as f:
        f.readline()
        for line in f:
            fields = line.split(sep='\t')

            if(fields[26].isdigit()):
                n = int(fields[26])
                if n <= 20:
                    vdel[n] += 1
            if(fields[27].isdigit()):
                n = int(fields[27])
                if n <= 20:
                    n1ins[n] += 1
            if(fields[28].isdigit()):
                n = int(fields[28])
                if n <= 20:
                    d5del[n] += 1
            if(fields[29].isdigit()):
                n = int(fields[29])
                if n <= 20:
                    d3del[n] += 1
            if(fields[30].isdigit()):
                n = int(fields[30])
                if n <= 20:
                    n2ins[n] += 1
            if(fields[31].isdigit()):
                n = int(fields[31])
                if n <= 20:
                    jdel[n] += 1

print()

print("Counts for Vdel, N1ins, D5del, D3del, N2ins, Jdel")
print("1st element corresponds to zero deletions or insertions\n")
for x in vdel, n1ins, d5del, d3del, n2ins, jdel:
    print(x, "\n")

print("Probabilities for Vdel, N1ins, D5del, D3del, N2ins, Jdel")
print("1st element corresponds to zero deletions or insertions\n")
for x in vdel, n1ins, d5del, d3del, n2ins, jdel:
    mysum = sum(x)
    y = ["{:.4f}".format(a/mysum) for a in x]
    print(y, "\n")
