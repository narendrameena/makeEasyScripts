#!/bin/sh
#author narumeena

#copying files from server to local 
rsync -a --include '*/' --include '*.indel' --exclude '*' narumeena@192.168.1.17:/home/ngs/narumeena/Documents/1000GenomeSamplesBenchmarking/ /Users/naru/Documents/BISR/WESPipelinePaper/benchmarking/