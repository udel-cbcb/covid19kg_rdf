# iPTMnet 

A bioinformatics resource for integrated understanding of protein post-translational modifications (PTMs) in systems biology context.

This directory contains code for generating RDF files for iPTMnet. The source text files (ptm.txt and biomuta_info.tb) are available internally. 
Please contact us (chenc@udel.edu).

## Convert to RDF files.

```
perl biomuta2rdf.pl biomuta_prefix.ttl biomuta_info.tb > biomuta.ttl 
perl iptmnet2rdf.pl iptmnet_prefix.ttl source.txt ptm.txt > ptm.ttl 
```

## Validate RDF files

```
ttl biomuta.ttl
ttl ptm.ttl
```
