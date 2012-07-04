#This program make theortical heterolytic and homolytic disulifde cleaved peptide fragments. 
class MakeFragmentsFromDisulfideCleavages
    
	def self.run(pep_sequence,single_disulfide_mode)
	   array_of_hete_homo = (0..1).collect do |f|
				if single_disulfide_mode == true
						 sul_arr = Sul_breaker.run(pep_sequence)[f].flatten.collect do |e|
						 sul_f = Fragmentor.new(e)
						 sul_fra = sul_f.fragmentation
							(sul_fra[0] + sul_fra[3])
						 end
				elsif pep_sequence.count("C1234") == 4
				
					 pre_sul_arr = Sul_breaker.run(pep_sequence)[f].flatten.collect do |e|
								sul_f = Fragmentor.new(e)
								sul_fra = sul_f.single_connected_fragmentation
						 end
						sul_c = Connector.new(pre_sul_arr.flatten(1))
						sul_arr = sul_c.connect_disulfide
				else
						sul_arr = Sul_breaker.run(pep_sequence)[f].flatten.collect do |e|    ##if you want homolytic cleavage, delete [0]
								sul_f = Fragmentor.new(e)
								sul_fra = sul_f.fragmentation
								(sul_fra[0] + sul_fra[3]) # b and y
						  end
				 end
			sul_arr.flatten
		end
		 array_of_hete_homo 
	end
end
