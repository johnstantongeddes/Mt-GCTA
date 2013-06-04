#!/bin/bash

# Script to combine results of subsampling accessions in single file

touch H2gcta_subsample_accessions.txt

for sample in 50 100 150 200
do
		cd accessions_${sample}
		touch temp

		for trait in FloweringDate height occupancyA occupancyB totalnod trichomes
		do
				cat temp H2gcta_${sample}_accessions_${trait}.txt >> /tmp/tempfile
				mv /tmp/tempfile temp
		done

		cat temp >> ../H2gcta_subsample_accessions.txt
		rm /tmp/tempfile
		rm temp
		cd ..
done

