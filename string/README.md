# String database

## Download human protein info and PPI data

```
wget https://stringdb-static.org/download/protein.links.v11.0/9606.protein.links.v11.0.txt.gz
gunzip 9606.protein.links.v11.0.txt.gz
wget https://stringdb-static.org/download/protein.info.v11.0/9606.protein.info.v11.0.txt.gz
gunzip 9606.protein.info.v11.0.txt.gz
```

## Convert String human PPI to RDF

```
perl convertStringToTTL.pl 9606.protein.info.v11.0.txt 9606.protein.links.v11.0.txt > string-human.rdf.ttl
```

## Validate RDF

```
ttl string-human.rdf.ttl
```

## Compress RDF for dissemination

```
gzip string-human.rdf.ttl
```

