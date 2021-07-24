#!/bin/bash
mkdir -p rdf/mirtex.litcovid.medline
ROOT_DIR=json/mirtex.litcovid.medline
FILES=$ROOT_DIR/*.json
target_uri="https://research.bioinformatics.udel.edu/itextmine/litcovid/medline/mirtex"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  #file="${file%%.*}"
  cat $f | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/mirtex.litcovid.medline/$file.ttl
done
