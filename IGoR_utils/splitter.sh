# Split clonotypes file into three files with record counts equal to
# the number of TCRB reads for each donor
#
# HIP1 61973912
# HIP2 88570968
# HIP3 126818156

sed -n 1,61973912p          clonotypes >  tcrb_hip1
sed -n 61973913,150544880p  clonotypes >  tcrb_hip2
sed -n 150544881,277363036p clonotypes >  tcrb_hip3
