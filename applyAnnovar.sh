#!/bin/sh

#echo "Enter the filename to seek:"
#read INPUT
#x =$(find /Users/naru/Documents/BISR/WESPipelinePaper/benchmarking  -name "*.raw.vcf")

ANN="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/annovar/table_annovar.pl"
HG19="/home/ngs/narumeena/Documents/BISR/AAnemia/BISR/genome/hg19/hg19index/bwa"
for VAR in $(find $(pwd) -name "*.vcf"); 
do # Not recommended, will break on whitespace
	perl /home/ngs/narumeena/Documents/BISR/AAnemia/BISR/software/annovar/table_annovar.pl "${VAR}" /home/ngs/narumeena/Documents/BISR/AAnemia/BISR/genome/hg19/hg19index/bwa -buildver hg19 -out "${VAR}" --otherinfo -remove -protocol ensGene,esp6500siv2_all,snp138,cytoBand,exac03 -operation g,f,f,r,f -nastring . --vcfinput
done 

exit 0
