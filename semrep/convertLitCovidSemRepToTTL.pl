if(@ARGV != 3) {
	print "Usage: perl convertLitCovidSemRepToTTL.pl litcovid_pmid.txt LitCovid.SemRep litcovid_semrep\n";
	exit 1;
}

my $semrep = "<https://semrep.nlm.nih.gov/";
my $base = "<https://semrep.nlm.nih.gov/covid19/litcovid#";
my $int = "^^<http://www.w3.org/2001/XMLSchema#int>";
my %pmids = ();
my $pmid_file = $ARGV[0];
my $input_dir = $ARGV[1];
$input_dir =~ s/\/$//;
my $output_dir = $ARGV[2];
$output_dir =~ s/\/$//;
open(PM, $pmid_file) or die "Can't open $ARGV[0]\n";
while($line=<PM>) {
	chomp($line);
	$pmids{$line} = 1;
}
close(PM);

for my $pmid (keys(%pmids)) {
	$ttl = convertSemRepToTTL($input_dir, $pmid, $output_dir);
	if($ttl) {
		#print $ttl;
		$ttl_file = $output_dir."/".$pmid.".ttl";
		open(TTL, ">".$ttl_file) or die "Can't open $ttl_file\n";
		print TTL $ttl;	
		close(TTL);
	}  
}

sub convertSemRepToTTL {
	my ($input_dir, $pmid, $output_dir) = @_;
	#print $input_dir."\t".$pmid."\t".$output_dir."\n";	
	$semrep_file = $input_dir."/".$pmid.".txt.out";
	if(-e $semrep_file) {
		$ttl = "[\n";
		$ttl .= "	".$base."_id> \"".$pmid."\" ;\n"; 
		$ttl .= "	".$base."id> \"".$pmid."\" ;\n"; 
		open(S, $semrep_file) or die "Can't open $semrep_file\n";
		my $text = "";
		my %entities = ();
		my %corefs = ();
		my %relations = ();
		my $ent = "";
		my $rel = "";
		my $cor = "";
		while($line=<S>) {
			#print $line;
			if($line =~ /^$/) {
				$ann = "\n	".$base."annotations>\n";
				$ann .=  "	[\n";
				$ann .=  "	".$text."\n";
				for my $entity (keys(%entities)) {
					$ent .= $entity;
				}
				$ann .= $ent;
				#$ann =~ s/;$/\n/;	
				for my $coref (keys(%corefs)) {
					$cor .= $coref;
				}
				$ann .= $cor;
				for my $relation (keys(%relations)) {
					$rel .= $relation;
				}
				$ann .= $rel;
				$ann =~ s/;$/\n/;	
				$ann.= "	] ;";
				$ttl .= $ann;	
				$text = "";
				%entities = ();
				%relations = ();
				%corefs = ();
				$ann = "";
				$ent = "";
				$rel = "";
				$cor = "";
			}
			else {
				chomp($line);
				my @rec = split(/\|/, $line);
				my $size = @rec;	
				if($rec[5] eq "text") {
				 	$text = parseText($line)."\n";
				}
				elsif($rec[5] eq "entity") {
					$entities{parseEntity($line)} = 1;
				} 
				elsif($rec[5] eq "coreference") {
					$corefs{parseCoref($line)} = 1;
				} 
				elsif($rec[5] eq "relation") {
					$relations{parseRelation($line)} = 1;
				} 
			}
		}		
		close(S);
		$ttl =~ s/;$/\n/;
		$ttl .= "\n].\n";
	}
}

