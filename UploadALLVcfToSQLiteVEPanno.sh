#!/bin/sh

#author narumeena
#loading all vcf files to sqlite db

#variables
VT="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/vt/vt"
REF="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/genome/hg19/hg19index/bwa/hg19.fasta"
GEMINI="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/gemini/bin/gemini"
VEP="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/ensembl-vep/vep.pl"
for VAR in $(find $(pwd) -name "*.raw.default.vcf" && find $(pwd) -name "*.raw.vcf" && find $(pwd) -name "*.cons.vcf" && find $(pwd) -name "*.pvalue.vcf" && find $(pwd) -name "*.indel.vcf" && find $(pwd) -name "*.snp.vcf") ; 
do # Not recommended, will break on whitespace
    if [ -f "${VAR%.*}.new.vcf" ] 
    then
        rm "${VAR%.*}.new.vcf"
    fi
    "$VT" decompose -s "${VAR%.*}.vcf" | "$VT"  normalize -r "$REF" - > "${VAR%.*}.new.vcf"
    if [ -f "${VAR%.*}.new.vep.ann.vcf" ]  
    then
        rm "${VAR%.*}.new.vep.ann.vcf"
    fi
    perl "$VEP" -i "${VAR%.*}.new.vcf" --cache --sift b --polyphen b --symbol --numbers --biotype --total_length -o "${VAR%.*}.new.vep.ann.vcf" --vcf --fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE 
    if [ -f "${VAR%.*}.new.vep.ann.db" ] 
    then
        rm "${VAR%.*}.new.vep.ann.db"
    fi
    "$GEMINI" load -v "${VAR%.*}.new.vep.ann.vcf" -t VEP "${VAR%.*}.new.vep.ann.db"
done 
exit 0