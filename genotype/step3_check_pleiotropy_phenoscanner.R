#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())


install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)

snp<-read.csv("C:/mini project 2/results/insomnia71 in UKB.csv")
res <- phenoscanner(snpquery=snp$rsid,pvalue=5e-08)
head(res$results)
res$snps
results<-res$results
write.csv(results,"C:/mini project 2/results/phenoscanner.csv")
