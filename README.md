# COVID-19 Knowledge Graph RDF

This repository contains code used to generate RDF files for COVID-19 Knowledge Graph (https://research.bioinformatics.udel.edu/covid19kg).

## Programming Requirements

```
bash, perl, java, python, node.js
```

RDF NTriples/Turtle validator using Ruben Verborgh's N3 NodeJS library. Validate Turtle and Ntriples documents on syntax and XSD datatype errors through command line. https://github.com/MMLab/TurtleValidator

```
npm install -g turtle-validator
```

### Download Apache Jena

```
wget https://mirror.olnevhost.net/pub/apache/jena/binaries/apache-jena-4.1.0.tar.gz
tar zxvf apache-jena-4.1.0.tar.gz
```

### Download json2rdf

```
wget https://github.com/AtomGraph/JSON2RDF/releases/download/1.0.1/json2rdf-1.0.1-jar-with-dependencies.jar
```

### Install XML2JSON tool 

```
pip install https://github.com/hay/xml2json/zipball/master
```

## COVID-19 Open Research Dataset (CORD-19) Metadata and associated PubTator annotations

Go to "cord19" directory and follow the README.md in that directory.

## LitCovid Metadata and associated PubTator annotations

Go to "litcovid" directory and follow the README.md in that directory.

## SemRep CORD-19 and LitCovid annotations 

Go to "semrep" directory and follow the README.md in that directory.

## iTextMine CORD-19 and LitCovid annotations 

Go to "itextmine" directory and follow the README.md in that directory.

## CovAbDab 

Go to "covabdab" directory and follow the README.md in that directory.

## DrugBank 

Go to "drugbank" directory and follow the README.md in that directory.

## String 

Go to "string" directory and follow the README.md in that directory.

## SARS-CoV-2 Phosphoproteomics

Go to "phosphoproteomics" directory and follow the README.md in that directory.
