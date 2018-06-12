*variable list is here 
*\\ads.bris.ac.uk\filestore\BRMS\Studies\Reproductive_Perinatal_Health\UK Biobank\Variable_definitions.xlsx
clear all
cd "M:\data\ukbiobank\phenotypic\applications\23938\released\2017-09-26\data\derived\formats\stata"
infile using "data.10384.dct", using("data.10384.raw")
keep n_eid n_21003_0_0 s_53_0_0 n_21000_0_0 n_6138_0_0 n_6138_0_1 n_6138_0_2 n_6138_0_3 n_6138_0_4 n_6138_0_5 ///
n_738_0_0 n_189_0_0 n_20022_0_0 n_3140_0_0 n_20116_0_0 n_1558_0_0 n_2774_0_0 n_2774_1_0 n_2774_2_0 ///
n_3829_0_0 n_3829_1_0 n_3829_2_0 n_3839_0_0 n_3839_1_0 n_3839_2_0 n_3849_0_0 n_3849_1_0 n_3849_2_0 ///
n_41226_0_0 n_41226_0_1 n_41226_0_2 n_2744_0_0 n_2744_1_0 n_2744_2_0 n_2734_0_0 n_2754_0_0 n_2764_0_0 n_3872_0_0 ///
n_4041_0_0 n_4041_1_0 n_4041_2_0 n_2443_0_0 n_2443_1_0 n_2443_2_0 n_41222_0_0 n_41222_0_1 n_41222_0_2 n_41222_0_3 n_41222_0_4 n_41222_0_5 ///
n_4080_0_0 n_4080_0_1 n_4079_0_0 n_4079_0_1 n_93_0_0 n_93_0_1 n_94_0_0 n_94_0_1 n_95_0_0 n_95_0_1 n_102_0_0 n_102_0_1 ///
n_2443_0_0 n_2443_1_0 n_2443_2_0 n_2453_0_0 n_2463_0_0 n_3005_0_0 n_100021_0_0 n_100021_1_0 n_100021_2_0 n_100021_3_0 n_100021_4_0 ///
n_6155_0_0 n_6155_0_1 n_6155_0_2 n_6155_0_3 n_6155_0_4 n_6155_0_5 n_6155_0_6 ///
n_6179_0_0 n_6179_0_1 n_6179_0_2 n_6179_0_3 n_6179_0_4 n_6179_0_5 n_21001_0_0 n_23104_0_0 n_21002_0_0 n_50_0_0 ///
n_48_0_0 n_49_0_0 n_23099_0_0 n_2267_0_0 n_52_0_0 n_55_0_0 n_1050_0_0 n_1060_0_0 n_1717_0_0 n_1727_0_0 n_74_0_0

*run following code from Ana, change variable names if necessary
** Age
clonevar age = n_21003_0_0
egen agegr = cut(age), at(35,45,50,55,60,65,75) label
lab var agegr "age in 6 groups"

** Date at assessment centre
gen double ts_53_0_0 = date(s_53_0_0,"DMY")
format ts_53_0_0 %td
label variable ts_53_0_0 "Date of attending assessment centre"
clonevar date = ts_53_0_0

** Ethnicity
label define m_1001 4001 "Caribbean" 3001 "Indian" 1 "White" 2001 "White and Black Caribbean" 1001 "British" 3002 "Pakistani" 2 "Mixed" 4002 "African" 1002 "Irish" 2002 "White and Black African" 3003 "Bangladeshi" 3 "Asian or Asian British" 4003 "Any other Black background" 1003 "Any other white background" 2003 "White and Asian" 3004 "Any other Asian background" 4 "Black or Black British" 2004 "Any other mixed background" 5 "Chinese" 6 "Other ethnic group" -1 "Do not know" -3 "Prefer not to answer"
label values n_21000_0_0 m_1001
*label values n_21000_1_0 m_1001
*label values n_21000_2_0 m_1001
clonevar ethnic = n_21000_0_0
*replace ethnic = n_21000_1_0 if ethnic==. | ethnic<0
*replace ethnic = n_21000_2_0 if ethnic==. | ethnic<0 // 27 observations added

