#!/bin/sh

#author narumeena
#loading all vcf files to sqlite db

#variables
VT=/"home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/vt/vt"
REF="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/genome/hg19/hg19index/bwa/hg19.fasta"
GEMINI="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/gemini/bin/gemini"
VEP="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/ensembl-vep/vep.pl"
for VAR in $(find $(pwd) -name "*.raw.default.vcf" && find $(pwd) -name "*.raw.vcf" && find $(pwd) -name "*.cons.vcf" && find $(pwd) -name "*.pvalue.vcf" && find $(pwd) -name "*.indel.vcf" && find $(pwd) -name "*.snp.vcf") ; 
do # Not recommended, will break on whitespace
    echo "$VAR"
    if [ -f "${VAR%.*}.vep.ann.vcf" ]  
    then
        rm "${VAR%.*}.vep.ann.vcf"
    fi
    perl "$VEP" -i "${VAR}" --cache --sift b --polyphen b --symbol --numbers --biotype --total_length -o "${VAR%.*}.vep.ann.vcf" --vcf --fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE 
    if [ -f "${VAR%.*}.vep.ann.new.vcf" ] 
    then
        rm "${VAR%.*}.vep.ann.new.vcf"
    fi
    "$VT" decompose -s "${VAR%.*}.vep.ann.vcf" | "$VT"  normalize -r "$REF" - > "${VAR%.*}.vep.ann.new.vcf"
    if [ -f "${VAR%.*}.vep.ann.new.db" ] 
    then
        rm "${VAR%.*}.vep.ann.new.db"
    fi
    "$GEMINI" load -v "${VAR%.*}.vep.ann.new.vcf" -t snpEff "${VAR%.*}.vep.ann.new.db"
done 
exit 0