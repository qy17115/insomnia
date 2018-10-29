#use correct path
.libPaths("C:/R/Library")

# Clear the work environment
rm(list = ls())

#observational study
#input data
observ<-read.csv("O:/ukbb-sleep/phenotype/insomnia.csv")
summary(observ)

#chi-square test
#pregnancy loss
pre_loss1<-table(observ$pregloss,observ$insomnia_main)
pre_loss1
chisq.test(pre_loss1)

pre_loss2<-table(observ$pregloss,observ$insomnia_sen)
pre_loss2
chisq.test(pre_loss2)

#stillbirth
stillbirth1<-table(observ$stillbirth,observ$insomnia_main)
stillbirth1
chisq.test(stillbirth1)

stillbirth2<-table(observ$stillbirth,observ$insomnia_sen)
stillbirth2
chisq.test(stillbirth2)

stillbirth3<-table(observ$stillbirth_s,observ$insomnia_main)
stillbirth3
chisq.test(stillbirth3)

stillbirth4<-table(observ$stillbirth_s,observ$insomnia_sen)
stillbirth4
chisq.test(stillbirth4)

#miscarriage
miscarriage1<-table(observ$miscarriage,observ$insomnia_main)
miscarriage1
chisq.test(miscarriage1)

miscarriage2<-table(observ$miscarriage,observ$insomnia_sen)
miscarriage2
chisq.test(miscarriage2)

miscarriage3<-table(observ$miscarriage_s,observ$insomnia_main)
miscarriage3
chisq.test(miscarriage3)

miscarriage4<-table(observ$miscarriage_s,observ$insomnia_sen)
miscarriage4
chisq.test(miscarriage4)

#GDM
gdm1<-table(observ$gdm_define,observ$insomnia_main)
gdm1
chisq.test(gdm1)

gdm2<-table(observ$gdm_define,observ$insomnia_sen)
gdm2
chisq.test(gdm2)

gdm3<-table(observ$gdm_define_s,observ$insomnia_main)
gdm3
chisq.test(gdm3)

gdm4<-table(observ$gdm_define_s,observ$insomnia_sen)
gdm4
chisq.test(gdm4)

#depression
depress1<-table(observ$depress,observ$insomnia_main)
depress1
chisq.test(depress1)

depress2<-table(observ$depress,observ$insomnia_sen)
depress2
chisq.test(depress2)

depress3<-table(observ$depress_s,observ$insomnia_main)
depress3
chisq.test(depress3)

depress4<-table(observ$depress_s,observ$insomnia_sen)
depress4
chisq.test(depress4)

#t-test
#birthweight
observ$insomnia_main<-as.factor(observ$insomnia_main)
observ$insomnia_sen<-as.factor(observ$insomnia_sen)

aggregate(observ$bwchild,by=list(observ$insomnia_main),FUN = mean,na.rm=TRUE)
aggregate(observ$bwchild,by=list(observ$insomnia_main),FUN = sd,na.rm=TRUE)
aggregate(observ$bwchild,by=list(observ$insomnia_sen),FUN = mean,na.rm=TRUE)
aggregate(observ$bwchild,by=list(observ$insomnia_sen),FUN = sd,na.rm=TRUE)

t.test(observ$bwchild~observ$insomnia_main)
t.test(observ$bwchild~observ$insomnia_sen)