** Education
label define m_100305 1 "College or University degree" 2 "A levels/AS levels or equivalent" 3 "O levels/GCSEs or equivalent" 4 "CSEs or equivalent" 5 "NVQ or HND or HNC or equivalent" 6 "Other professional qualifications eg: nursing, teaching" -7 "None of the above" -3 "Prefer not to answer"
label values n_6138_0_0 m_100305
label values n_6138_0_1 m_100305
label values n_6138_0_2 m_100305
label values n_6138_0_3 m_100305
label values n_6138_0_4 m_100305
label values n_6138_0_5 m_100305
*label values n_6138_1_0 m_100305
*label values n_6138_1_1 m_100305
*label values n_6138_1_2 m_100305
*label values n_6138_1_3 m_100305
*label values n_6138_1_4 m_100305
*label values n_6138_1_5 m_100305
*label values n_6138_2_0 m_100305
*label values n_6138_2_1 m_100305
*label values n_6138_2_2 m_100305
*label values n_6138_2_3 m_100305
*label values n_6138_2_4 m_100305
*label values n_6138_2_5 m_100305
*clonevar education = n_6138_0_0
*replace education = n_6138_1_0 if education==. | education<0
*replace education = n_6138_2_0 if education==. | education<0 // 401 observations added
*recode education (1=4) (2=3) (3=2) (4=2) (5=2) (6=2)
*lab def education 4"College/ university" 3"A level" 2"O level or CSEs or other" 1"none" 
*lab val education education

** Household income
label define m_100294 1 "Less than 18,000" 2 "18,000 to 30,999" 3 "31,000 to 51,999" 4 "52,000 to 100,000" 5 "Greater than 100,000" -1 "Do not know" -3 "Prefer not to answer"
label values n_738_0_0 m_100294
*label values n_738_1_0 m_100294
*label values n_738_2_0 m_100294
clonevar income = n_738_0_0
*replace income = n_738_1_0 if income==. | income<0
*replace income = n_738_2_0 if income==. | income<0 // 1,270 observations added
lab def income 1"<18,000" 2"18,000-30,999" 3"31,000-51,999" 4"52,000-100,000" 5">100,000"
lab val income income

** Deprivation index
format %22.18f n_189_0_0
clonevar dep_index = n_189_0_0

** Birth weight
format %18.15f n_20022_0_0
*format %18.15f n_20022_1_0
*format %18.15f n_20022_2_0
gen bw = n_20022_0_0
*replace bw = n_20022_1_0 if bw==.
*replace bw = n_20022_2_0 if bw==. // 1,715 observations added
lab var bw "Birth weight (kg)"

** Currently pregnant
label define m_100267 1 "Yes" 2 "Unsure" 0 "No"
label values n_3140_0_0 m_100267
*label values n_3140_1_0 m_100267
*label values n_3140_2_0 m_100267
clonevar pregnant = n_3140_0_0

** Smoking status
label define m_0090 2 "Current" 1 "Previous" -3 "Prefer not to answer" 0 "Never"
label values n_20116_0_0 m_0090
*label values n_20116_1_0 m_0090
*label values n_20116_2_0 m_0090
clonevar smoking = n_20116_0_0
*replace smoking = n_20116_1_0 if smoking==. | smoking<0
*replace smoking = n_20116_2_0 if smoking==. | smoking<0 // 58 observations added

** Alcohol consumption frequency
label define m_100402 1 "Daily or almost daily" 2 "Three or four times a week" 3 "Once or twice a week" 4 "One to three times a month" 5 "Special occasions only" 6 "Never" -3 "Prefer not to answer"
label values n_1558_0_0 m_100402
*label values n_1558_1_0 m_100402
*label values n_1558_2_0 m_100402
clonevar alcohol = n_1558_0_0
*replace alcohol = n_1558_1_0 if alcohol==. | alcohol<0
*replace alcohol = n_1558_2_0 if alcohol==. | alcohol<0 // 9 observations added

