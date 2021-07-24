my $dir = $ARGV[0];

opendir(DIR, $dir) or die $!;

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
