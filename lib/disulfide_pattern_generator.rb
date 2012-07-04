#This program generates all the disulifde bonding pattern in a peptide given number of cysteines. 	
class DisulfidePatternGenerator
	def initialize(pep_seq)
		@pep_seq = pep_seq
	end
	#detecing modes ; And "1" and "2" gets linked. "3" and "4" gets linked. 
	#if single_disulfide_mode is not "on" then, by default, four "C" will leads to double disulfide bonds. 
	#whereas if you have single_disulfide_mode "on, I make six combination of single disulifde bonding with four cysteines.
	def generate_disulfide_pattern(single_disulfide_mode)
	if single_disulfide_mode == true
		@pep_seq_in = ["2","2","=","="].permutation.to_a.uniq.collect do |all_combi_no_dupli|
					@pep_seq.sub("C",all_combi_no_dupli[0]).sub("C",all_combi_no_dupli[1]).sub("C",all_combi_no_dupli[2]).sub("C",all_combi_no_dupli[3])
													end	
		puts pep_sequence_array = @pep_seq_in.collect {|u| u.sub("2","1").gsub!(/[=]/, '='=>'C')}
	elsif @pep_seq.count("C") == 4
		#Three possible patterns
		pep_sequence_array = [@pep_seq.sub("C","1").sub("C","2").sub("C","3").sub("C","4"),   
						      @pep_seq.sub("C","1").sub("C","3").sub("C","4").sub("C","2"),   
						      @pep_seq.sub("C","1").sub("C","3").sub("C","2").sub("C","4")]
		 "Possible patterns are: 1-2, 3-4 are pairs"
		 pep_sequence_array
	elsif @pep_seq.count("C") == 3
		
	 @pep_seq_in = ["2","2","="].permutation.to_a.uniq.collect do |all_combi_no_dupli|
	 
					@pep_seq.sub("C",all_combi_no_dupli[0]).sub("C",all_combi_no_dupli[1]).sub("C",all_combi_no_dupli[2])
													end												
		pep_sequence_array = @pep_seq_in.collect {|u| u.sub("2","1").gsub!(/[=]/, '='=>'C')}
	elsif @pep_seq.count("C") == 2
		pep_sequence_array = [@pep_seq.sub("C","1").sub("C","2")]
		
	elsif @pep_seq.count("C") ==1 
		p "one cysteine => no disulifde bond formation, use other system"
	else 
		p "no_cysteine => use other system"
	end
  end
 end
 
