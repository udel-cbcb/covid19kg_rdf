if(@ARGV !=2) {
	print "Usage: perl split_drugbank_xml.pl drugbank_all.xml outputdir\n";
	exit 1;
}

#<?xml version="1.0" encoding="UTF-8"?>
#<drugbank xmlns="http://www.drugbank.ca" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.drugbank.ca http://www.d
#rugbank.ca/docs/drugbank.xsd" version="5.1" exported-on="2020-04-23">
#<drug type="biotech" created="2005-06-13" updated="2020-04-02">

$outDir = $ARGV[1];
open(D, $ARGV[0]) or die "Can't open $ARGV[0]\n";
while($line=<D>) {
	if($line =~ /^<\?xml version/) {
		$xml_line = $line;
	}
	elsif($line =~ /^<drugbank xmlns/) {
		$drugbank_line = $line;
		$count = 1;
	}
	elsif($line =~ /^<\/drugbank>/) {
		$out_file = $outDir."/drugbank0.xml";
		open(OUT, ">", $out_file) or die "Can't open $out_file\n";
		print OUT $xml_line;
		print OUT $drugbank_line;
		print OUT $line;
		close(OUT);	
	}
	elsif($line =~ /^<drug type/) {
		$drug_entry = $line;	
	}
	elsif($line =~ /^<\/drug>/) {
		$drug_entry .= $line;
		$out_file = $outDir."/drugbank".$count.".xml";
		open(OUT, ">", $out_file) or die "Can't open $out_file\n";
		print OUT $xml_line;
		print OUT $drug_entry;
		close(OUT);	
		$count++ 
	}
	else {
		$drug_entry .= $line;
	}		
}
close(D);
