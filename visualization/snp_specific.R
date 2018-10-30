#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#input data
insomnia<-read.csv("C:/mini project 2/results/snp_insomnia.csv")
confounder1<-read.csv("C:/mini project 2/results/snp_confounder1.csv")
confounder2<-read.csv("C:/mini project 2/results/snp_confounder2.csv")

head(insomnia)
head(confounder1)
head(confounder2)

figure<-merge(insomnia,confounder1, by="X")
figure<-merge(figure,confounder2,by="X")
#scatter plot
#height
plot(figure$main..logOR.,figure$height..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-height, beta",pch=20)
abline(h=0, col="red")
#bmi
plot(figure$main..logOR.,figure$bmi..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-bmi, beta",pch=20)
abline(h=0, col="red")
#age at the first live birth
plot(figure$main..logOR.,figure$agebirth..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-age at first live birth, beta",pch=20)
abline(h=0, col="red")
#edu
plot(figure$main..logOR.,figure$edu..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-education (university=highest), beta",pch=20)
abline(h=0, col="red")
#smoking
plot(figure$main..logOR.,figure$smoke..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-smoking (current=2,former=1), beta",pch=20)
abline(h=0, col="red")
#alcohol
plot(figure$main..logOR.,figure$alcohol..beta.,xlab="SNP-insomnia,logOR", ylab="SNP-alcohol (daily=highest), beta",pch=20)
abline(h=0, col="red")
