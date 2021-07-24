#!/bin/bash
mkdir -p rdf/mirtex.cord19.pmc
ROOT_DIR=json/mirtex.cord19.pmc
FILES=$ROOT_DIR/*.json
target_uri="https://research.bioinformatics.udel.edu/itextmine/cord19/pmc/mirtex"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  #file="${file%%.*}"
  cat $f | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/mirtex.cord19.pmc/$file.ttl
done
