if(@ARGV != 1) {
	print "Usage: perl convertSARS2PhosphoproteomeToTTL.pl SARS2Phosphoproteome.txt\n";
	exit 1;
}
print "\@prefix sars2: <https://research.bioinformatics.udel.edu/covid-19-kg/sars2_phosphoproteome#> .\n";
print "\@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n";
print "\n";
#Gene_Name	uniprot	site	Ctrl_24Hr.log2FC	Inf_00Hr.log2FC	Inf_02Hr.log2FC	Inf_04Hr.log2FC	Inf_08Hr.log2FC	Inf_12Hr.log2FC	Inf_24Hr.log2FC	Ctrl_24
#Hr.adj.pvalue	Inf_00Hr.adj.pvalue	Inf_02Hr.adj.pvalue	Inf_04Hr.adj.pvalue	Inf_08Hr.adj.pvalue	Inf_12Hr.adj.pvalue	Inf_24Hr.adj.pvalue
open(P, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<P>) {
	chomp($line);
	if($line !~ /^Gene_Name/) {
		my ($gene, $uniprot, $site, $Ctrl_24Hr_log2FC, $Inf_00Hr_log2FC, $Inf_02Hr_log2FC, $Inf_04Hr_log2FC, $Inf_08Hr_log2FC, $Inf_12Hr_log2FC, $Inf_24Hr_log2FC, $Ctrl_24Hr_adj_pvalue, $Inf_00Hr_adj_pvalue, $Inf_02Hr_adj_pvalue, $Inf_04Hr_adj_pvalue, $Inf_08Hr_adj_pvalue, $Inf_12Hr_adj_pvalue, $Inf_24Hr_adj_pvalue) = (split(/\t/, $line))[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
		print_condition($gene, $uniprot, $site, "mock 24h vs. mock 0h", $Ctrl_24Hr_log2FC, $Ctrl_24Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 0h vs. mock 0h", $Inf_00Hr_log2FC, $Inf_00Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 2h vs. mock 0h", $Inf_02Hr_log2FC, $Inf_02Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 4h vs. mock 0h", $Inf_04Hr_log2FC, $Inf_04Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 8h vs. mock 0h", $Inf_08Hr_log2FC, $Inf_08Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 12h vs. mock 0h", $Inf_12Hr_log2FC, $Inf_12Hr_adj_pvalue);	
		print_condition($gene, $uniprot, $site, "infected 24h vs. mock 0h", $Inf_24Hr_log2FC, $Inf_24Hr_adj_pvalue);	
	}
}
close(P);

sub print_condition {
	my ($gene, $uniprot, $site, $condition, $fc, $pval) = @_;
	print "[\n";
	print "\tsars2:gene_name \"$gene\" ; \n";
	$ac_uri = "https://www.uniprot.org/uniprot/$uniprot";
	print "\tsars2:protein  \"$ac_uri\" ;\n";
	print "\tsars2:site  \"$site\" ;\n";
	print "\tsars2:condition \"$condition\"; \n";
	print get_values($fc, $pval);
	print "] .\n\n";	
}

sub get_values {
	my ($fc, $pval) = @_;
	my $values = "";
	if($fc) {
		if($fc =~ /^Inf/) {
			$values .= "\tsars2:log2_fc \"1.0E12\"^^xsd:float ;\n";
		}
		elsif($fc =~ /-Inf/) {
			$values .= "\tsars2:log2_fc \"-1.0E12\"^^xsd:float ;\n";
		}
		elsif($fc =~ /^[+-]?\d+$/) {
			$values .= "\tsars2:log2_fc \"".$fc."\"^^xsd:integer ;\n";
		}
		else {
			$values .= "\tsars2:log2_fc \"".$fc."\"^^xsd:float ;\n";
		}
	}
	if($pval) {
		if($pval=~ /^Inf/) {
			$values .= "\tsars2:adj_pvalue \"1.0E12\"^^xsd:float ;\n";
		}
		elsif($fc =~ /-Inf/) {
			$values .= "\tsars2:adj_pvalue \"-1.0E12\"^^xsd:float ;\n";
		}
		elsif($pval =~ /^[+-]?\d+$/) {
			$values .= "\tsars2:adj_pvalue \"".$pval."\"^^xsd:integer ;\n";
		}
		else {
			$values .= "\tsars2:adj_pvalue \"".$pval."\"^^xsd:float ;\n";
		}
	}
	return $values;	
}
