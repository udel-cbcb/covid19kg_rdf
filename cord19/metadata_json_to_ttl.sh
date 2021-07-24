#!/bin/bash
ROOT_DIR=./data/metadata/
FILES=$ROOT_DIR/$1*.json
target_uri="https://research.bioinformatics.udel.edu/covid-19-kg/cord19/metadata"
for f in $FILES
do
  #echo $f
  file="$(basename $f)"
  file="${file%%.*}"
  if [[ "$file" =~ ^$1.* ]]; then
  	echo $f
  	echo "rdf/metadata/$file.ttl"
  	cat $f | java -jar ../json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | ../apache-jena-4.1.0/bin/riot  --formatted=TURTLE > rdf/metadata/$file.ttl
  fi
done


