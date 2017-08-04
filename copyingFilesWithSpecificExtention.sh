#!/bin/sh
#author narumeena

#copying files from server to local 
rsync -a --include '*/' --include '*.indel' --exclude '*' narumeena@192.168.1.17:/home/ngs/narumeena/Documents/1000GenomeSamplesBenchmarking/ /Users/naru/Documents/BISR/WESPipelinePaper/benchmarking/


#find . -name \*.xls -exec cp {} newDir \;



find ./ -name '*.xsl' -exec cp -prv '{}' '/path/to/targetDir/' ';'

#It will look in the current directory and recursively in all of the sub directories for files with the xsl extension. It will copy them all to the target directory.

find . -name '*.csv' -exec cp --parents \{\} /target \;