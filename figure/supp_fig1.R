#supplementary figure 1 participants flow diagram
sex<-read.table("O:/ukbb-sleep/phenotype/data.covariates_app2393.txt",header = TRUE)
head(sex)
colnames(sex)<-c("eid","eid2","sex","array")
summary(sex)
female<-sex[which(sex$sex=="F"),]

#standard exclusion
standard_ex<-read.table("O:/ukbb-sleep/genetic/data.combined_recommended_app2393.txt",,header = TRUE)
colnames(standard_ex)<-c("eid","eid2")
female_standard<-merge(female,standard_ex,by="eid",all=TRUE)
female_exclude_standard<-female_standard[ which(is.na(female_standard$eid2.y)),]
female_exclude_standard<-female_exclude_standard[c(1:4)]

#minimal related
minimal_r<-read.table("O:/ukbb-sleep/genetic/data.minimal_relateds_app2393.txt",header = TRUE)
colnames(minimal_r)<-c("eid","eid2")
female_minimal<-merge(female_exclude_standard,minimal_r,by="eid",all=TRUE)
female_exclude_minimal<-female_minimal[ which(is.na(female_minimal$eid2)),]
female_exclude_minimal<-female_exclude_minimal[c(1:4)]

#highly related
high_r<-read.table("O:/ukbb-sleep/genetic/data.highly_relateds_app2393.txt",header = TRUE)
colnames(high_r)<-c("eid","eid2")
female_high<-merge(female_exclude_minimal,high_r,by="eid",all=TRUE)
female_exclude_high<-female_high[ which(is.na(female_high$eid2)),]

#phenotypic data
phenotype<-read.csv("O:/ukbb-sleep/phenotype/insomnia_outcome4.csv")
phenotype<-phenotype[c(1:3)]
colnames(phenotype)<-c("no","eid","sex_q")
female_final<-merge(phenotype,female_exclude_high,by="eid")