sub parseRelation {
	my ($line) = @_;
	my @rec = split(/\|/, $line);
	my $size = @rec;	
	my $relation = "";	
	my $sentence_id = $rec[4];
	my $subject_max_dist = $rec[6];
	my $subject_dist = $rec[7];
	my $subject_cui = $rec[8];
	my $subject_preferred_name = $rec[9];
	$subject_preferred_name =~ s/"/'/g;
	my $subject_semantic_type = $rec[10];
	my $subject_semantic_type_for_relation = $rec[11];
	my $subject_gene_ids = $rec[12];		
	$subject_gene_ids =~ s/"//g;
	my $subject_gene_names = $rec[13];		
	$subject_gene_names =~ s/"//g;
	my $subject_text = $rec[14];		
	$subject_text =~ s/"/'/g;
	my $subject_change_term = $rec[15];		
	my $subject_degree_term = $rec[16];		
	my $subject_negation_term = $rec[17];		
	my $subject_score = $rec[18];		
	my $subject_char_start = $rec[19];		
	my $subject_char_end = $rec[20];
	my $indicator_type = $rec[21]; #Possible values: PREP (preposition), MOD/HEAD (intra-NP relation), VERB (verb), NOM (nominalization), SPEC (hypernymy), INFER (inference)
	my $predicate = $rec[22];
	my $relation_negation = $rec[23];
	my $relation_char_start = $rec[24];
	my $relation_char_end = $rec[25];
	my $object_max_dist = $rec[26];
	my $object_dist = $rec[27];
	my $object_cui = $rec[28];
	my $object_preferred_name = $rec[29];
	$object_preferred_name =~ s/"/'/g;
	my $object_semantic_type = $rec[30];
	my $object_semantic_type_for_relation = $rec[31];
	my $object_gene_ids = $rec[32];		
	 $object_gene_ids =~ s/"//g;		
	my $object_gene_names = $rec[33];		
	 $object_gene_names =~ s/"//g;		
	my $object_text = $rec[34];		
	$object_text =~ s/"/'/g;
	my $object_change_term = $rec[35];		
	my $object_degree_term = $rec[36];		
	my $object_negation_term = $rec[37];		
	my $object_score = $rec[38];		
	my $object_char_start = $rec[39];		
	my $object_char_end = $rec[40];
	
	$relation .= "		 ".$base."relation> \n";
	$relation .= "		[\n";
	$relation .= "			a ".$semrep."Relation> ;\n";
	if($sentence_id ne "") {
		$relation .= "			".$base."sentence_id>  \"".$sentence_id."\" ;\n";
	}
	if($subject_max_dist ne "") {
		$relation .= "			".$base."subject_max_dist> \"".$subject_max_dist."\"".$int." ;\n";
	}
	if($subject_dist ne "") {
		$relation .= "			".$base."subject_dist> \"".$subject_dist."\"".$int." ;\n";
	}
	if($subject_cui ne "") {
		$relation .= "			".$base."subject_cui>  \"".$subject_cui."\" ;\n";
	}
	if($subject_preferred_name ne "") {
		$relation .= "			".$base."subject_preferred_name>  \"".$subject_preferred_name."\" ;\n";
	}
	$subject_st = "";
        $subject_ge = "";
        $subject_gn = "";
	my @types = split(/,/, $subject_semantic_type);
        foreach(@types) {
                $subject_st .= $semrep."semantic_type/".$_.">, ";
        }
        $subject_st =~ s/\, $//;
	if($subject_st ne "") {
        	$relation .= "			".$base."subject_semantic_type> ".$subject_st." ;\n";
	}
	if($subject_semantic_type_for_relation ne "") {
        	$relation .= "			".$base."subject_semantic_type_for_relation> ".$semrep."semantic_type/".$subject_semantic_type_for_relation."> ;\n";
	}
        if($subject_gene_ids ne "") {
                my @geneIds = split(/,/, $subject_gene_ids);
                foreach(@geneIds) {
                        $subject_ge .= "\"".$_."\", ";
                }
		$subject_ge =~ s/, $//;
                $relation .= "			".$base."subject_gene_id> ".$subject_ge." ;\n";
        }			
        if($subject_gene_names ne "") {
                my @geneNames = split(/,/, $subject_gene_names);
                foreach(@geneNames) {
                        $subject_gn .= "\"".$_."\", ";
                }
		$subject_gn =~ s/, $//;
                $relation .= "			".$base."subject_gene_name> ".$subject_gn." ;\n";
	}
	if($subject_text ne "") {
        	$relation .= "			".$base."subject_text> \"".$subject_text."\" ;\n";
	}
	if($subject_change_term ne "") {
        	$relation .= "			".$base."subject_change_term> \"".$subject_change_term."\" ;\n";
	}
	if($subject_degree_term ne "") {
        	$relation .= "			".$base."subject_degree_term> \"".$subject_degree_term."\" ;\n";
	}
	if($subject_negation_term ne "") {
        	$relation .= "			".$base."subject_negation_term> \"".$subject_negation_term."\" ;\n";
	}
	if($subject_score ne "") {
        	$relation .= "			".$base."subject_score> \"".$subject_score."\"".$int." ;\n";
	}
	if($subject_char_start ne "") {
        	$relation .= "			".$base."subject_char_start> \"".$subject_char_start."\"".$int." ;\n";
	}
	if($subject_char_end ne "") {
        	$relation .= "			".$base."subject_char_end> \"".$subject_char_end."\"".$int." ;\n";
	}
	if($indicator_type ne "") {
        	$relation .= "			".$base."indicator_type> \"".$indicator_type."\" ;\n";
	}
	if($predicate ne "") {
        	$relation .= "			".$semrep."predicate> \"".$predicate."\" ;\n";
	}
	#if($relation_negation ne "") {
        	$relation .= "			".$base."relation_negation> \"".$relation_negation."\" ;\n";
	#}
	if($relation_char_start ne "") {
        	$relation .= "			".$base."relation_char_start> \"".$relation_char_start."\"".$int." ;\n";
	}
	if($relation_char_end ne "") {
        	$relation .= "			".$base."relation_char_end> \"".$relation_char_end."\"".$int." ;\n";
	}
	if($object_max_dist ne "") {
		$relation .= "			".$base."object_max_dist> \"".$object_max_dist."\"".$int." ;\n";
	}
	if($object_dist ne "") {
		$relation .= "			".$base."object_dist> \"".$object_dist."\"".$int." ;\n";
	}
	if($object_cui ne "") {
		$relation .= "			".$base."object_cui>  \"".$object_cui."\" ;\n";
	}
	if($object_preferred_name ne "") {
		$relation .= "			".$base."object_preferred_name>  \"".$object_preferred_name."\" ;\n";
	}
	$object_st = "";
        $object_ge = "";
        $object_gn = "";
	if($object_semantic_type ne "") {
		my @types = split(/,/, $object_semantic_type);
        	foreach(@types) {
                	$object_st .= $semrep."semantic_type/".$_.">, ";
        	}
        	$object_st =~ s/\, $//;
        	$relation .= "			".$base."object_semantic_type> ".$object_st." ;\n";
	}
	if($object_semantic_type_for_relation ne "") {
        	$relation .= "			".$base."object_semantic_type_for_relation> ".$semrep."semantic_type/".$object_semantic_type_for_relation."> ;\n";
	}
        if($object_gene_ids ne "") {
                my @geneIds = split(/,/, $object_gene_ids);
                foreach(@geneIds) {
                        $object_ge .= "\"".$_."\", ";
                }
		$object_ge =~ s/, $//;
                $relation .= "			".$base."object_gene_id> ".$object_ge." ;\n";
        }			
        if($object_gene_names ne "") {
                my @geneNames = split(/,/, $object_gene_names);
                foreach(@geneNames) {
                        $object_gn .= "\"".$_."\", ";
                }
		$object_gn =~ s/, $//;
                $relation .= "			".$base."object_gene_name> ".$object_gn." ;\n";
	}
	if($object_text ne "") {
        	$relation .= "			".$base."object_text> \"".$object_text."\" ;\n";
	}
	if($object_change_term ne "") {
        	$relation .= "			".$base."object_change_term> \"".$object_change_term."\" ;\n";
	}
	if($object_degree_term ne "") {
        	$relation .= "			".$base."object_degree_term> \"".$object_degree_term."\" ;\n";
	}
	if($object_negation_term ne "") {
        	$relation .= "			".$base."object_negation_term> \"".$object_negation_term."\" ;\n";
	}
	if($object_score ne "") {
        	$relation .= "			".$base."object_score> \"".$object_score."\"".$int." ;\n";
	}
	if($object_char_start ne "") {
        	$relation .= "			".$base."object_char_start> \"".$object_char_start."\"".$int." ;\n";
	}
	if($object_char_end ne "") {
        	$relation .= "			".$base."object_char_end> \"".$object_char_end."\"".$int." ;\n";
	}
	
	$relation .= "		];\n";
	return $relation;
}

