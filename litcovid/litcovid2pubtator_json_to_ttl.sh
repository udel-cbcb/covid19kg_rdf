#!/bin/bash
ROOT_DIR=./litcovid2pubtator
FILES=$ROOT_DIR/*.json
target_uri="https://www.ncbi.nlm.nih.gov/research/coronavirus/litcovid/pubtator"
for f in $FILES
do
  echo $f
  file="$(basename $f)"
  file="${file%%.*}"
  cat $f | java -jar /home/chenc/covid19kg_rdf/json2rdf-1.0.1-jar-with-dependencies.jar $target_uri | /home/chenc/apache-jena-3.15.0/bin/riot  --formatted=TURTLE > rdf/litcovid_pubtator/$file.ttl
  echo "rdf/litcovid_pubtator/$file.ttl"
done


