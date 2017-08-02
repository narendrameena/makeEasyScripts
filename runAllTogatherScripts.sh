#!/bin/sh
#author narumeena
#description run all files parallel step wise step for aplstic anemia study 

#quality control check 
sh fastqcParallel.sh 

#alingment using bwa on hg19 build 
sh bwaParallel.sh

#convert sam format into bam 
sh samtobamParallel.sh 

#merge all bam files into single file 
sh bamcopy.sh 

#sorting using picard 
sh picardParallel.sh 

#indexing using samtools 
sh samIndexing1.sh 


#mark duplicates using picard 
sh picardMarkDuplicates.sh

#samtools indexing again after mark duplication 
sh sampleIndexing2.sh 


#GATK realinger applied 
sh GATKRealinger.sh 

#GATK indelrealingment 
sh GATKIndelRealing.sh 

#GATK base Recalibaration 
sh GATKBaseRecalibaration.sh

#GATK print reads optional 
sh GATKPrintRead.sh


#GATK hayplotype caller 
sh GATKHaplotype.sh

#GATK unified caller 
sh GATKUnified.sh  

#GATK all CAller 
sh GATKAllCaller.sh



