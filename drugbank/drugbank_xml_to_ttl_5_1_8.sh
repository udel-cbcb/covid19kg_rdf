#!/bin/bash
mkdir -p rdf
ROOT_DIR=drugbank_5_1_8
FILES=$ROOT_DIR/*.xml
target_uri="https://research.bioinformatics.udel.edu/covid-19-kg/drugbank"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  file="${file%%.*}"
  xml2json $f > $f.json
  cat $f.json | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/$file.ttl
  echo "rdf/$file.ttl"
done
