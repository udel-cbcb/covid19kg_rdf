if(@ARGV !=2) {
	print "Usage: perl convertStringToTTL.pl protein.info.txt protein.link.text\n";
	exit 1;
}
#my %id2name = ();
#my %id2size = ();
#my %id2ann = ();

print "\@prefix rdf:	<http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n";
print "\@prefix obo:	<http://purl.obolibrary.org/obo/> .\n";
print "\@prefix owl:	<http://www.w3.org/2002/07/owl#> .\n";
print "\@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .\n";
print "\@prefix ensembl: <http://www.ensembl.org/id/> .\n";
print "\@prefix sio: <http://semanticscience.org/resource/> .\n";
print "\@prefix swo: <http://www.ebi.ac.uk/swo/> .\n";

print "\n";

open(I, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<I>) {
	chomp($line);
	if($line !~ /^protein_external_id/) {
		my ($id, $name, $size, $ann) = (split(/\t/, $line))[0, 1, 2, 3];
		$ann =~ s/"/'/g;
		my ($taxon, $ensembl) = (split(/\./, $id))[0, 1];		
		print "ensembl:$ensembl a owl:Class ;\n";
		print "\tobo:id \"$ensembl\" ;\n";
		if($name) {
			print "\trdfs:label \"".$name."\" ;\n";
		}
		if($ann) {
			print "\trdfs:comment \"".$ann."\" ;\n";
		}
		print "\trdfs:subClassOf [\n"; 
		print "\t\ta owl:Restriction ;\n";
		print "\t\towl:onProperty obo:RO_0002160 ;\n";
		print "\t\towl:someValuesFrom obo:NCBITaxon_".$taxon.";\n";
		print "                  ] .\n\n";
	}
}
close(I);


open(L, $ARGV[1]) or die "Can't open $ARGV[1]\n";
while($line=<L>) {
	chomp($line);
	if($line !~ /^protein1/) {
		my ($p1, $p2, $score) = (split(/ /, $line))[0, 1, 2];
		my ($taxon1, $ensembl1) = (split(/\./, $p1))[0, 1];		
		my ($taxon2, $ensembl2) = (split(/\./, $p2))[0, 1];		
		print "[\n";
		print "\ta owl:Axiom ;\n";
  		print "\towl:annotatedProperty  sio:SIO_000701 ;\n";
  		print "\towl:annotatedSource  ensembl:$ensembl1 ;\n";
  		print "\towl:annotatedTarget  ensembl:$ensembl2 ;\n";
		print "\tswo:SWO_0000425 \"".$score."\" ;\n";
		print "\trdfs:comment \"combined_score\" \n";
		print "] .\n\n";
	}
	
}
close(L);
