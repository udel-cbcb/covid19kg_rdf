if(@ARGV != 2) {
	print "Usage: perl biomuta2rdf.pl biomuta_prefix.ttl biomuta_info.tb\n";
	exit 1;
}

open FILE, $ARGV[0]; while (<FILE>) { $prefix .= $_; }
print $prefix;

#	"AC" VARCHAR2(20 BYTE), 
#		"POSITION" NUMBER(38,0), 
#			"RESIDUE_SEQUENCE" VARCHAR2(1 BYTE), 
#				"RESIDUE_MUTATED" VARCHAR2(1 BYTE), 
#					"DISEASE" VARCHAR2(2000 BYTE), 
#						"SAMPLE_SOURCE" VARCHAR2(2000 BYTE), 
#							"PMID" VARCHAR2(2000 BYTE)
#
#A0A0B4J1Y8-1	96	Y	C	DOID:2531 / hematologic cancer	icgc	
#A0A0B4J237-1	77	K	E	DOID:1909 / melanoma	icgc	
#A0A0B4J237-1	77	K	E	DOID:1909 / melanoma	tcga	
#
my $index = 1;
open(B, $ARGV[1]) or die "Can't open $ARGV[1]\n";
while($line=<B>) {
	chomp($line);
	my ($ac, $position, $residue_sequence, $residue_mutated, $disease, $sample_source, $pmid) = (split(/\t/, $line))[0, 1, 2, 3, 4, 5, 6];
	my $entry = "";
	$entry .= "biomuta:var_".$index."\n";
	$entry .= "\tbiomuta:protein uniprot:".$ac." ;\n";	
	$entry .= "\tbiomuta:position \"".$position."\"^^xsd:integer ;\n";
	$entry .= "\tbiomuta:residue_sequence \"".$residue_sequence."\" ;\n";	
	$entry .= "\tbiomuta:residue_mutated \"".$residue_mutated."\" ;\n";	
	if($disease) {
		my($doid, $disease_name) = (split(/ \/ /, $disease))[0, 1];
		$doid =~s/:/_/;
		if($doid) {
			$entry .= "\tbiomuta:disease_ontology obo:".$doid." ;\n";	
		}
		if($disease_name) {
			$entry .= "\tbiomuta:disease_name \"".$disease_name."\" ;\n";	
		}
	}
	if($sample_source) {
		$entry .= "\tbiomuta:sample_source \"".$sample_source."\" ;\n";	
	}
	if($pmid) {
		$entry .= "\tbiomuta:pmid \"".$pmid."\" ;\n";	
	}
		$entry =~ s/ \;$/ \./;
	print $entry."\n";
	$index++;
}
close(B);

