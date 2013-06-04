#!/bin/bash

# Script to combine results of subsampling accessions in single file

touch H2gcta_subsample_SNPs.txt

for sample in 2 25 250
do
		cd ${sample}k_MAF2_iterations
		touch temp

		for trait in FloweringDate height occupancyA occupancyB totalnod trichomes
		do
				cat temp H2gcta_${sample}k_SNPs_${trait}.txt >> /tmp/tempfile
				mv /tmp/tempfile temp
		done

		cat temp >> ../H2gcta_subsample_SNPs.txt
		rm /tmp/tempfile
		rm temp
		cd ..
done

