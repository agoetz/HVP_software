Download Pandaseq from
https://github.com/neufeld/pandaseq

Pandaseq man pages
http://neufeldserver.uwaterloo.ca/~apmasell/pandaseq_man1.html

----- Installation notes -----

The standard build and installation procedure is as follows, but minor
modifications may be required.

./autogen.sh

./configure --prefix=$HOME/HVP_exe/PANDASEQ

make

make install


(1) Comment out the following lines in configure

PKG_CHECK_MODULES(Z,  zlib )

PKG_CHECK_MODULES(CURL,  libcurl , have_curl=true, have_curl=false)

(2) Run autogen.sh and configure

./autogen.sh

./configure --prefix=$HOME/PANDASEQ

(3) In the Makefile that is generated from configure, search for
$(Z_LIBS) and replace with -lz (or maybe -L/usr/lib64 -lz)

(4) In the Makefile that is generated from configure, search for
$(CURL_LIBS) and replace with -lcurl (or maybe -L/usr/lib64
-lcurl). Curl functionality is currently commented
out. Including this step in case the developers decide to enable.

(5) Run make and make install

make

make install

----- Additional notes ----

PKG_CHECK_MODULES appears not to be universally supported and has been
known to cause problems. See the following for more information on
this topic

/usr/lib64/pkgconfig/zlib.pc for library info

https://autotools.io/pkgconfig/pkg_check_modules.html

https://en.wikipedia.org/wiki/Pkg-config
