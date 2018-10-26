#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#package
require(readstata13)

#merge data
genotype<-read.csv("O:/ukbb-sleep/genetic/iv.csv")
summary(genotype)
phenotype<-read.dta13("O:/ukbb-sleep/phenotype/phenotype20180929.dta")
summary(phenotype)
insomnia<-merge(genotype,phenotype,by="eid")
summary(insomnia)


#define cases/controls
#pregnancy loss
table(insomnia$pregloss,exclude=NULL)
insomnia$pregloss[insomnia$pregloss<0]<-NA
table(insomnia$pregloss,exclude=NULL)

#main analysis
#stillbirth, 0=control, 1=case
table(insomnia$nstillbirth,exclude=NULL)
insomnia$stillbirth[insomnia$pregloss==0]<-0
insomnia$stillbirth[insomnia$nstillbirth>0]<-1
table(insomnia$stillbirth,exclude=NULL)
#missage, 0=control, 1=case
table(insomnia$nmiscarriage,exclude=NULL)
insomnia$miscarriage[insomnia$pregloss==0]<-0
insomnia$miscarriage[insomnia$nmiscarriage>0]<-1
table(insomnia$miscarriage,exclude=NULL)
#gestational diabetes
table(insomnia$diabetes,exclude=NULL)
table(insomnia$gdm,exclude=NULL)
insomnia$gdm_define[insomnia$diabetes==0]<-0
insomnia$gdm_define[insomnia$gdm==1]<-1
table(insomnia$gdm_define,exclude=NULL)
#postnatal depression
table(insomnia$depress1,exclude=NULL)
table(insomnia$depress2,exclude=NULL)
table(insomnia$depress3,exclude=NULL)
insomnia$depress[insomnia$depress1==0 & insomnia$depress2==0]<-0
insomnia$depress[insomnia$depress3==1]<-1
table(insomnia$depress,exclude=NULL)

#sensitivity analysis
#stillbirth, 0=control, 1=case
table(insomnia$nstillbirth,exclude=NULL)
insomnia$stillbirth_s[insomnia$pregloss==0]<-0
insomnia$stillbirth_s[insomnia$nstillbirth==0]<-0 #excluded by the main analysis
insomnia$stillbirth_s[insomnia$nstillbirth>0]<-1
table(insomnia$stillbirth_s,exclude=NULL)
#missage, 0=control, 1=case
table(insomnia$nmiscarriage,exclude=NULL)
insomnia$miscarriage_s[insomnia$pregloss==0]<-0
insomnia$miscarriage_s[insomnia$nmiscarriage==0]<-0 #excluded by the main analysis
insomnia$miscarriage_s[insomnia$nmiscarriage>0]<-1
table(insomnia$miscarriage_s,exclude=NULL)
#gestational diabetes
table(insomnia$diabetes,exclude=NULL)
table(insomnia$gdm,exclude=NULL)
insomnia$gdm_define_s[insomnia$diabetes==0]<-0
insomnia$gdm_define_s[insomnia$gdm==0]<-0  #excluded by the main analysis
insomnia$gdm_define_s[insomnia$gdm==1]<-1
table(insomnia$gdm_define_s,exclude=NULL)
#postnatal depression
table(insomnia$depress1,exclude=NULL)
table(insomnia$depress2,exclude=NULL)
table(insomnia$depress3,exclude=NULL)
insomnia$depress_s[insomnia$depress1==0 & insomnia$depress2==0]<-0
insomnia$depress_s[insomnia$depress3==0]<-0 #excluded by the main analysis
insomnia$depress_s[insomnia$depress3==1]<-1
table(insomnia$depress_s,exclude=NULL)

#offspring birthweight (questionnaire)
summary(insomnia$bwchild)
hist(insomnia$bwchild)


#insomnia 
#main analysis: usually=1, sometimes=0, rarely/never=0
#sensitivity analysis: usually=1, sometimes=1, rarely/never=0
table(insomnia$insomnia,exclude=NULL)
insomnia$insomnia_main[insomnia$insomnia==1]<-0
insomnia$insomnia_main[insomnia$insomnia==2]<-0
insomnia$insomnia_main[insomnia$insomnia==3]<-1
table(insomnia$insomnia_main,exclude=NULL)

insomnia$insomnia_sen[insomnia$insomnia==1]<-0
insomnia$insomnia_sen[insomnia$insomnia==2]<-1
insomnia$insomnia_sen[insomnia$insomnia==3]<-1
table(insomnia$insomnia_sen,exclude=NULL)


#potential confounders
#age at first live birth
table(insomnia$age_1stbirth,exclude=NULL)
insomnia$age_1stbirth[insomnia$age_1stbirth<0]<-NA

#education attainment
table(insomnia$edu1,exclude=NULL)
table(insomnia$edu2,exclude=NULL)
table(insomnia$edu3,exclude=NULL)
table(insomnia$edu4,exclude=NULL)
table(insomnia$edu5,exclude=NULL)
table(insomnia$edu6,exclude=NULL)

insomnia$edu[insomnia$edu1==-7]<-1
insomnia$edu[insomnia$edu1==3|insomnia$edu2==3|insomnia$edu3==3]<-1
insomnia$edu[insomnia$edu1==4|insomnia$edu2==4|insomnia$edu3==4|insomnia$edu4==4]<-1
insomnia$edu[insomnia$edu1==5|insomnia$edu2==5|insomnia$edu3==5|insomnia$edu4==5|insomnia$edu5==5]<-1
insomnia$edu[insomnia$edu1==6|insomnia$edu2==6|insomnia$edu3==6|insomnia$edu4==6|insomnia$edu5==6|insomnia$edu6==6]<-2
insomnia$edu[insomnia$edu1==2|insomnia$edu2==2]<-2
insomnia$edu[insomnia$edu1==1]<-3
table(insomnia$edu,exclude=NULL)

#smoking
table(insomnia$smoke,exclude=NULL)
insomnia$smoke[insomnia$smoke<0]<-NA

#alcohol intake
table(insomnia$alcohol,exclude=NULL)
insomnia$alcohol[insomnia$alcohol<0]<-NA

#height
summary(insomnia$height)

#BMI
summary(insomnia$bmi)

#save dataset for analysis
write.csv(insomnia,"O:/ukbb-sleep/phenotype/insomnia.csv",row.names = FALSE)


