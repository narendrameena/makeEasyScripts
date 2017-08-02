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
    java -Xmx128g -jar "$SNPEFF" hg19 "${VAR}" > "${VAR%.*}.snpeff.ann.vcf"
    if [ -f "${VAR%.*}.new.vcf" ] 
    then
        rm "${VAR%.*}.new.vcf"
    fi
    "$VT" decompose -s "${VAR%.*}.snpeff.ann.vcf" | "$VT"  normalize -r "$REF" - > "${VAR%.*}.new.vcf"
    if [ -f "${VAR%.*}.new.vcf.db" ] 
    then
        rm "${VAR%.*}.new.vcf.db"
    fi
    "$GEMINI" load -v "${VAR%.*}.new.vcf" -t VEP "${VAR%.*}.new.vcf.db"
done 
exit 0