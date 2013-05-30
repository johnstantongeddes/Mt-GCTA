#!/bin/bash 

# Set variables from command-line arguments
PLINKdir=$1
PLINKpre=$2
traitfile=$3
trait=$4
sample=$5

# Make trait directory
mkdir $trait 
cd $trait

for i in {1..100}
do
	# Create list of accessions to include in analysis
	shuf -n $sample $PLINKdir/${PLINKpre}1.fam | cut -d ' ' -f 1-2 > accession.list

	# Estimate genetic relationship matrix (GRM) for each pseudomolecule
	for k in T U 1 2 3 4 5 6 7 8
	do
			gcta64 --bfile $PLINKdir/${PLINKpre}${k} --keep accession.list --maf 0.02 --make-grm --out GRM_${sample}_chr${k}
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
done