** Adversities related to birth (stillbirth, spontaneous miscarriage or termination)
label define m_100349 1 "Yes" 0 "No" -1 "Do not know" -3 "Prefer not to answer"
label values n_2774_0_0 m_100349
label values n_2774_1_0 m_100349
label values n_2774_2_0 m_100349
clonevar adv_birth = n_2774_0_0
*replace adv_birth = n_2774_1_0 if adv_birth==. | adv_birth<0
*replace adv_birth = n_2774_2_0 if adv_birth==. | adv_birth<0 // 176 observations added
clonevar adv_birth1 = n_2774_1_0
clonevar adv_birth2 = n_2774_2_0

** Number of stillbirths 
label define m_100291 -1 "Do not know" -3 "Prefer not to answer"
label values n_3829_0_0 m_100291
label values n_3829_1_0 m_100291
label values n_3829_2_0 m_100291
clonevar nstillbirth = n_3829_0_0 
*replace nstillbirth = n_3829_1_0 if nstillbirth==. | nstillbirth<0
*replace nstillbirth = n_3829_2_0 if nstillbirth==. | nstillbirth<0 // added 319 observations
replace nstillbirth = 0 if adv_birth==0 & nstillbirth==.

clonevar nstillbirth1 = n_3829_1_0
replace nstillbirth1 = 0 if adv_birth1==0 & nstillbirth1==.

clonevar nstillbirth2 = n_3829_2_0
replace nstillbirth2 = 0 if adv_birth2==0 & nstillbirth2==.  

** Stillbirth
gen stillbirth = 0 if nstillbirth==0
replace stillbirth=1 if nstillbirth>=1 & nstillbirth<.
lab var stillbirth "ever had stillbirth"

gen stillbirth1 = 0 if nstillbirth1==0
replace stillbirth1=1 if nstillbirth1>=1 & nstillbirth1<.
lab var stillbirth1 "ever had stillbirth follow-up1"

gen stillbirth2 = 0 if nstillbirth2==0
replace stillbirth2=1 if nstillbirth2>=1 & nstillbirth2<.
lab var stillbirth2 "ever had stillbirth follow-up2"

** Number of miscarriages 
label values n_3839_0_0 m_100291
label values n_3839_1_0 m_100291
label values n_3839_2_0 m_100291
clonevar nmiscarriage = n_3839_0_0
*replace nmiscarriage = n_3839_1_0 if nmiscarriage==. | nmiscarriage<0
*replace nmiscarriage = n_3839_2_0 if nmiscarriage==. | nmiscarriage<0 // 328 observations added
replace nmiscarriage=0 if adv_birth==0 & nmiscarriage==. 

clonevar nmiscarriage1 = n_3839_1_0
replace nmiscarriage1=0 if adv_birth1==0 & nmiscarriage1==.

clonevar nmiscarriage2 = n_3839_2_0
replace nmiscarriage2=0 if adv_birth2==0 & nmiscarriage2==. 

** Miscarriage
gen miscarriage = 0 if nmiscarriage==0
replace miscarriage=1 if nmiscarriage>=1 & nmiscarriage<.
lab var miscarriage "ever had miscarriage"

gen miscarriage1 = 0 if nmiscarriage1==0
replace miscarriage1=1 if nmiscarriage1>=1 & nmiscarriage1<.
lab var miscarriage1 "ever had miscarriage follow-up1"

gen miscarriage2 = 0 if nmiscarriage2==0
replace miscarriage2=1 if nmiscarriage2>=1 & nmiscarriage2<.
lab var miscarriage2 "ever had miscarriage follow-up2"

** Number of terminations 
label values n_3849_0_0 m_100291
label values n_3849_1_0 m_100291
label values n_3849_2_0 m_100291
clonevar ntermination = n_3849_0_0
*replace ntermination = n_3849_1_0 if ntermination==. | ntermination<0
*replace ntermination = n_3849_2_0 if ntermination==. | ntermination<0 // 338 observations added
replace ntermination=0 if adv_birth==0 & ntermination==.

clonevar ntermination1 = n_3849_1_0
replace ntermination1=0 if adv_birth1==0 & ntermination1==.

clonevar ntermination2 = n_3849_2_0
replace ntermination2=0 if adv_birth2==0 & ntermination2==.

