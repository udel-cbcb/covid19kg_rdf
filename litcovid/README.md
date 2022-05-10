# LitCovid 

This directory contains code for generating RDF files of LitCovid metadata and associated PubTator annotations.

## Download LitCovid metadata and PubTatator annotations in BioC JSON format from NCBI 

```
mkdir -p rdf/litcovid
mkdir -p rdf/litcovid_pubtator
wget https://ftp.ncbi.nlm.nih.gov/pub/lu/LitCovid/litcovid2BioCJSON.gz   -O litcovid2BioCJSON.gz 
wget https://ftp.ncbi.nlm.nih.gov/pub/lu/LitCovid/litcovid2pubtator.json.gz -O litcovid2pubtator.json.gz 
gunzip -c litcovid2pubtator.json.gz  | sed 1,3d > litcovid2pubtator.json
gunzip -c litcovid2BioCJSON.gz  | sed 1,3d > litcovid2BioC.json
```

## Split the downloaded large BioC JSON file into per document BioC JSON files.

```
perl split_json.pl litcovid2BioC.json litcovid2BioC
perl split_json.pl litcovid2pubtator.json litcovid2pubtator
```

## Get litcovid pmids 

```
python getMetadataIds.py | sed 's/None//' | awk -F"|" '{print $1"\t"$2}' > litcovid_pmid_pmcid.txt
```

## Run shell scripts to convert the downloaded JSON to RDF turtle.

```
nohup sh litcovid2BioC_json_to_ttl.sh 2>&1  > litcovid2BioC_json_to_ttl.log 
nohup sh litcovid2pubtator_json_to_ttl.sh 2>&1  > litcovid2pubtator_json_to_ttl.log 
```

## Validate RDF turtle files

```
nohup perl validateTTL.pl rdf/litcovid > litcovid_ttl_validation.log
nohup perl validateTTL.pl rdf/litcovid_pubtator > litcovid_pubtator_ttl_validation.log
```

## Combine RDF files for dissemination

```
cd rdf
tar zcvf litcovid.rdf.tar.gz litcovid
tar zcvf litcovid_pubtator.rdf.tar.gz litcovid_pubtator
```


