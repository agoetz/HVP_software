Download PEAR from one of the following
http://www.exelixis-lab.org/pear
https://github.com/xflouris/PEAR.git

Pandaseq man pages
http://sco.h-its.org/exelixis/web/software/pear/doc.html

----- Installation notes -----

The standard installation looks like it should be pretty easy

./autogen.sh

./configure --prefix=$HOME/HVP_exe/PEAR

make

make install

On SDSC's Comet system this was complicated by not having a
sufficiently recent version of zlib installed in the standard
location. To get around this, we took the following steps. There's
probably an easier way to do this, but this is the only way I could
make things work

(1) Install zlib version 1.2.8 in the home directory

(2) Copy the zlib *.h files to the PEAR/src directory

(3) Set symbolic links libz.so and libz.so.1 that point to libz.so.1.2.8

(4) Replace -lz in Makefile and src/Makefile with -L/home/sinkovit/zlib-1.2.8 -lz

(5) Replace <zlib.h> with "zlib.h" in reader.c and reader.h

(6) When running pear executable, first set 

export LD_PRELOAD=/home/sinkovit/zlib-1.2.8/libz.so


----- Additional notes -----

PEAR is so slow compared to pandaseq that we probably wouldn't use
unless substantial improvements are made to the performance or there
are measurable differences in the accuracy of the results