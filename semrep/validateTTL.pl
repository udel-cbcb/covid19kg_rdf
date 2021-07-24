if(@ARGV !=1) {
	print "Usage: perl validateTTL.pl ttl_dir\n";
	exit 1;
}

my $dir = $ARGV[0];

opendir(DIR, $dir) or die "Can't open $!";

    while (my $file = readdir(DIR)) {

        # Use a regular expression to ignore files beginning with a period
        next if ($file =~ m/^\./);
	if($file =~ /\.ttl$/) {
		$report =`ttl $dir/$file`;
		print "$dir/$file\n";
		print $report;
		if($report !~ "Validator finished with 0 warnings and 0 errors.") {
			print "mv $dir/$file $dir/$file.bad\n";	
		}		
	}
    }

    closedir(DIR);
