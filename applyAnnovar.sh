#!/bin/sh

#echo "Enter the filename to seek:"
#read INPUT
#x =$(find /Users/naru/Documents/BISR/WESPipelinePaper/benchmarking  -name "*.raw.vcf")

for VAR in $(find /Users/naru/Documents/BISR/WESPipelinePaper/benchmarking  -name "*.raw.vcf"); 
do # Not recommended, will break on whitespace
	perl /Users/naru/Documents/BISR/AAReviewPaper/software/annovar/table_annovar.pl "${VAR}" /Users/naru/Documents/BISR/AAReviewPaper/genome/hg19/hg19index/bwa -buildver hg19 -out "${VAR}" --otherinfo -remove -protocol ensGene -operation g -nastring . --vcfinput
done 

exit 0
