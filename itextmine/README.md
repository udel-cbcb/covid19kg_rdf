# iTextMine

This directory contains code for generating RDF files of iTextMine annotations. 
Currently, the source JSON files (RLIMSP, eFIP, and miRTex) are available internally. 
Please contact us (chenc@udel.edu).

## Split the iTextMine BioC JSON file into per document BioC JSON files.

```
nohup sh split_json.sh > split_json.log

```

## Convert  JSON to RDF files

```
nohup sh rlims.litcovid.medline_json_to_ttl.sh > rlims.litcovid.medline_json_to_ttl.log 
nohup sh rlims.cord19.pmc_json_to_ttl.sh > rlims.cord19.pmc_json_to_ttl.log
nohup sh rlims.cord19.medline_json_to_ttl.sh > rlims.cord19.medline_json_to_ttl.log
nohup sh mirtex.litcovid.medline_json_to_ttl.sh > mirtex.litcovid.medline_json_to_ttl.log
nohup sh mirtex.cord19.medline_json_to_ttl.sh > mirtex.cord19.medline_json_to_ttl.log
nohup sh mirtex.cord19.pmc_json_to_ttl.sh > mirtex.cord19.pmc_json_to_ttl.log
nohup sh efip.litcovid.medline_json_to_ttl.sh > efip.litcovid.medline_json_to_ttl.log
nohup sh efip.cord19.medline_json_to_ttl.sh > efip.cord19.medline_json_to_ttl.log
nohup sh efip.cord19.pmc_json_to_ttl.sh > efip.cord19.pmc_json_to_ttl.log
```

## Validate RDF files

```
nohup ttl_validation.sh > ttl_validation.log
```

## Combine RDF files for distribution

```
nohup sh combine_ttl.sh  > combine_ttl.log
```
