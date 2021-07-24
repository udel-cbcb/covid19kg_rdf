while($line=<>) {
	chomp($line);
	($duid, $pmcid, $pmid) = (split(/\t/, $line))[0, 1, 2];
	print $duid."\t";
	if($pmcid) {
		print $pmcid."\n";
	}
	elsif($pmid) {
		print $pmid."\n";
	}
	else {
		print $duid."\n";
	}	
}
