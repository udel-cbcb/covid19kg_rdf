#!/bin/bash
ROOT_DIR=./litcovid2BioC
FILES=$ROOT_DIR/*.json
target_uri="https://www.ncbi.nlm.nih.gov/research/coronavirus/litcovid"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  file="${file%%.*}"
  cat $f | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/litcovid/$file.ttl
  echo "rdf/litcovid/$file.ttl"
done


