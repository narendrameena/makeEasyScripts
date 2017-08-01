#!/bin/sh
#author narumeena 

for VAR in $(find $(pwd) -name "*.sort.vcf"); 
do # Not recommended, will break on whitespace
	rm -r ${VAR} 
done 

exit 0