** Terminations
gen termination = 0 if ntermination==0
replace termination=1 if ntermination>=1 & ntermination<.
lab var termination "ever had termination"

gen termination1 = 0 if ntermination1==0
replace termination1=1 if ntermination1>=1 & ntermination1<.
lab var termination1 "ever had termination follow-up1"

gen termination2 = 0 if ntermination2==0
replace termination2=1 if ntermination2>=1 & ntermination2<.
lab var termination2 "ever had termination follow-up2"

** Sex of baby
label define m_0224 9 "Not specified" 3 "Indeterminate" 0 "Not known" 2 "Female" 1 "Male"
destring n_41226_0_0,replace
label values n_41226_0_0 m_0224
label values n_41226_0_1 m_0224
label values n_41226_0_2 m_0224
clonevar sex_baby = n_41226_0_0 
recode sex_baby (0=.) (3=.) (9=.)

clonevar sex_baby1 = n_41226_0_1 
recode sex_baby1 (0=.) (3=.) (9=.)

clonevar sex_baby2 = n_41226_0_2 
recode sex_baby2 (0=.) (3=.) (9=.)
** Birth weight of first child
label define m_100585 -1 "Do not know" -2 "Only had twins" -3 "Prefer not to answer"
label values n_2744_0_0 m_100585
label values n_2744_1_0 m_100585
label values n_2744_2_0 m_100585
gen bwchild = n_2744_0_0
*replace bwchild = n_2744_1_0 if bwchild==.| bwchild<0
*replace bwchild = n_2744_2_0 if bwchild==.| bwchild<0 // 105 observations added
replace bwchild=. if bwchild<0
replace bwchild = bwchild*0.45359237
lab var bwchild "Birth weight 1st child (kg)"

gen bwchild1 = n_2744_1_0
replace bwchild1=. if bwchild1<0
replace bwchild1 = bwchild1*0.45359237
lab var bwchild1 "Birth weight 1st child (kg) follow-up1"

gen bwchild2 = n_2744_2_0
replace bwchild2=. if bwchild2<0
replace bwchild2 = bwchild2*0.45359237
lab var bwchild2 "Birth weight 1st child (kg) follow-up2"

** Number of live births
label define m_100584 -3 "Prefer not to answer"
label values n_2734_0_0 m_100584
*label values n_2734_1_0 m_100584
*label values n_2734_2_0 m_100584
clonevar nbirths = n_2734_0_0
*replace nbirths = n_2734_1_0 if nbirths==. | nbirths<0
*replace nbirths = n_2734_2_0 if nbirths==. | nbirths<0 // 10 observations added

** Age at first and last live birth
label define m_100586 -4 "Do not remember" -3 "Prefer not to answer"
label values n_2754_0_0 m_100586
*label values n_2754_1_0 m_100586
*label values n_2754_2_0 m_100586
clonevar age_1stbirth = n_2754_0_0
*replace age_1stbirth = n_2754_1_0 if age_1stbirth==. | age_1stbirth<0
*replace age_1stbirth = n_2754_2_0 if age_1stbirth==. | age_1stbirth<0 // 34 observations added

label values n_2764_0_0 m_100586
*label values n_2764_1_0 m_100586
*label values n_2764_2_0 m_100586
clonevar age_lastbirth = n_2764_0_0
*replace age_lastbirth = n_2764_1_0 if age_lastbirth==. | age_lastbirth<0
*replace age_lastbirth = n_2764_2_0 if age_lastbirth==. | age_lastbirth<0 // 40 observations added

** Age of primiparous woman at birth of child
label values n_3872_0_0 m_100586
*label values n_3872_1_0 m_100586
*label values n_3872_2_0 m_100586
clonevar age_child = n_3872_0_0
*replace age_child = n_3872_1_0 if age_child<0 | age_child==.
*replace age_child = n_3872_2_0 if age_child<0 | age_child==. // 26 observations added