sub parseEntity {
	my ($line) = @_;
	#print $line;
	my @rec = split(/\|/, $line);
	my $size = @rec;	
	my $entity = "";	
	my $sentence_id = $rec[4];
	my $cui = $rec[6];
	my $preferred_name = $rec[7];
	$preferred_name =~ s/"/'/g;
	my $semantic_type = $rec[8];
	my $gene_ids = $rec[9];
	$gene_ids =~ s/"//g; 
	my $gene_names = $rec[10];
	$gene_names =~ s/"//g; 
	my $entity_text = $rec[11];
	 $entity_text =~ s/"/'/g; 
	 $entity_text =~ s/\\/|/g; 
	my $change_term = $rec[12];
	my $degree_term = $rec[13];
	my $negation_term = $rec[14];
	my $score = $rec[15];
	my $char_start = $rec[16];
	my $char_end = $rec[17];
	
	$entity .= "		 ".$base."entity> \n";
	$entity .= "		[\n";
	$entity .= "			a ".$semrep."Entity> ;\n";
	if($sentence_id ne "") {
		$entity .= "			".$base."sentence_id>  \"".$sentence_id."\" ;\n";
	}
	if($cui ne "") {
		$entity .= "			".$semrep."cui> \"".$cui."\" ;\n";
	}
	if($preferred_name ne "") {
		$entity .= "			".$base."preferred_name>  \"".$preferred_name."\" ;\n";
	}
	$st = "";
	$ge = "";
	$gn = "";
	if($semantic_type ne "") {
		@types = split(/,/, $semantic_type);
		foreach(@types) {	
			$st .= $semrep."semantic_type/".$_.">, ";
		}
		$st =~ s/\, $//;	
		if(st ne "") {
			$entity .= "			".$base."semantic_type> ".$st." ;\n";
		}
	}
	if($gene_ids ne "") {
		@geneIds = split(/,/, $gene_ids);
		foreach(@geneIds) {	
			$ge .= "\"".$_."\", ";
		}
		$ge =~ s/, $//;
		$entity .= "			".$base."gene_id> ".$ge." ;\n";
	}
	if($gene_names ne "") {
		@geneNames = split(/,/, $gene_names);
		foreach(@geneNames) {	
			$gn .= "\"".$_."\", ";
		}
		$gn =~ s/, $//;
		$entity .= "			".$base."gene_name> ".$gn." ;\n";
	}
	if($entity_text ne "") {
		$entity .= "			".$base."entity_text>  \"".$entity_text."\" ;\n";
	}
	if($change_term ne "") {
		$entity .= "			".$base."change_term> \"".$change_term."\" ;\n";
	}
	if($degree_term ne "") {
		$entity .= "			".$base."degree_term> \"".$degree_term."\" ;\n";
	}
	if($negation_term ne "") {
		$entity .= "			".$base."negation_term> \"".$negation_term."\" ;\n";
	}
	if($score ne "") {
		$entity .= "			".$semrep."score> \"".$score."\"".$int." ;\n";
	}
	if($char_start ne "") {
		$entity .= "			".$base."char_start> \"".$char_start."\"".$int." ;\n";
	}
	if($char_end ne "") {
		$entity .= "			".$base."char_end> \"".$char_end."\"".$int."\n";
	}
	
	
	$entity .= "		];\n";
	return $entity;
}

