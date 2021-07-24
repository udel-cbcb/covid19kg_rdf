#!/bin/bash
mkdir -p ../../rdf/pm
ROOT_DIR=../../data
RDF_DIR=../../rdf
FILES=$ROOT_DIR/pm/*.json
target_uri="https://www.ncbi.nlm.nih.gov/pubmed/"

for f in $FILES
do
  echo $f
  id=$(echo $f | grep -oP "\/\K(PMC)?\d{1,12}")
  PM=$RDF_DIR/pm/$id.ttl
  echo $PM
  if [ ! -f "$PM" ]; then
  	cat $f | java -jar ../../../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../../../apache-jena-4.1.0/bin/riot --formatted=TURTLE > $PM
  fi
done