** Diabetes
label values n_2443_0_0 m_100349
label values n_2443_1_0 m_100349
label values n_2443_2_0 m_100349
clonevar dm = n_2443_0_0
*replace dm = n_2443_1_0 if dm==. | dm<0
*replace dm = n_2443_2_0 if dm==. | dm<0 // 22 observations added
clonevar dm1 = n_2443_1_0
clonevar dm2 = n_2443_2_0

** Gestational diabetes 
label define m_100617 1 "Yes" 0 "No" -2 "Not applicable" -1 "Do not know" -3 "Prefer not to answer"
label values n_4041_0_0 m_100617
label values n_4041_1_0 m_100617
label values n_4041_2_0 m_100617
gen gest_dm = 0 if dm==0 | dm==1
replace gest_dm=1 if n_4041_0_0==1
lab var gest_dm "gestational diabetes"

gen gest_dm1 = 0 if dm1==0 | dm1==1
replace gest_dm1=1 if n_4041_1_0==1
lab var gest_dm1 "gestational diabetes follow-up1"

gen gest_dm2 = 0 if dm2==0 | dm2==1
replace gest_dm2=1 if n_4041_2_0==1
lab var gest_dm2 "gestational diabetes follow-up2"

** Natural delivery
label define m_0220 9 "Not known" 4 "Medical induction" 1 "Spontaneous" 3 "Surgical induction by amniotomy" 8 "Not applicable" 2 "Caesarean section" 5 "Combination of surgical and medical induction"
label values n_41222_0_0 m_0220
label values n_41222_0_1 m_0220
label values n_41222_0_2 m_0220
label values n_41222_0_3 m_0220
label values n_41222_0_4 m_0220
label values n_41222_0_5 m_0220
gen natural = 0 if n_41222_0_0!=. & n_41222_0_0!=9
replace natural = 1 if n_41222_0_0==1
lab var natural "natural or spontaneous delivery"

gen natural1 = 0 if n_41222_0_1!=. & n_41222_0_1!=9
replace natural1 = 1 if n_41222_0_1==1
lab var natural1 "natural or spontaneous delivery 1"

gen natural2 = 0 if n_41222_0_2!=. & n_41222_0_2!=9
replace natural2 = 1 if n_41222_0_2==1
lab var natural2 "natural or spontaneous delivery 2"

gen natural3 = 0 if n_41222_0_3!=. & n_41222_0_3!=9
replace natural3 = 1 if n_41222_0_3==1
lab var natural3 "natural or spontaneous delivery 3"

gen natural4 = 0 if n_41222_0_4!=. & n_41222_0_4!=9
replace natural4 = 1 if n_41222_0_4==1
lab var natural4 "natural or spontaneous delivery 4"

gen natural5 = 0 if n_41222_0_5!=. & n_41222_0_5!=9
replace natural5 = 1 if n_41222_0_5==1
lab var natural5 "natural or spontaneous delivery 5"

** Cesarean section delivery
gen csection = 0 if n_41222_0_0!=. & n_41222_0_0!=9
replace csection = 1 if n_41222_0_0==2 
lab var csection "Ceaserean section delivery"

** Medical or surgical induction of delivery
gen induction = 0 if n_41222_0_0!=. & n_41222_0_0!=9
replace induction = 1 if n_41222_0_0==3 | n_41222_0_0==4 | n_41222_0_0==5 
lab var induction "medical or surgical induction"

** Systolic blood pressure (automated measured used, and manual if automated could not be used)
egen systolic = rowmean (n_4080_0_0 n_4080_0_1)
egen systolic2 = rowmean (n_93_0_0 n_93_0_1)
replace systolic = systolic2 if systolic==. // 15,777 observations added
drop systolic2
lab var systolic "systolic blood pressure"

** Diastolic blood pressure
egen diastolic = rowmean (n_4079_0_0 n_4079_0_1)
egen diastolic2 = rowmean (n_94_0_0 n_94_0_1) // 15,776 observations added
replace diastolic = diastolic2 if diastolic==.
drop diastolic2
lab var diastolic "diastolic blood pressure"

** Pulse rate
egen pulse = rowmean (n_102_0_0 n_102_0_1)
egen pulse2 = rowmean (n_95_0_0 n_95_0_1) // 15,776 observations added
replace pulse = pulse2 if pulse==.
drop pulse2
lab var pulse "pulse rate"

