# CoVAbDab

## Download CoVAbDab csv file 

```
wget http://opig.stats.ox.ac.uk/webapps/covabdab/static/downloads/CoV-AbDab_160621.csv
dos2unix CoV-AbDab_160621.csv 
```

## Convert CoVAbDab to RDF

```
cat CoV-AbDab_160621.csv | sed 's/,/\t/g' | perl covabdab_to_ttl.pl > CoV-AbDab_160621.ttl
```

## Validate RDF file

```
ttl CoV-AbDab_160621.ttl > CovAbDab_ttl_validation.log
```

## Compress RDF file for dissemination

```
gzip CoV-AbDab_160621.ttl
```


