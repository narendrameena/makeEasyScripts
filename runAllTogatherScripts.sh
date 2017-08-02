#!/bin/sh
#author narumeena
#description run all files parallel step wise step for aplstic anemia study 

#quality control check 
sh fastqcParallel.sh 

#alingment using bwa 
sh bwaParallel.sh