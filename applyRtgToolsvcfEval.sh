#!/bin/sh
#author narumeena 


#selec all vcf files to process through rtgtools 


#variables 
RTG="/Users/naru/Documents/BISR/software/rtg-tools/rtg"
GOLDDATA="/Users/naru/Documents/BISR/software/rtg-tools/TrueData/NA12878.sort.vcf.gz"
REF="Users/naru/Documents/BISR/genome/hg19/hg19index/bwa/hg19/"
for VAR in $(find $(pwd) -name "*.vcf"); 
do # Not recommended, will break on whitespace
    rm "${VAR%.*}.sort.vcf"
	vcf-sort ${VAR} > "${VAR%.*}.sort.vcf"
    rm "${VAR%.*}.sort.vcf.gz"
    bgzip -c "${VAR%.*}.sort.vcf" > "${VAR%.*}.sort.vcf.gz"
    tabix -p vcf "${VAR%.*}.sort.vcf.gz"
    OUT=echo "${VAR%.*}.sort.vcf.gz" | awk -F"." '{print $1}' | awk -F"/" '{print $NF}'
    "$RTG" vcfeval -b "$GOLDDATA" -c "${VAR%.*}.sort.vcf.gz" -t "$REF"  -o ${VAR%.*}
done 
exit 0
