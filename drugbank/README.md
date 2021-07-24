# DrugBank

## Download drugbank xml file

```
curl -Lfv -o drugbank_all_full_database_5_1_8.xml.zip -u YourEmail:PASSWORD https://go.drugbank.com/releases/5-1-8/downloads/all-full-database
unzip drugbank_all_full_database_5_1_8.xml.zip 
```

## Split drugbank XML file into per entry XML files.

```
mkdir -p drugbank_5_1_8
perl split_drugbank_xml.pl drugbank_all_full_database_5_1_8.xml drugbank_5_1_8
```

## Convert XML to RDF

```
sh drugbank_xml_to_ttl_5_1_8.sh
```

## Validate RDF files

```
nohup perl validateTTL.pl rdf/ > drugbank_ttl_validation.log
```

## Combine RDF files for dissemination

```
tar zcvf drugbank.rdf.tar.gz rdf/
```
