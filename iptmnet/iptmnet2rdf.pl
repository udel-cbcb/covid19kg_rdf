#type, source, substrate_AC, substrate_genename,organsim, site, kinase_AC, kinase_genename, note, pmid

if(@ARGV != 3) {
	print "Usage: perl iptmnet2rdf.pl iptmnet_prefix.ttl source.txt ptm.txt\n";
	exit 1;
}
#print $ARGV[0]."\n";
#`cat prefix.ttl`;
open FILE, $ARGV[0]; while (<FILE>) { $prefix .= $_; }
print $prefix;

my %source_map = ();
open(S, $ARGV[1]) or die "Can't open $ARGV[1]\n";
while($line=<S>) {
	chomp($line);
	my ($a, $b) = (split(/\t/, $line))[0,1];
	$a =~ s/ //g;
	$b =~ s/ //g;
	$source_map{$a} = $b;
	
	#print $a."\t".$b."\n";
}
close(S);

my $index = 1;
open(P, $ARGV[2]) or die "Can't open $ARGV[2]\n";
while($line=<P>) {
	chomp($line);
	my ($type, $source, $substrate_AC, $substrate_genename, $organism, $site, $kinase_AC, $kinase_genename, $note, $pmid) = (split(/\t/, $line))[0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
	$residue = substr($site, 0, 1);
	$position = substr($site, 1, length($site)-1);
	$source =~ s/ //g;
	my $entry = "";
	$entry .= "iptmnet:uid_".$index."\n";
	$entry .= "\tiptmnet:type \"".$type."\" ;\n";
	$entry .=  "\tiptmnet:source \"".$source_map{$source}."\" ;\n";
	#$entry .=  "\tiptmnet:source \"".$source."\" ;\n";
	if($substrate_AC) {
		$entry .= "\tiptmnet:substrate uniprot:".$substrate_AC." ;\n";
	}
	else {
		$entry .= "\tiptmnet:substrate \"\" ;\n";
	}
	if($substrate_genename) {
		$entry .= "\tiptmnet:substrate_genename \"".$substrate_genename."\" ;\n";
	}
	else {
		$entry .= "\tiptmnet:substrate_genename \"\" ;\n";
	}
	if($organism) {
		$entry .= "\tiptmnet:organism \"".$organism."\" ;\n";
	}
	else {
		$entry .= "\tiptmnet:organism \"\" ;\n";
	}
	$entry .= "\tiptmnet:residue \"".$residue."\" ;\n";
	$entry .= "\tiptmnet:position \"".$position."\"^^xsd:integer ;\n";
	@kin = split(/;/, $kinase_AC);
	$kin_str = "";
	foreach(@kin) { 
		$ac = $_;
		if($ac =~ /^PR:/) {
			$ac =~ s/\:/_/;
			$kin_str .= "obo:".$ac." ,\n";
		}
		elsif($ac =~ /[OPQ][0-9][A-Z0-9]{3}[0-9]|[A-NR-Z][0-9]([A-Z][A-Z0-9]{2}[0-9]){1,2}/) {
			$kin_str .= "uniprot:".$ac." ,\n";
		}
		else {
			$kin_str .= "\"".$ac."\" ,\n";
		}
	}
	$kin_str =~ s/ ,$//;
	if($kin_str) {
		$entry .= "\tiptmnet:kinase ".$kin_str." ;\n";
	}
	else {
		$entry .= "\tiptmnet:kinase \"\" ;\n";
	}

	@kin_gene = split(/;/, $kinase_genename);
	$kin_gene_str = "";
	foreach(@kin_gene) {	 
		$kin_genename = $_;	
		if($kin_genename) {
			$kin_gene_str .= "\"".$kin_genename."\" ,\n";
		}
		else {
			$kin_gene_str .= "\"\" ,\n";
		}
	}
	$kin_gene_str =~ s/ ,$//;
	if($kin_gene_str) {
		$entry .= "\tiptmnet:kinase_genename ".$kin_gene_str." ; \n";
	}
	else {
		$entry .= "\tiptmnet:kinase_genename \"\" ; \n";
	}
	if($note) {
		$entry .= "\tiptmnet:note \"".$note."\" ;\n";
	}
	else {
		$entry .= "\tiptmnet:note \"\" ;\n";
	}
	if($pmid) {
		$entry .= "\tiptmnet:pmid \"".$pmid."\" ;\n";
	}
	else {
		$entry .= "\tiptmnet:pmid \"\" ;\n";
	}
	$entry =~ s/ \;$/ \./;
	print $entry."\n";
	$index++;		
}
close(P);

#print substr("Y234", 0,1);
#print substr("Y234", 1,length("Y234")-1);
