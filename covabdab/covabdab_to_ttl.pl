#print "\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n";
print "\@prefix covabdab: <http://opig.stats.ox.ac.uk/webapps/covabdab#> .\n\n";
while($line=<>) {
	if($line !~ /^Name/) {
	chomp($line);
	$line =~ s/\"/\'/g;
 ($Name, $Ab_or_Nb, $Binds_to,$Does_not_Bind_to, $Neutralising_Vs, $Not_Neutralising_Vs, $Protein_Epitope, $Origin, $VH_or_VHH,	$VL, $Heavy_V_Gene, $Heavy_J_Gene,$Light_V_Gene,$Light_J_Gene, $CDRH3, $CDRL3, $Structures, $ABB_Homology_Model,$Sources, $Date_Added,$Last_Updated,$Update_Description, $Notes_Following_Up) = (split(/\t/, $line))[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];	
	$id = $Name;
	$id =~ s/ /_/g;
	print "<http://opig.stats.ox.ac.uk/webapps/covabdab/".$id.">\n";
	print "	covabdab:Name	\"".$Name."\" ; \n";
	print "	covabdab:Ab_or_Nb	\"".$Ab_or_Nb."\" ; \n";
	print "	covabdab:Binds_to	\"".$Binds_to."\" ; \n";
	print "	covabdab:Does_not_Bind_to	\"".$Does_not_Bind_to."\" ; \n";
	print "	covabdab:Neutralising_Vs	\"".$Neutralising_Vs."\" ; \n";
	print "	covabdab:Not_Neutralising_Vs	\"".$Not_Neutralising_Vs."\" ; \n";
	print "	covabdab:Protein_Epitope	\"".$Protein_Epitope."\" ; \n";
	print "	covabdab:Origin	\"".$Origin."\" ; \n";
	print "	covabdab:VH_or_VHH	\"".$VH_or_VHH."\" ; \n";
	print "	covabdab:VL	\"".$VL."\" ; \n";
	print "	covabdab:Heavy_V_Gene	\"".$Heavy_V_Gene."\" ; \n";
	print "	covabdab:Heavy_J_Gene	\"".$Heavy_J_Gene."\" ; \n";
	print "	covabdab:Light_V_Gene	\"".$Light_V_Gene."\" ; \n";
	print "	covabdab:Light_J_Gene	\"".$Light_J_Gene."\" ; \n";
	print "	covabdab:CDRH3	\"".$CDRH3."\" ; \n";
	print "	covabdab:CDRL3	\"".$CDRL3."\" ; \n";
	print "	covabdab:Structures	\"".$Structures."\" ; \n";
	print "	covabdab:ABB_Homology_Model	\"".$ABB_Homology_Model."\" ; \n";
	print "	covabdab:Sources	\"".$Sources."\" ; \n";
	print "	covabdab:Date_Added	\"".$Date_Added."\" ; \n";
	print "	covabdab:Last_Updated	\"".$Last_Updated."\" ; \n";
	print "	covabdab:Update_Description	\"".$Update_Description."\" ; \n";
	print "	covabdab:Notes_Following_Up	\"".$Notes_Following_Up."\" . \n";
	print "\n";
	}
}



