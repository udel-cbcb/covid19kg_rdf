if(@ARGV != 1) {
	print "Usage: perl convertSemanticTypesToTTL.pl SemRepSemanticTypes.txt\n";
	exit 1;
}

open(SST, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<SST>) {
	chomp($line);
	my ($semantic_type, $tui, $text) = (split(/\|/, $line))[0, 1, 2];
	print "<https://semrep.nlm.nih.gov/semantic_type/".$semantic_type."> a <https://semrep.nlm.nih.gov/SemanticType> .\n";
	print "<https://semrep.nlm.nih.gov/semantic_type/".$semantic_type."> <https://semrep.nlm.nih.gov/tui> \"".$tui."\".\n";
	print "<https://semrep.nlm.nih.gov/semantic_type/".$semantic_type."> <http://www.w3.org/2000/01/rdf-schema#label> \"".$semantic_type."\".\n";
	print "<https://semrep.nlm.nih.gov/semantic_type/".$semantic_type."> <http://www.w3.org/2000/01/rdf-schema#comment> \"".$text."\".\n\n";
}
close(SST);
