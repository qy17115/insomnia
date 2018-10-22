##!/bin/bash 
#
#
#PBS -l nodes=1:ppn=8,walltime=24:00:00

####################################################################################
## This script extract SNP dosage information from UK Biobank (UKBB) imputed data ##
####################################################################################

# Record some potentially useful details about the job:
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo PBS job ID is $PBS_JOBID
echo This jobs runs on the following machines:
echo `cat $PBS_NODEFILE | uniq`
echo "Extracting individual dosage data for list of SNPs from UKBB .bgen files"
echo "Data in /local/"$PBS_JOBID

module add apps/qctool-2.0 

############################################################################################		

# 1) Set your working directory
export WORK_DIR=/local/$PBS_JOBID
mkdir -p /local/$PBS_JOBID
cd $WORK_DIR

# 2) Define your input and output files
### IMPUTED BGEN DATA
bgen="/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/dosage_bgen/data.chr#.bgen"
# Note: If the input filename contains a # character, e.g. example_#.gen this is treated as a chromosomal wildcard and will match all (human) chromosomes

### NAME OUTPUT FILE (INDIVIDUAL DATA FOR DOSAGES FOR EACH VARIANT)
output="/panfs/panasas01/brms/qy17115/insomnia/data/iv.dosage"

### SAMPLE ID FILE
scp newblue1:/projects/MRC-IEU/research/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/data_app2393.sample .
sample=data_app2393.sample

### LIST OF RSIDs
rsid="/panfs/panasas01/brms/qy17115/insomnia/femaleonly.txt"

### SAMPLE FILTERS
## Standard exclusions (sex mismatch, chr aneuploidy and heterozygosity+missing outliers) - 1812 individuals to exclude
scp newblue1:/projects/MRC-IEU/research/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/standard_exclusions/data.combined_recommended.app2393.txt .
## Ancestry restrictions - 78 674 individuals to exclude from non "white British ancestry subset".
scp newblue1:/projects/MRC-IEU/research/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/ancestry/data.non_white_british.app2393.txt .
## Relatedness - 79 448 individuals to exclude
scp newblue1:/projects/MRC-IEU/research/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.minimal_relateds.app2393.txt .
scp newblue1:/projects/MRC-IEU/research/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.highly_relateds.app2393.txt .
# Note: In total (removing the non "white british ancestry subset", the mininal_relateds, the highly_relateds and recommended exclusions) there are 150 294 individuals to exclude from the imputed data.
## Concatenate all IDs that need to be excluded in one file
cat data.combined_recommended.app2393.txt data.non_white_british.app2393.txt data.minimal_relateds.app2393.txt data.highly_relateds.app2393.txt > excl_sample.txt
exclude=excl_sample.txt

### NAME LOG FILE
log="/panfs/panasas01/brms/qy17115/insomnia/data/log_femaleonly.txt"

### SNP STATS
stats="/panfs/panasas01/brms/qy17115/insomnia/data/stats_femaleonly.txt"

############################################################################################		

# 3) Run QCTOOL to extract dosages
qctool -g ${bgen} \
		-og ${output} \
		-s ${sample} \
		-incl-rsids ${rsid} \
		-excl-samples ${exclude} \
		-log ${log} 
# More info on QCTOOL v2: http://www.well.ox.ac.uk/~gav/qctool_v2

# 4) Compute per-variant summary statistics 
qctool -g ${output} \
		-snp-stats \
		-osnp ${stats}
# Note: This will compute genotype counts, allele counts and frequencies, missing data rates, info metrics, and a P-value against the null that genotypes are in Hardy-Weinberg proportions in diploid samples.

##############################################################################################

# Remove local data files
#
cd /local
rm -rf $PBS_JOBID

#In unix you will need to do the following:
#cd path_for_your_script
#dos2unix *.sh
#chmod +x *.sh
#submit job:
#qsub scriptname.sh

#check queue and whether job is running:
#qstat -u username
