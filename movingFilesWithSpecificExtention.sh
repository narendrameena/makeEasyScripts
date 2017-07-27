#!/bin/sh


for VAR in $(find $(pwd) -name "*.indel"); 
do # Not recommended, will break on whitespace
	mv ${VAR} "${VAR}.vcf"
done 

exit 0
