module add languages/python-2.7.6

###


###
cat insomnia57_new.gen | python gen_to_expected.py > insomnia57-dosage.txt

cat insomnia57-dosage.txt | awk '{print NF}'

cat insomnia57-dosage.txt | cut -d' ' -f7- > insomnia57-dosage2.txt

### participants ID
awk '(NR>2){print $1}' data_app2393.sample > userIds_app2393.txt