** Cancer
label define m_100603 1 "Yes - you will be asked about this later by an interviewer" 0 "No" -1 "Do not know" -3 "Prefer not to answer"
label values n_2453_0_0 m_100603
*label values n_2453_1_0 m_100603
*label values n_2453_2_0 m_100603
clonevar cancer = n_2453_0_0
*replace cancer = n_2453_1_0 if cancer==. | cancer<0
*replace cancer = n_2453_2_0 if cancer==. | cancer<0 // 67 observations added

** Bone fracture in last 5 years
label values n_2463_0_0 m_100349
*label values n_2463_1_0 m_100349
*label values n_2463_2_0 m_100349
clonevar bone_fract = n_2463_0_0
*replace bone_fract = n_2463_1_0 if bone_fract==. | bone_frac<0
*replace bone_fract = n_2463_2_0 if bone_fract==. | bone_frac<0 // 66 observations added

** Fracture resulting from single fall (from those who had any bone fracture, not necessarily last 5 years)
label values n_3005_0_0 m_100349
*label values n_3005_1_0 m_100349
*label values n_3005_2_0 m_100349
clonevar fract_single = n_3005_0_0
*replace fract_single = n_3005_1_0 if fract_single==. | fract_single<0
*replace fract_single = n_3005_2_0 if fract_single==. | fract_single<0 // 1,420 observations added

** Consumed Vitamin D levels (assessed by 24h recall - from baseline and online cycles)
format %20.17f n_100021_0_0
format %20.17f n_100021_1_0
format %20.17f n_100021_2_0
format %20.17f n_100021_3_0
format %20.17f n_100021_4_0
egen vitD = rowmean (n_100021_0_0 n_100021_1_0 n_100021_2_0 n_100021_3_0 n_100021_4_0)
lab var vitD "consumed vitamin D (ug)" // data for 116,265 available

** Use of vitamin D supplementation
label define m_100629 1 "Vitamin A" 2 "Vitamin B" 3 "Vitamin C" 4 "Vitamin D" 5 "Vitamin E" 6 "Folic acid or Folate (Vit B9)" 7 "Multivitamins +/- minerals" -7 "None of the above" -3 "Prefer not to answer"
label values n_6155_0_0 m_100629
label values n_6155_0_1 m_100629
label values n_6155_0_2 m_100629
label values n_6155_0_3 m_100629
label values n_6155_0_4 m_100629
label values n_6155_0_5 m_100629
label values n_6155_0_6 m_100629
*label values n_6155_1_0 m_100629
*label values n_6155_1_1 m_100629
*label values n_6155_1_2 m_100629
*label values n_6155_1_3 m_100629
*label values n_6155_1_4 m_100629
*label values n_6155_1_5 m_100629
*label values n_6155_1_6 m_100629
*label values n_6155_2_0 m_100629
*label values n_6155_2_1 m_100629
*label values n_6155_2_2 m_100629
*label values n_6155_2_3 m_100629
*label values n_6155_2_4 m_100629
*label values n_6155_2_5 m_100629
*label values n_6155_2_6 m_100629
gen supp_vitD=.
foreach x of varlist n_6155_0_0 n_6155_0_1 n_6155_0_2 n_6155_0_3 n_6155_0_4 n_6155_0_5 n_6155_0_6 {
replace supp_vitD=0 if `x'!=.
}
replace supp_vitD=1 if n_6155_0_0==4 | n_6155_0_1==4 | n_6155_0_2==4 | n_6155_0_3==4 | n_6155_0_4==4 | n_6155_0_5==4 | n_6155_0_6==4 
lab var supp_vitD "use of vit D supplementation"

** Use of calcium
label define m_100630 1 "Fish oil (including cod liver oil)" 2 "Glucosamine" 3 "Calcium" 4 "Zinc" 5 "Iron" 6 "Selenium" -7 "None of the above" -3 "Prefer not to answer"
label values n_6179_0_0 m_100630
label values n_6179_0_1 m_100630
label values n_6179_0_2 m_100630
label values n_6179_0_3 m_100630
label values n_6179_0_4 m_100630
label values n_6179_0_5 m_100630
*label values n_6179_1_0 m_100630
*label values n_6179_1_1 m_100630
*label values n_6179_1_2 m_100630
*label values n_6179_1_3 m_100630
*label values n_6179_1_4 m_100630
*label values n_6179_1_5 m_100630
*label values n_6179_2_0 m_100630
*label values n_6179_2_1 m_100630
*label values n_6179_2_2 m_100630
*label values n_6179_2_3 m_100630
*label values n_6179_2_4 m_100630
*label values n_6179_2_5 m_100630
gen calcium = .
foreach x of varlist n_6179_0_0 n_6179_0_1 n_6179_0_2 n_6179_0_3 n_6179_0_4 n_6179_0_5 {
replace calcium=0 if `x'!=.
}
replace calcium=1 if n_6179_0_0==3 | n_6179_0_1==3 | n_6179_0_2==3 | n_6179_0_3==3 | n_6179_0_4==3 | n_6179_0_5==3 
lab var calcium "use of calcium supplementation"

