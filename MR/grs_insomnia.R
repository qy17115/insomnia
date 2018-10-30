#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#input MR data
mr<-read.csv("O:/ukbb-sleep/phenotype/insomnia.csv")
summary(mr)

#grs~insomnia
mean(mr$grs)
sd(mr$grs)
insomnia_main1<-lm(mr$insomnia_main~.,data=mr[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
insomnia_sen1<-lm(mr$insomnia_sen~.,data=mr[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])

insomnia_main2<-glm(mr$insomnia_main~.,binomial(link = "logit"),data=mr[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
insomnia_sen2<-glm(mr$insomnia_sen~.,binomial(link = "logit"),data=mr[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])

summary(insomnia_main1)
summary(insomnia_sen1)
summary(insomnia_main2)
summary(insomnia_sen2)

#new grs~insomnia
#exclude pleiotrophic SNPs and then genereate a new GRS
mr$grs_new<-rowSums(mr[,c("rs10800992","rs7581704","rs113851554","rs62158206","rs6803184","rs2116290","rs13138995","rs13189678","rs11167642","rs1285875","rs4711416","rs1533992","rs12534945","rs150483923","rs1731951","rs876114","rs671985","rs17643634","rs118166957","rs7044885","rs1927898","rs7026534","rs77641763","rs544978","rs2406916","rs58475265","rs2286729","rs12310246","rs7974321","rs4499118","rs7337692","rs4981170","rs755837","rs12912299","rs715338","rs4887111","rs35084376","rs9931543","rs12927360","rs117037340","rs57314044","rs113092074")])
mean(mr$grs_new)
sd(mr$grs_new)
insomnia_main1_new<-lm(mr$insomnia_main~.,data=mr[,c("grs_new","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
insomnia_sen1_new<-lm(mr$insomnia_sen~.,data=mr[,c("grs_new","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])

insomnia_main2_new<-glm(mr$insomnia_main~.,binomial(link = "logit"),data=mr[,c("grs_new","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
insomnia_sen2_new<-glm(mr$insomnia_sen~.,binomial(link = "logit"),data=mr[,c("grs_new","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])

summary(insomnia_main1_new)
summary(insomnia_sen1_new)
summary(insomnia_main2_new)
summary(insomnia_sen2_new)

#creat a matrix for results
vars<-c("insomnia_main1","insomnia_sen1","insomnia_main2","insomnia_sen2","insomnia_main1_new","insomnia_sen1_new","insomnia_main2_new","insomnia_sen2_new")
col.names <- c("estimate","lci","uci","p")
covar <- matrix(, ncol=4, nrow=length(vars))
dimnames(covar) <- list(vars, col.names)

covar[1,1] <- summary(insomnia_main1)$coefficients[2,1]
covar[2,1] <- summary(insomnia_sen1)$coefficients[2,1]
covar[3,1] <- exp(summary(insomnia_main2)$coefficients[2,1])
covar[4,1] <- exp(summary(insomnia_sen2)$coefficients[2,1])
covar[5,1] <- summary(insomnia_main1_new)$coefficients[2,1]
covar[6,1] <- summary(insomnia_sen1_new)$coefficients[2,1]
covar[7,1] <- exp(summary(insomnia_main2_new)$coefficients[2,1])
covar[8,1] <- exp(summary(insomnia_sen2_new)$coefficients[2,1])

covar[1,2] <- summary(insomnia_main1)$coefficients[2,1]-1.96*summary(insomnia_main1)$coefficients[2,2]
covar[2,2] <- summary(insomnia_sen1)$coefficients[2,1]-1.96*summary(insomnia_sen1)$coefficients[2,2]
covar[3,2] <- exp(summary(insomnia_main2)$coefficients[2,1]-1.96*summary(insomnia_main2)$coefficients[2,2])
covar[4,2] <- exp(summary(insomnia_sen2)$coefficients[2,1]-1.96*summary(insomnia_sen2)$coefficients[2,2])
covar[5,2] <- summary(insomnia_main1_new)$coefficients[2,1]-1.96*summary(insomnia_main1_new)$coefficients[2,2]
covar[6,2] <- summary(insomnia_sen1_new)$coefficients[2,1]-1.96*summary(insomnia_sen1_new)$coefficients[2,2]
covar[7,2] <- exp(summary(insomnia_main2_new)$coefficients[2,1]-1.96*summary(insomnia_main2_new)$coefficients[2,2])
covar[8,2] <- exp(summary(insomnia_sen2_new)$coefficients[2,1]-1.96*summary(insomnia_sen2_new)$coefficients[2,2])

covar[1,3] <- summary(insomnia_main1)$coefficients[2,1]+1.96*summary(insomnia_main1)$coefficients[2,2]
covar[2,3] <- summary(insomnia_sen1)$coefficients[2,1]+1.96*summary(insomnia_sen1)$coefficients[2,2]
covar[3,3] <- exp(summary(insomnia_main2)$coefficients[2,1]+1.96*summary(insomnia_main2)$coefficients[2,2])
covar[4,3] <- exp(summary(insomnia_sen2)$coefficients[2,1]+1.96*summary(insomnia_sen2)$coefficients[2,2])
covar[5,3] <- summary(insomnia_main1_new)$coefficients[2,1]+1.96*summary(insomnia_main1_new)$coefficients[2,2]
covar[6,3] <- summary(insomnia_sen1_new)$coefficients[2,1]+1.96*summary(insomnia_sen1_new)$coefficients[2,2]
covar[7,3] <- exp(summary(insomnia_main2_new)$coefficients[2,1]+1.96*summary(insomnia_main2_new)$coefficients[2,2])
covar[8,3] <- exp(summary(insomnia_sen2_new)$coefficients[2,1]+1.96*summary(insomnia_sen2_new)$coefficients[2,2])

covar[1,4] <- summary(insomnia_main1)$coefficients[2,4]
covar[2,4] <- summary(insomnia_sen1)$coefficients[2,4]
covar[3,4] <- summary(insomnia_main2)$coefficients[2,4]
covar[4,4] <- summary(insomnia_sen2)$coefficients[2,4]
covar[5,4] <- summary(insomnia_main1_new)$coefficients[2,4]
covar[6,4] <- summary(insomnia_sen1_new)$coefficients[2,4]
covar[7,4] <- summary(insomnia_main2_new)$coefficients[2,4]
covar[8,4] <- summary(insomnia_sen2_new)$coefficients[2,4]


##SNP-specific
vars <- names(mr[c(2:72)])
col.names <- c("main (logOR)","main (SE)","main (P-val)"," sensitivity (logOR)","sensitivity (SE)","sensitivity (P-val)")
covar2 <- matrix(, ncol=6, nrow=length(vars))
dimnames(covar2) <- list(vars, col.names)

for(i in 1:length(vars)) {
  m1 <-glm(mr$insomnia_main~mr[[vars[i]]],binomial(link = "logit"),data=mr)
  m2 <-glm(mr$insomnia_sen~mr[[vars[i]]],binomial(link = "logit"),data=mr)
  covar2[i,1] <- summary(m1)$coefficients[2,1]
  covar2[i,2] <- summary(m1)$coefficients[2,2]
  covar2[i,3] <- summary(m1)$coefficients[2,4]
  covar2[i,4] <- summary(m2)$coefficients[2,1]
  covar2[i,5] <- summary(m2)$coefficients[2,2]
  covar2[i,6] <- summary(m2)$coefficients[2,4]
}        
write.csv(covar2,"C:/mini project 2/results/snp_insomnia.csv")
