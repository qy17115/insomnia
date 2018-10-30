#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#input data
confounder<-read.csv("O:/ukbb-sleep/phenotype/insomnia.csv")
summary(confounder)
hist(confounder$grs,breaks=40)

#exclude pleiotrophic SNPs and then genereate a new GRS
confounder$grs_new<-rowSums(confounder[,c("rs10800992","rs7581704","rs113851554","rs62158206","rs6803184","rs2116290","rs13138995","rs13189678","rs11167642","rs1285875","rs4711416","rs1533992","rs12534945","rs150483923","rs1731951","rs876114","rs671985","rs17643634","rs118166957","rs7044885","rs1927898","rs7026534","rs77641763","rs544978","rs2406916","rs58475265","rs2286729","rs12310246","rs7974321","rs4499118","rs7337692","rs4981170","rs755837","rs12912299","rs715338","rs4887111","rs35084376","rs9931543","rs12927360","rs117037340","rs57314044","rs113092074")])
summary(confounder$grs_new)
hist(confounder$grs_new,breaks=40)

############################################################################################################
############################################################################################################
#GRS~confounder
#height, bmi, age at 1st live birth
height<-lm(confounder$height~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(height)
bmi<-lm(confounder$bmi~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(bmi)
agebirth<-lm(confounder$age_1stbirth~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(agebirth)
##SNP-specific
vars <- names(confounder[c(2:72)])
col.names <- c("height (beta)","height (SE)","height (P-val)","bmi (beta)","bmi (SE)","bmi (P-val)","agebirth (beta)","agebirth (SE)","agebirth (P-val)")
covar <- matrix(, ncol=9, nrow=length(vars))
dimnames(covar) <- list(vars, col.names)

for(i in 1:length(vars)) {
  m1 <-lm(confounder$height ~ confounder[[vars[i]]], data=confounder)
  m2 <-lm(confounder$bmi ~ confounder[[vars[i]]], data=confounder)
  m3 <-lm(confounder$age_1stbirth ~ confounder[[vars[i]]], data=confounder)
  covar[i,1] <- summary(m1)$coefficients[2,1]
  covar[i,2] <- summary(m1)$coefficients[2,2]
  covar[i,3] <- summary(m1)$coefficients[2,4]
  covar[i,4] <- summary(m2)$coefficients[2,1]
  covar[i,5] <- summary(m2)$coefficients[2,2]
  covar[i,6] <- summary(m2)$coefficients[2,4]
  covar[i,7] <- summary(m3)$coefficients[2,1]
  covar[i,8] <- summary(m3)$coefficients[2,2]
  covar[i,9] <- summary(m3)$coefficients[2,4]
}        

#edu(univeristy=3), smoke(current=2),alcohol(recode daily=6)
confounder$alcohol<-7-confounder$alcohol
table(confounder$alcohol,exclude=NULL)

edu<-lm(confounder$edu~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(edu)
smoke<-lm(confounder$smoke~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(smoke)
alcohol<-lm(confounder$alcohol~.,data=confounder[,c("grs","array","pc1","pc2","pc3","pc4","pc5","pc6","pc7","pc8","pc9","pc10")])
summary(alcohol)

##SNP-specific
vars <- names(confounder[c(2:72)])
col.names <- c("edu (beta)","edu (SE)","edu (P-val)","smoke (beta)","smoke (SE)","smoke (P-val)","alcohol (beta)","alcohol (SE)","alcohol (P-val)")
covar2 <- matrix(, ncol=9, nrow=length(vars))
dimnames(covar2) <- list(vars, col.names)

for(i in 1:length(vars)) {
  m1 <-lm(confounder$edu ~ confounder[[vars[i]]], data=confounder)
  m2 <-lm(confounder$smoke ~ confounder[[vars[i]]], data=confounder)
  m3 <-lm(confounder$alcohol ~ confounder[[vars[i]]], data=confounder)
  covar2[i,1] <- summary(m1)$coefficients[2,1]
  covar2[i,2] <- summary(m1)$coefficients[2,2]
  covar2[i,3] <- summary(m1)$coefficients[2,4]
  covar2[i,4] <- summary(m2)$coefficients[2,1]
  covar2[i,5] <- summary(m2)$coefficients[2,2]
  covar2[i,6] <- summary(m2)$coefficients[2,4]
  covar2[i,7] <- summary(m3)$coefficients[2,1]
  covar2[i,8] <- summary(m3)$coefficients[2,2]
  covar2[i,9] <- summary(m3)$coefficients[2,4]
}        

write.csv(covar,"C:/mini project 2/results/snp_confounder1.csv")
write.csv(covar2,"C:/mini project 2/results/snp_confounder2.csv")
