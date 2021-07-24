
if(@ARGV != 1) {
	print "Usage perl convertSARS2PhosphositeToTTL SARS2-Phosphosite.txt\n";
	exit 1;
}
print "\@prefix sars2: <https://research.bioinformatics.udel.edu/covid-19-kg/sars2_phosphosite#> .\n";
print "\@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n";

#UniProtID	GeneName	Site	log2FC	adj-p-value
open(S, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<S>) {
	chomp($line);
	if($line !~ /^UniProtID/) {
		($uniprot, $gene, $site, $log2FC, $adj_pvalue) = (split(/\t/, $line))[0, 1, 2, 3, 4];
		print "[\n";
		$ac_uri = "https://www.uniprot.org/uniprot/$uniprot";
		print "\tsars2:protein \"$ac_uri\" ; \n";	
		print "\tsars2:gene_name \"$gene\" ; \n";	
		print "\tsars2:site \"$site\" ; \n";	
		if($log2FC  =~ /^[+-]?\d+$/) {
			print "\tsars2:log2_fc \"$log2FC\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:log2_fc \"$log2FC\"^^xsd:float ; \n";	
		}
		if($adj_pvalue  =~ /^[+-]?\d+$/) {
			print "\tsars2:adj_pvalue \"$adj_pvalue\"^^xsd:integer ; \n";	
		}
		else {
			print "\tsars2:adj_pvalue \"$adj_pvalue\"^^xsd:float ; \n";	
		}
		print "] .\n\n";
	}	
}
close(S);
