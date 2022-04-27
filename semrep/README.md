#  SemRep, a semantic interpreter that uses underspecified syntactic analysis and the UMLS knowledge sources to provide partial semantic interpretation of the biomedical research literature.


## Download SemRep data for LitCovid and CORD-19

```
curl https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/COVID-19/LitCovid/LitCovid.SemRep.tar.gz --output LitCovid.SemRep.tar.gz
curl https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/COVID-19/CORD-19/CORD-19.SemRep.ALL.tar.gz --output CORD-19.SemRep.ALL.tar.gz
mkdir LitCovid.SemRep
tar zxvf LitCovid.SemRep.tar.gz -C LitCovid.SemRep/ 
mkdir CORD-19.SemRep
tar zxvf CORD-19.SemRep.ALL.tar.gz -C CORD-19.SemRep/
```

## Convert SemRep data to RDF

```
cp ../cord19/cord19_corduid_pmcid_pmid.txt .
cp ../litcovid/litcovid_pmid.txt .
mkdir rdf/litcovid_semrep
nohup perl convertLitCovidSemRepToTTL.pl litcovid_pmid.txt LitCovid.SemRep rdf/litcovid_semrep/ > convertLitCovidSemRepToTTL.log 
cat cord19_corduid_pmcid_pmid.txt | perl getcord19_uid_docid.pl | sort -u > cord19_uid_docid.txt
mkdir rdf/cord19_semrep
nohup perl convertCORD19SemRepToTTL.pl cord19_uid_docid.txt CORD-19.SemRep rdf/cord19_semrep/ > convertCORD19SemRepToTTL.log 
```

## Validate RDF turtle files

```
nohup perl validateTTL.pl rdf/litcovid_semrep > litcovid_semrep_ttl_validation.log 
nohup perl validateTTL.pl rdf/cord19_semrep > cord19_semrep_ttl_validation.log 
```

## Combine RDF files for dissemination

```
cd rdf
tar zcvf litcovid_semrep.rdf.tar.gz litcovid_semrep
tar zcvf cord19_semrep.rdf.tar.gz cord19_semrep
```

