#!/bin/bash
mkdir -p rdf/efip.cord19.pmc
ROOT_DIR=json/efip.cord19.pmc
FILES=$ROOT_DIR/*.json
target_uri="https://research.bioinformatics.udel.edu/itextmine/cord19/pmc/efip"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  #file="${file%%.*}"
  cat $f | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/efip.cord19.pmc/$file.ttl
done
