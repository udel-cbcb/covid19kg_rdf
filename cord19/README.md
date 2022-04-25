# COVID-19 Open Research Dataset (CORD-19)

This directory contains code for generating RDF files of CORD-19 metadata and associated PubTator annotations.
It is modified based on https://github.com/fhircat/CORD-19-on-FHIR.

## Download CORD-19 metadata 

https://ai2-semanticscholar-cord-19.s3-us-west-2.amazonaws.com/<date_iso_str>/metadata.csv
Replace <date_iso_str> with the release date formatted as YYYY-MM-DD, see example below with one of the below:

```
cd source
wget https://ai2-semanticscholar-cord-19.s3-us-west-2.amazonaws.com/2021-06-21/metadata.csv -O  metadata.csv

cd ../
mkdir -p data/metadata
mkdir -p data/pm
mkdir -p data/pmc
mkdir -p rdf/metadata
mkdir -p rdf/pm
mkdir -p rdf/pmc
```

## Convert metadata.csv to JSON

```
nohup python metadata_csv_to_json.py > metadata_csv_to_json.log 
```

Conversion script requirements:
https://github.com/AtomGraph/JSON2RDF
https://jena.apache.org/
Compile JSON2RDF package and put jar in Project Directory
Add Jena bin to path

## Convert metadata JSON to RDF turtle

```
nohup python metadata_json_to_rdf.py > metadata_json_to_ttl.log 
```

## Get CORD-19 corduid mapping to pmcid and pmid  

```
perl getMetadataIDs.pl  data/metadata/ >  cord19_corduid_pmcid_pmid.txt
```
## Run download_bioc.py script to pull PMC and PM annotations from Pubtator API: https://www.ncbi.nlm.nih.gov/research/pubtator/api.html

```
cd scripts/fetch_pubtator/
nohup python download_bioc.py > download_bioc.log 
```

## Run shell scripts to convert the downloaded JSON to RDF turtle.

```
nohup sh pm_json_to_ttl.sh > pm_json_to_ttl.log 
nohup sh pmc_json_to_ttl.sh > pmc_json_to_ttl.log 
```

## Validate RDF turtle files

```
nohup perl validateTTL.pl rdf/metadata/ > metadata_ttl_validation.log  
nohup perl validateTTL.pl rdf/pm/ > pm_ttl_validation.log  
nohup perl validateTTL.pl rdf/pmc/ > pmc_ttl_validation.log  
```

## Combine RDF files for dissemination

```
cd rdf
tar zcvf cord19.rdf.tar.gz metadata
tar zcvf cord19_pmc_pubtator.rdf.tar.gz pmc
tar zcvf cord19_pm_pubtator.rdf.tar.gz pm
```
		
