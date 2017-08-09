#author narumeena
#description running gemini on mutak dataset 

#de novo  dbsnp and clinvar 
#missense 
#have loss of function 

/Users/naru/Documents/BISR/software/gemini/bin/gemini query -q "select * from variants where is_lof = 1 and in_dbsnp = 0" --header mutak2.GATK.mutac.raw.new.vep.ann.db > output.txt 