sub parseText {
	my ($line) = @_;
	#print $line;
	my @rec = split(/\|/, $line);
	my $size = @rec;	
	$subsection = $rec[2];
	$ti_ab = $rec[3];
	$sentence_id = $rec[4];
	$char_start = $rec[6];
	$char_end = $rec[7];
	$text = $rec[8];
	$text =~ s/\[//g;
	$text =~ s/\]//g;
	$text =~ s/"/'/g;
	$text =~ s/\\/|/g;

	if($sentence_id ne "") {	
		$utterance = "	".$base."sentence_id>  \"".$sentence_id."\" ;\n";
	}
	if($text ne "") {
		$utterance .= "		".$base."text>  \"".$text."\"\@en ;\n";
	}
	if($ti_ab eq "ti") {
		$utterance .= "		".$base."sentence_loc>  \"TITLE\" ;\n";
	}
	if($ti_ab eq "ab") {
		$utterance .= "		".$base."sentence_loc>  \"ABSTRACT\" ;\n";
	}
	if($subsection ne ""){
		$utterance .= "		".$base."subsection>  \"".$subsection."\" ;\n";
	}
	if($char_start ne "") {
		$utterance .= "		".$base."char_start> \"".$char_start."\"".$int." ;\n"; 	
	}
	if($char_end ne "") {
		$utterance .= "		".$base."char_end> \"".$char_end."\"".$int." ;"; 	
	}
	return $utterance;
}

