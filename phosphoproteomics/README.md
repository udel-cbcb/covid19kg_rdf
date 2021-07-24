# SARS-COV-2 Phosphoproteomics

## The Global Phosphorylation Landscape of SARS-CoV-2 Infection

Download https://www.cell.com/cms/10.1016/j.cell.2020.06.034/attachment/6ae88644-c133-4601-87a9-dc08019551e9/mmc1.xlsx, and save it as tab-delimited file (bouhaddou-PMID32645325-SARS2-Phosphoproteome.txt)

### Convert to RDF turtle file

```
perl convertSARS2PhosphoproteomeToTTL.pl bouhaddou-PMID32645325-SARS2-Phosphoproteome.txt > sars2_phosphoproteome.ttl
```
### Validate RDF file

```
ttl sars2_phosphoproteome.ttl
```

## SARS-CoV-2 protein interaction map

Download https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-020-2286-9/MediaObjects/41586_2020_2286_MOESM6_ESM.xlsx, and save it as tab-delimited file (gordon-PMID323538590-SARS2-PPIs.txt)

### Convert to RDF turtle file

```
perl convertSARS2PPIToTTL.pl gordon-PMID323538590-SARS2-PPIs.txt  > sars2_ppi.ttl 
```

### Validate RDF file

```
ttl sars2_ppi.ttl
```

## Phosphosites and total proteins of Caco-2 cells (human colon cell line) infected with SARS-CoV-2

Download https://www.cell.com/cms/10.1016/j.molcel.2020.08.006/attachment/85b54ca5-7f28-4ab3-a7eb-ac73678497d6/mmc2.xlsx, and save it as tab-delimited file (klann-PMID32877642-SARS2-phosphosites.txt)

### Convert to RDF turtle file

```
perl convertSARS2PhosphositeToTTL.pl klann-PMID32877642-SARS2-phosphosites.txt  > sars2_phosphosite.ttl
```

### Validate RDF file

```
ttl sars2_phosphosite.ttl
```


