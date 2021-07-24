if(@ARGV != 2) {
	print "Usage: perl split_json.pl input.json outdir\n";
	exit 1;
}
my $index = 0;
my $outdir = $ARGV[1];
open(I, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while ($line=<I>){
    $index++;
    chomp($line);
    # process line
    $line =~ s/^,//;
    $line =~ s/^\[//;
    open(O, ">".$outdir."/doc".$index.".json") or die "Can't write to $outdir/doc".$index.".json";
    print O $line;
    close(O);
}
close(I);