sub parseCoref {
	my ($line) = @_;
	my @rec = split(/\|/, $line);
	my $size = @rec;	
	my $coref = "";	
	my $sentence_id = $rec[4];
	my $anaphor_cui = $rec[6];
	my $anaphor_preferred_name = $rec[7];
	$anaphor_preferred_name =~ s/"/'/g;
	my $anaphor_semantic_type = $rec[8];
	my $anaphor_gene_ids = $rec[9];		
	$anaphor_gene_ids =~ s/"//g;		
	my $anaphor_gene_names = $rec[10];		
	$anaphor_gene_names =~ s/"//g;		
	my $anaphor_text = $rec[11];		
	$anaphor_text =~ s/"/'/g;		
	my $anaphor_change_term = $rec[12];		
	my $anaphor_degree_term = $rec[13];		
	my $anaphor_negation_term = $rec[14];		
	my $anaphor_score = $rec[15];		
	my $anaphor_char_start = $rec[16];		
	my $anaphor_char_end = $rec[17];
	my $coref_type = $rec[18];
	my $antecedent_cui = $rec[19];
	my $antecedent_preferred_name = $rec[20];
	$antecedent_preferred_name =~ s/"/'/g;
	my $antecedent_semantic_type = $rec[21];
	my $antecedent_gene_ids = $rec[22];		
	$antecedent_gene_ids =~ s/"//g;
	my $antecedent_gene_names = $rec[23];		
	$antecedent_gene_names =~ s/"//g;
	my $antecedent_text = $rec[24];		
	$antecedent_text =~ s/"/'/g;		
	my $antecedent_change_term = $rec[25];		
	my $antecedent_degree_term = $rec[26];		
	my $antecedent_negation_term = $rec[27];		
	my $antecedent_score = $rec[28];		
	my $antecedent_char_start = $rec[29];		
	my $antecedent_char_end = $rec[30];
	
	$coref .= "		 ".$base."coreference> \n";
	$coref .= "		[\n";
	$coref .= "			a ".$semrep."Relation> ;\n";
	if($sentence_id ne "") {
		$coref .= "			".$base."sentence_id>  \"".$sentence_id."\" ;\n";
	}
	if($anaphor_max_dist ne "") {
		$coref .= "			".$base."anaphor_max_dist> \"".$anaphor_max_dist."\"".$int." ;\n";
	}
	if($anaphor_dist ne "") {
		$coref .= "			".$base."anaphor_dist> \"".$anaphor_dist."\"".$int." ;\n";
	}
	if($anaphor_cui ne "") {
		$coref .= "			".$base."anaphor_cui>  \"".$anaphor_cui."\" ;\n";
	}
	if($anaphor_preferred_name ne "") {
		$coref .= "			".$base."anaphor_preferred_name>  \"".$anaphor_preferred_name."\" ;\n";
	}
	$anaphor_st = "";
        $anaphor_ge = "";
        $anaphor_gn = "";
	if($semantic_type ne "") {
		my @types = split(/,/, $anaphor_semantic_type);
        	foreach(@types) {
                	$anaphor_st .= $semrep."semantic_type/".$_.">, ";
        	}
        	$anaphor_st =~ s/\, $//;
       		$coref .= "			".$base."anaphor_semantic_type> ".$anaphor_st." ;\n";
	}
        if($anaphor_gene_ids ne "") {
                my @geneIds = split(/,/, $anaphor_gene_ids);
                foreach(@geneIds) {
                        $anaphor_ge .= "\"".$_."\", ";
                }
		$anaphor_ge =~ s/, $//;
                $coref .= "			".$base."anaphor_gene_id> ".$anaphor_ge." ;\n";
        }			
        if($anaphor_gene_names ne "") {
                my @geneNames = split(/,/, $anaphor_gene_names);
                foreach(@geneNames) {
                        $anaphor_gn .= "\"".$_."\", ";
                }
		$anaphor_gn =~ s/, $//;
                $coref .= "			".$base."anaphor_gene_name> ".$anaphor_gn." ;\n";
	}
	if($anaphor_text ne "") {
        	$coref .= "			".$base."anaphor_text> \"".$anaphor_text."\" ;\n";
	}
	if($anaphor_change_term ne "") {
        	$coref .= "			".$base."anaphor_change_term> \"".$anaphor_change_term."\" ;\n";
	}
	if($anaphor_degree_term ne "") {
        	$coref .= "			".$base."anaphor_degree_term> \"".$anaphor_degree_term."\" ;\n";
	}
	if($anaphor_negation_term ne "") {
        	$coref .= "			".$base."anaphor_negation_term> \"".$anaphor_negation_term."\" ;\n";
	}
	if($anaphor_score ne "") {
        	$coref .= "			".$base."anaphor_score> \"".$anaphor_score."\"".$int." ;\n";
	}
	if($anaphor_char_start ne "") {
        	$coref .= "			".$base."anaphor_char_start> \"".$anaphor_char_start."\"".$int." ;\n";
	}
	if($anaphor_char_end ne "") {
        	$coref .= "			".$base."anaphor_char_end> \"".$anaphor_char_end."\"".$int." ;\n";
	}
	if($coref_type ne "") {
        	$coref .= "			".$base."coreference_type> \"".$coref_type."\" ;\n";
	}
	if($antecedent_max_dist ne "") {
		$coref .= "			".$base."antecedent_max_dist> \"".$antecedent_max_dist."\"".$int." ;\n";
	}
	if($antecedent_dist ne "") {
		$coref .= "			".$base."antecedent_dist> \"".$antecedent_dist."\"".$int." ;\n";
	}
	if($antecedent_cui ne "") {
		$coref .= "			".$base."antecedent_cui>  \"".$antecedent_cui."\" ;\n";
	}
	if($antecedent_preferred_name ne "") {
		$coref .= "			".$base."antecedent_preferred_name>  \"".$antecedent_preferred_name."\" ;\n";
	}
	$antecedent_st = "";
        $antecedent_ge = "";
        $antecedent_gn = "";
	if($antecedent_semantic_type ne "") {
		my @types = split(/,/, $antecedent_semantic_type);
        	foreach(@types) {
                	$antecedent_st .= $semrep."semantic_type/".$_.">, ";
        	}
        	$antecedent_st =~ s/\, $//;
        	$coref .= "			".$base."antecedent_semantic_type> ".$antecedent_st." ;\n";
	}
        if($antecedent_gene_ids ne "") {
                my @geneIds = split(/,/, $antecedent_gene_ids);
                foreach(@geneIds) {
                        $antecedent_ge .= "\"".$_."\", ";
                }
		$antecedent_ge =~ s/, $//;
                $coref .= "			".$base."antecedent_gene_id> ".$antecedent_ge." ;\n";
        }			
        if($antecedent_gene_names ne "") {
                my @geneNames = split(/,/, $antecedent_gene_names);
                foreach(@geneNames) {
                        $antecedent_gn .= "\"".$_."\", ";
                }
		$antecedent_gn =~ s/, $//;
                $coref .= "			".$base."antecedent_gene_name> ".$antecedent_gn." ;\n";
	}
	if($antecedent_text ne "") {
        	$coref .= "			".$base."antecedent_text> \"".$antecedent_text."\" ;\n";
	}
	if($antecedent_change_term ne "") {
        	$coref .= "			".$base."antecedent_change_term> \"".$antecedent_change_term."\" ;\n";
	}
	if($antecedent_degree_term ne "") {
        	$coref .= "			".$base."antecedent_degree_term> \"".$antecedent_degree_term."\" ;\n";
	}
	if($antecedent_negation_term ne "") {
        	$coref .= "			".$base."antecedent_negation_term> \"".$antecedent_negation_term."\" ;\n";
	}
	if($antecedent_score ne "") {
        	$coref .= "			".$base."antecedent_score> \"".$antecedent_score."\"".$int." ;\n";
	}
	if($antecedent_char_start ne "") {
        	$coref .= "			".$base."antecedent_char_start> \"".$antecedent_char_start."\"".$int." ;\n";
	}
	if($antecedent_char_end ne "") {
        	$coref .= "			".$base."antecedent_char_end> \"".$antecedent_char_end."\"".$int." ;\n";
	}	
	$coref .= "		];\n";
	return $coref;
}
