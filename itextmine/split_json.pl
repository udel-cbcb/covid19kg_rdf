if(@ARGV != 2) {
	print "Usage: perl split_json.pl input.json outdir\n";
	exit 1;
}

use File::Basename;

my $index = 0;
my $outdir = $ARGV[1];
my $json = basename($ARGV[0]);
$json =~ s/\.json//;
open(I, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while ($line=<I>){
    $index++;
    chomp($line);
    # process line
    $line =~ s/^,//;
    $line =~ s/^\[//;
    $line =~ s/: undefined/: ""/g;
    open(O, ">".$outdir."/".$json.".".$index.".json") or die "Can't write to $outdir/".$json.".".$index.".json";
    print O $line;
    close(O);
}
close(I);
