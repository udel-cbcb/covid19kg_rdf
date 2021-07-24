# iTextMine

This directory contains code for generating RDF files of iTextMine annotations. 
Currently, the source JSON files (RLIMSP, eFIP, and miRTex) are available internally.

## Split the iTextMine BioC JSON file into per document BioC JSON files.

```
nohup sh split_json.sh > split_json.log

```

## Convert  JSON to RDF files

```
nohup sh convert_json_to_ttl.sh > convert_json_to_ttl.log
```

## Validate RDF files

```
nohup ttl_validation.sh > ttl_validation.log
```

## Combine RDF files for distribution

```
nohup sh combine_ttl.sh  > combine_ttl.log
```
