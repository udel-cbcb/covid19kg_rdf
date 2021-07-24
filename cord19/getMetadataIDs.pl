if(@ARGV != 1) {
	print "Usage: perl getMetadataIds.pl metadata_json_dir\n";
	exit 1;
}
my $dir = $ARGV[0];

opendir(DIR, $dir) or die "Can't open $dir\n";

    while (my $file = readdir(DIR)) {

        # Use a regular expression to ignore files beginning with a period
        next if ($file =~ m/^\./);
	if($file =~ /\.json$/) {
		#print "$dir/$file\n";
		my $cord_uid = "";
		my $pmcid = "";
		my $pubmed_id = "";
		open(J, "$dir/$file") or die "Can't open $dir/$file\n";
		while($line=<J>) {
			chomp($line);
			if($line =~ /\"cord_uid\": /) {
				($cord_uid) = (split(": ", $line))[1];
				$cord_uid =~ s/"//g;	
				$cord_uid =~ s/,//g;	
			}
			if($line =~ /\"pmcid\": /) {
				($pmcid) = (split(": ", $line))[1];
				$pmcid =~ s/"//g;	
				$pmcid =~ s/,//g;	
			}
			if($line !~ /doi\.org/ && $line =~ /\"pubmed_id\": /) {
				($pubmed_id) = (split(": ", $line))[1];
				$pubmed_id =~ s/"//g;	
				$pubmed_id =~ s/,//g;	
			}
		}
		print $cord_uid."\t".$pmcid."\t".$pubmed_id."\n";
		close(J);
	}
    }

    closedir(DIR);
