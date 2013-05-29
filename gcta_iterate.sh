#!/bin/bash 

PLINKin=$1
traitfile=$2
trait=$3
sample=$4
SNPpercent=$5


for i in {1..100}
do
    mkdir $trait 
    cd $trait

	# Extract SNPs from PLINK files using --thin option to select random sample of SNPs specified at command-line 
	# e.g. 250,000/5,672,923 = 0.044 
	for j in T U 1 2 3 4 5 6 7 8
	  do
	    plink --noweb --bfile ${PLINKin}/Mt3.5_var261_filtered_chr${j} --thin $SNPpercent  --out ${sample}_chr${j} --make-bed
	  done

	# Estimate genetic relationship matrix (GRM) for each pseudomolecule
	for k in T U 1 2 3 4 5 6 7 8
	do
			gcta64 --bfile ${sample}_chr${k} --maf 0.02 --make-grm --out GRM_${sample}_chr${k}
	done
	  
	# Make mgrm file if it does not exist
	if [ ! -f mgrm.txt ];
	then
			for l in T U 1 2 3 4 5 6 7 8
			do
					echo "GRM_${sample}_chr$l" >> mgrm.txt
			done
	fi
	# Merge GRM for each pseudomolecule
	gcta64 --mgrm mgrm.txt --make-grm --out GRM_${sample}_combined

	# Estimate H2gcta for trait
	/home/youngn/stanton0/gcta_1.04/gcta64 --reml --grm GRM_${sample}_combined --pheno $traitfile --out reml_${trait}_${sample}_${i}

	# Read .hsq file and cat estimate of heritability to table
    Rscript ../hsq_report.R $trait $sample $i
    cd ..
done

