#!/bin/sh
#author narumeena 


#selec all vcf files 

for VAR in $(find $(pwd) -name "*.vcf"); 
do # Not recommended, will break on whitespace
	vcf-sort ${VAR} > "${VAR%.*}.sort.vcf"
    bgzip -c "${VAR%.*}.sort.vcf" > "${VAR%.*}.sort.vcf.gz"
    tabix -p vcf "${VAR%.*}.sort.vcf.gz"
    OUT=echo "${VAR%.*}.sort.vcf.gz" | awk -F"." '{print $1}' | awk -F"/" '{print $NF}'
    /Users/naru/Documents/BISR/software/rtg-tools/rtg vcfeval -b /Users/naru/Documents/BISR/software/rtg-tools/TrueData/NA12878.sort.vcf.gz -c "${VAR%.*}.sort.vcf.gz" -t /Users/naru/Documents/BISR/genome/hg19/hg19index/bwa/hg19/  -o ${VAR%.*}
done 

exit 0
