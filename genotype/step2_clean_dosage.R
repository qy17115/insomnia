#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#package
require(data.table)
require(reshape2)

#input data
genetic<-fread("O:/ukbb-sleep/genetic/iv.dosage")
information<-genetic[,list(chromosome,SNPID,rsid,position,alleleA,alleleB)]
genetic_use<-genetic[, c("chromosome","SNPID","position","alleleA","alleleB"):=NULL]

#reshape data
genetic_use_long<-dcast(melt(as.matrix(genetic_use)), Var2~paste0('r', Var1), value.var='value')
colnames(genetic_use_long) <- genetic_use_long[1,]
genetic_use_long <- genetic_use_long[-1, ]
colnames(genetic_use_long)[1]<-"eid"

#covariates
covariate<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/standard_covariates/data.covariates_app2393.txt",header = TRUE)
covariate<-covariate[c(2:4)]
colnames(covariate)<-c("eid","sex","array")
female<-covariate[ which(covariate$sex=="F"),]
female_use1<-merge(genetic_use_long,female,by="eid")

pc10<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/principal_components/data.pca1-10.field_22009_app2393.txt",header = TRUE)
pc10<-pc10[c(2:12)]
colnames(pc10)<-c("eid","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")
female_use1<-merge(female_use1,pc10,by="eid")

#QC
#standard exclusion, those participants have been excluded already by IEU data manager
#european descent, particpants in current dataset are of European descent 
#see https://data.bris.ac.uk/datasets/3074krb6t2frj29yh2b03x3wxj/UK%20Biobank%20Genetic%20Data_MRC%20IEU%20Quality%20Control%20version%201.pdf
#relatedness
minimal<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.minimal_relateds_app2393.txt")
high_related<-read.table("M:/data/ukbiobank/_latest/UKBIOBANK_Phenotypes_App_23938/data/derived/relateds_exclusions/data.highly_relateds_app2393.txt")
related<-rbind(minimal,high_related)
colnames(related)<-c("eid","eid2")
exclude_related<-merge(female_use1,related,by="eid",all=TRUE)
female_use2<-exclude_related[ which(is.na(exclude_related$eid2)),]
female_use2<-female_use2[c(1:84)]

#creat allele score
summary(female_use2)
for (i in 1:72){
  female_use2[,i] <- as.numeric(female_use2[,i])
}
#make sure effect allele
female_use2$rs13010288<-2-female_use2$rs13010288
female_use2$rs62158206<-2-female_use2$rs62158206
female_use2$rs3774751<-2-female_use2$rs3774751
female_use2$rs2116290<-2-female_use2$rs2116290
female_use2$rs13138995<-2-female_use2$rs13138995
female_use2$rs11167642<-2-female_use2$rs11167642
female_use2$rs1285875<-2-female_use2$rs1285875
female_use2$rs12534945<-2-female_use2$rs12534945
female_use2$rs150483923<-2-female_use2$rs150483923
female_use2$rs73201933<-2-female_use2$rs73201933
female_use2$rs1731951<-2-female_use2$rs1731951
female_use2$rs2344121<-2-female_use2$rs2344121
female_use2$rs671985<-2-female_use2$rs671985
female_use2$rs17643634<-2-female_use2$rs17643634
female_use2$rs1927898<-2-female_use2$rs1927898
female_use2$rs7026534<-2-female_use2$rs7026534
female_use2$rs12411886<-2-female_use2$rs12411886
female_use2$rs11605348<-2-female_use2$rs11605348
female_use2$rs4073582<-2-female_use2$rs4073582
female_use2$rs28576953<-2-female_use2$rs28576953
female_use2$rs755837<-2-female_use2$rs755837
female_use2$rs12912299<-2-female_use2$rs12912299
female_use2$rs4887111<-2-female_use2$rs4887111
female_use2$rs11075253<-2-female_use2$rs11075253
female_use2$rs35717469<-2-female_use2$rs35717469
female_use2$rs9931543<-2-female_use2$rs9931543
female_use2$rs7217547<-2-female_use2$rs7217547
female_use2$rs117037340<-2-female_use2$rs117037340
#unweighted allele score
female_use2$grs<-rowSums(female_use2[,c(2:72)])
summary(female_use2)
hist(female_use2$grs)

#output data
write.csv(female_use2,"O:/ukbb-sleep/genetic/iv.csv")
write.csv(information,"C:/mini project 2/results/insomnia71 in UKB.csv")
