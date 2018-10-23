*Use Ana's code
****************************************************************
************ UK BIOBANK DATASET - APPLICATION 23938 ************
****************************************************************
** Updated on 27.09.2018
** Note: it might take a long time to load the files and merge the data!

clear all
cd "\\ads.bris.ac.uk\filestore\BRMS\Studies\Reproductive_Perinatal_Health\UK Biobank\Scripts"
set maxvar 7000

import delimited "M:\data\ukbiobank\phenotypic\applications\23938\released\2018-09-27\data\withdrawal\w23938_20180503.csv"
rename v1 n_eid
gen withdrawal=1
tempfile withdrawal
save `withdrawal'

do ukb23485_20180927.do
tempfile new_release
save `new_release'

do "\\ads.bris.ac.uk\filestore\BRMS\Studies\Reproductive_Perinatal_Health\UK Biobank\Scripts\data_10384_20180406.do"
merge 1:1 n_eid using `new_release'
drop _merge
merge 1:1 n_eid using `withdrawal'
drop if withdrawal==1
drop _merge withdrawal

*My own code
********************************************************************************
******************** Phenotypes for insomnia project ***************************
********************************************************************************
keep n_eid n_50_0_0 n_1160_0_0 n_1170_0_0 n_1180_0_0 n_1190_0_0 n_1200_0_0 n_1210_0_0 n_1220_0_0 n_1558_0_0 n_2443_0_0 n_2734_0_0 n_2744_0_0 n_2754_0_0 ///
n_2774_0_0 n_3829_0_0 n_3839_0_0 n_4041_0_0 n_6138_0_0 n_6138_0_1 n_6138_0_2 n_6138_0_3 ///
n_6138_0_4 n_6138_0_5 n_20116_0_0 n_20441_0_0 n_20445_0_0 n_20446_0_0 n_21000_0_0 n_21001_0_0 n_21003_0_0  
 
rename n_eid eid
*Covariates
** Age
rename n_21003_0_0 age
** Ethnicity
rename n_21000_0_0 ethnic
** Maternal age at first live birth
rename n_2734_0_0 nbirths
rename n_2754_0_0 age_1stbirth
** Education
rename n_6138_0_0 edu1
rename n_6138_0_1 edu2
rename n_6138_0_2 edu3
rename n_6138_0_3 edu4
rename n_6138_0_4 edu5
rename n_6138_0_5 edu6
** Smoking status
rename n_20116_0_0 smoke
** Alcohol consumption frequency
rename n_1558_0_0 alcohol
** BMI (anthropometry)
rename n_21001_0_0 bmi
** Height (standing height - cm)
rename n_50_0_0 height


*Exposure
** insomnia
rename n_1200_0_0 insomnia
** sleep duration
rename n_1160_0_0 duration
** getting up in morning
rename n_1170_0_0 morning
** chronotype
rename n_1180_0_0 chronotype
** nap
rename n_1190_0_0 nap
** snoring
rename n_1210_0_0 snorning
** daytime sleeping
rename n_1220_0_0 daysleep


*Outcome
** Birth weight of first child
rename n_2744_0_0 bwchild
replace bwchild = . if bwchild<0
replace bwchild = bwchild*0.45359237*1000 // convert pounds to g
** Pregnancy loss (stillbirth, spontaneous miscarriage or termination)
rename n_2774_0_0 pregloss
** Number of stillbirths 
rename n_3829_0_0 nstillbirth
** Number of miscarriages 
rename n_3839_0_0 nmiscarriage
** Gestational diabetes 
rename n_2443_0_0 diabetes
rename n_4041_0_0 gdm
** Depression, childbirth
rename n_20441_0_0 depress1
rename n_20446_0_0 depress2
rename n_20445_0_0 depress3


*drop value labels to make values numeric in R
label drop m_0090
label drop m_0503
label drop m_0514
label drop m_1001
label drop m_100291
label drop m_100305
label drop m_100341
label drop m_100342
label drop m_100343
label drop m_100345
label drop m_100346
label drop m_100349
label drop m_100402
label drop m_100584
label drop m_100585
label drop m_100586
label drop m_100617

save "O:\ukbb-sleep\phenotype\phenotype20180929.dta", replace
