#!/bin/bash
mkdir -p ../../rdf/pmc
ROOT_DIR=../../data
RDF_DIR=../../rdf
FILES=$ROOT_DIR/pmc/*.json
target_uri="https://www.ncbi.nlm.nih.gov/pmc/articles/"

for f in $FILES
do
  echo $f
  id=$(echo $f | grep -oP "\/\K(PMC)?\d{1,12}")
  PMC=$RDF_DIR/pmc/$id.ttl
  echo $PMC
  if [ ! -f "$PMC" ]; then
  	cat $f | java -jar ../../../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../../../apache-jena-4.1.0/bin/riot --formatted=TURTLE > $PMC
  fi
done
