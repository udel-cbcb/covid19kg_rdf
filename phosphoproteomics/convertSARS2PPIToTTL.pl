
if(@ARGV != 1) {
	print "Usage perl convertSARS2PPIToTTL.pl SARS2-PPI.txt\n";
	exit 1;
}
print "\@prefix sars2: <https://research.bioinformatics.udel.edu/covid-19-kg/sars2_ppi#> .\n";
print "\@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n";

#Bait-Prey Information			MS Information				Uniprot Protein Database Information				
#Bait	Preys	PreyGene	MIST	Saint_BFDR	AvgSpec	FoldChange	Uniprot Protein ID	Uniprot Protein Description	Uniprot Function	Structures (PDB)	Uniprot Function in Disease

open(S, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<S>) {
	chomp($line);
	if($line !~ /^Bait/) {
		($viral_protein, $human_protein, $human_gene_name, $mist, $saint_bfdr, $avg_spec, $fold_change, $uniprot_id, $uniprot_desc, $uniprot_function, $pdb, $disease) = (split(/\t/, $line))[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
		print "[\n";
		print "\tsars2:viral_protein \"$viral_protein\" ; \n";	
		$ac_uri = "https://www.uniprot.org/uniprot/$human_protein";
		print "\tsars2:human_protein \"$ac_uri\" ; \n";	
		print "\tsars2:human_gene_name \"$human_gene_name\" ; \n";	
		print "\tsars2:uniprot_id \"$uniprot_id\" ; \n";	
		print "\tsars2:uniprot_description \"$uniprot_desc\" ; \n";	
		print "\tsars2:uniprot_function \"$uniprot_function\" ; \n";	
		print "\tsars2:pdb \"$pdb\" ; \n";	
		print "\tsars2:disease \"$disease\" ; \n";	
		if($mist  =~ /^[+-]?\d+$/) {
			print "\tsars2:mist \"$mist\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:mist \"$mist\"^^xsd:float ; \n";	
		}
		if($saint_bfdr  =~ /^[+-]?\d+$/) {
			print "\tsars2:saint_bfdr \"$saint_bfdr\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:saint_bfdr \"$saint_bfdr\"^^xsd:float ; \n";	
		}
		if($avg_spec  =~ /^[+-]?\d+$/) {
			print "\tsars2:avg_spec \"$avg_spec\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:avg_spec \"$avg_spec\"^^xsd:float ; \n";	
		}
		if($fold_change  =~ /^[+-]?\d+$/) {
			print "\tsars2:fold_change \"$fold_change\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:fold_change \"$fold_change\"^^xsd:float ; \n";	
		}
		print "] .\n\n";
	}	
}
close(S);
