Mt-GCTA
=======

Scripts used for [GCTA](http://www.complextraitgenomics.com/software/gcta/) analysis of Medicago data

gcta_subsample_accessions.sh

  Expects 5 command-line arguments.
  1)  directory to PLINK files in bed format
  2)  prefix of plink files 
  3)  path to trait file
  4)  trait name
  5)  sample (e.g. number of accessions)
  
  Runs 100 iterations of selecting $sample number of accessions and calculating H2gcta
  
  
gcta_subsample_SNPs.sh

  Expects 5 command-line arguments.
  1)  directory to PLINK files in bed format
  2)  prefix of plink files 
  3)  path to trait file
  4)  trait name
  5)  SNPpercent (e.g. percent of SNPs to select from PLINK files)
  
  Runs 100 iterations of selecting $SNPpercent number of SNPs and calculating H2gcta
  
hsq_report.R

  R script that reads .hsq output of GCTA and saves results to a file in job root directory
  
combine_*.sh

  Scripts to combine results for all samples and traits into one file for analysis