** BMI (anthropometry)
format %18.14f n_21001_0_0
*format %18.14f n_21001_1_0
*format %18.14f n_21001_2_0
clonevar bmi = n_21001_0_0
*replace bmi = n_21001_1_0 if bmi==. | bmi<0
*replace bmi = n_21001_2_0 if bmi==. | bmi<0 // 31 observations added

** BMI (BIA)
format %18.14f n_23104_0_0
*format %18.14f n_23104_1_0
clonevar bmi_bia = n_23104_0_0
*replace bmi_bia = n_23104_1_0 if bmi_bia==0 | bmi_bia<0 // 0 observations added

** Weight (kg)
format %18.14f n_21002_0_0
*format %18.14f n_21002_1_0
*format %18.14f n_21002_2_0
clonevar weight = n_21002_0_0
*replace weight = n_21002_1_0 if weight==. | weight<0
*replace weight = n_21002_2_0 if weight==. | weight<0 // 31 observations added

** Height (standing height - cm)
format %13.1f n_50_0_0
*format %13.1f n_50_1_0
*format %13.1f n_50_2_0
clonevar height = n_50_0_0
*replace height = n_50_1_0 if height==. | height<0
*replace height = n_50_2_0 if height==. | height<0 // 20 observations added

** Waist circumference
format %18.14f n_48_0_0
*format %13.1f n_48_1_0
*format %13.1f n_48_2_0
clonevar wc = n_48_0_0
*replace wc = n_48_1_0 if wc==. | wc<0
*replace wc = n_48_2_0 if wc==. | wc<0 // 18 observations added

** Hip circumference
format %18.14f n_49_0_0
*format %13.1f n_49_1_0
*format %13.1f n_49_2_0
clonevar hip_c = n_49_0_0
*replace hip_c = n_49_1_0 if hip_c==. | hip_c<0
*replace hip_c = n_49_2_0 if hip_c==. | hip_c<0 // 16 observations added

** Body fat percentage (BIA)
format %18.15f n_23099_0_0
*format %18.14f n_23099_1_0
clonevar bodyfat = n_23099_0_0
*replace bodyfat = n_23099_1_0 if bodyfat==. | bodyfat<0 // 148 observations added

** Use of sun/UV protection
label define m_100536 1 "Never/rarely" 2 "Sometimes" 3 "Most of the time" 4 "Always" 5 "Do not go out in sunshine" -1 "Do not know" -3 "Prefer not to answer"
label values n_2267_0_0 m_100536
*label values n_2267_1_0 m_100536
*label values n_2267_2_0 m_100536
clonevar sunprotect = n_2267_0_0
*replace sunprotect = n_2267_1_0 if sunprotect==. | sunprotect<0 
*replace sunprotect = n_2267_2_0 if sunprotect==. | sunprotect<0 // 347 observations added

** Month of birth
label define m_0008 12 "December" 10 "October" 7 "July" 1 "January" 4 "April" 9 "September" 3 "March" 8 "August" 11 "November" 6 "June" 2 "February" 5 "May"
label values n_52_0_0 m_0008
clonevar mbirth = n_52_0_0

