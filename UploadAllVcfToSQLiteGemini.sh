#!/bin/sh

#author narumeena
#loading all vcf files to sqlite db

#variables
VT=/"home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/vt/vt"
REF="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/genome/hg19/hg19index/bwa/hg19.fasta"
GEMINI="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/gemini/bin/gemini"
SNPEFF="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/snpEff/snpEff.jar"
for VAR in $(find $(pwd) -name "*.vcf"); 
do # Not recommended, will break on whitespace
    if [ -f "${VAR%.*}.snpeff.ann.vcf" ]  
    then
        rm "${VAR%.*}.snpeff.ann.vcf"
    fi
    java -Xmx128g -jar "$SNPEFF"  hg19 "${VAR}" > "${VAR%.*}.snpeff.ann.vcf"
    if [ -f "${VAR%.*}.snpeff.ann.new.vcf" ] 
    then
        rm "${VAR%.*}.snpeff.ann.new.vcf"
    fi
    "$VT" decompose -s "${VAR%.*}.snpeff.ann.vcf" | "$VT"  normalize -r "$REF" - > "${VAR%.*}.snpeff.ann.new.vcf"
    if [ -f "${VAR%.*}.snpeff.ann.new.db" ] 
    then
        rm "${VAR%.*}.snpeff.ann.new.db"
    fi
    "$GEMINI" load -v "${VAR%.*}.snpeff.ann.new.vcf" -t snpEff "${VAR%.*}.snpeff.ann.new.db"
done 
exit 0