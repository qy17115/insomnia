#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())


##########################################################################################from qctool method
#read in data
try<-read.table("O:/ukbb-sleep/genetic/carolina_methods/test1.dosage")####wide format, takes lots of time, same as data from python method
##########################################################################################from python method
#read in data
genetic_all<-read.table("O:/ukbb-sleep/genetic/python-method/insomnia57-dosage2.txt")

#reshape data from wide to long
require(reshape2)
genetic_all_long<-dcast(melt(as.matrix(genetic_all)), Var2~paste0('r', Var1), value.var='value')
table(genetic_all_long$r1)


#combine .sample file (the ID colomun) with the long format genetic data
id<-read.table("O:/ukbb-sleep/genetic/python-method/userIds_app2393.txt")
genetic_all_id<-cbind(genetic_all_long,id)
summary(genetic_all_id)
write.csv(genetic_all_long,"O:/ukbb-sleep/genetic/python-method/insomnia57_use.csv")