** Month attending assessment centre
label values n_55_0_0 m_0008
*label values n_55_1_0 m_0008
*label values n_55_2_0 m_0008
clonevar month_att = n_55_0_0
*replace month_att = n_55_1_0 if month_att==.
*replace month_att = n_55_2_0 if month_att==. // 0 observations added

** Amount of time spent outdoor in summer (hours)
label define m_100329 -10 "Less than an hour a day" -1 "Do not know" -3 "Prefer not to answer"
label values n_1050_0_0 m_100329
*label values n_1050_1_0 m_100329
*label values n_1050_2_0 m_100329
clonevar timeoutdoor_s = n_1050_0_0
*replace timeoutdoor_s = n_1050_1_0 if timeoutdoor_s==. | timeoutdoor_s<0
*replace timeoutdoor_s = n_1050_2_0 if timeoutdoor_s==. | timeoutdoor_s<0 // 864 observations added
recode timeoutdoor_s (-10=0)

** Amount of time spent outdoor in winter (hours)
label values n_1060_0_0 m_100329
*label values n_1060_1_0 m_100329
*label values n_1060_2_0 m_100329
clonevar timeoutdoor_w = n_1060_0_0
*replace timeoutdoor_w = n_1060_1_0 if timeoutdoor_w==. | timeoutdoor_w<0
*replace timeoutdoor_w = n_1060_2_0 if timeoutdoor_w==. | timeoutdoor_w<0 // 690 observations added
recode timeoutdoor_w (-10=0)  

** Skin colour
label define m_100431 1 "Very fair" 2 "Fair" 3 "Light olive" 4 "Dark olive" 5 "Brown" 6 "Black" -1 "Do not know" -3 "Prefer not to answer"
label values n_1717_0_0 m_100431
*label values n_1717_1_0 m_100431
*label values n_1717_2_0 m_100431
clonevar skin_colour = n_1717_0_0
*replace skin_colour = n_1717_1_0 if skin_colour==. | skin_colour<0
*replace skin_colour = n_1717_2_0 if skin_colour==. | skin_colour<0 // 99 observations added

** Ease of skin tanning
label define m_100432 1 "Get very tanned" 2 "Get moderately tanned" 3 "Get mildly or occasionally tanned" 4 "Never tan, only burn" -1 "Do not know" -3 "Prefer not to answer"
label values n_1727_0_0 m_100432
*label values n_1727_1_0 m_100432
*label values n_1727_2_0 m_100432
clonevar skin_tanning = n_1727_0_0
*replace skin_tanning = n_1727_1_0 if skin_tanning==. | skin_tanning<0
*replace skin_tanning = n_1727_2_0 if skin_tanning==. | skin_tanning<0 // 550 observations added

** Fasting time (h)
clonevar fasting_t = n_74_0_0
*replace fasting_t = n_74_1_0 if fasting_t==.
*replace fasting_t = n_74_2_0 if fasting_t==. // 14 observations added


foreach x of varlist ethnic income pregnant nbirths adv_birth adv_birth1 adv_birth2 nstillbirth nstillbirth1 nstillbirth2 nmiscarriage nmiscarriage1 nmiscarriage2 ntermination ntermination1 ntermination2 ///
age_1stbirth age_lastbirth age_child gest_dm gest_dm1 gest_dm2 cancer ///
smoking alcohol timeoutdoor_s timeoutdoor_w skin_colour skin_tanning dm cancer bone_fract fract_single sunprotect {
recode `x' (-7=.) (-4=.) (-3=.) (-2=.) (-1=.)
}

lab def yn 0"No" 1"Yes"
foreach var of varlist stillbirth stillbirth1 stillbirth2 miscarriage miscarriage1 miscarriage2 termination termination1 termination2 gest_dm gest_dm1 gest_dm2 supp_vitD calcium {
lab val `var' yn
}

save "O:\ukbb-sleep\data_cleaning\clean_phenotype_description.dta", replace

**********************************************************************************
