#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#package
require(data.table)
require(reshape2)
require(readstata13)

#input data
genetic<-fread("O:/ukbb-sleep/genetic/iv.dosage")
information<-genetic[,list(chromosome,SNPID,rsid,position,alleleA,alleleB)]
genetic_use<-genetic[, c("chromosome","SNPID","position","alleleA","alleleB"):=NULL]

#reshape data
genetic_use_long<-dcast(melt(as.matrix(genetic_use)), Var2~paste0('r', Var1), value.var='value')
colnames(genetic_use_long) <- genetic_use_long[1,]
genetic_use_long <- genetic_use_long[-1, ]
colnames(genetic_use_long)[1]<-"eid"

#QC
#standard exclusion, those participants have been excluded already by IEU data manager
#european descent, particpants in current dataset are of European descent 
#see https://data.bris.ac.uk/datasets/3074krb6t2frj29yh2b03x3wxj/UK%20Biobank%20Genetic%20Data_MRC%20IEU%20Quality%20Control%20version%201.pdf
#relatedness
minimal<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.minimal_relateds_app2393.txt")
high_related<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.highly_relateds_app2393.txt")
related<-rbind(minimal,high_related)
colnames(related)<-c("eid","eid2")
exclude_related<-merge(genetic_use_long,related,by="eid",all=TRUE)
genetic_use_exluded<-exclude_related[ which(is.na(exclude_related$eid2)),]
genetic_use_exluded<-genetic_use_exluded[c(1:72)]
