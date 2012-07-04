#This program generate disulifde bonds and link the two cysteiens. 
class Connector

  def initialize(post_frag_seqs)
  @post_frag_seqs = post_frag_seqs      #this is string of fragmented peptides after fragmentation. 
   @mode = post_frag_seqs.collect {|o| o.flatten.join.count("1234")}
  end

  def connect_disulfide	
            
	if @mode[0]== 4   #if the target peptide have four cystiens then do this mode. 
			  array_of_linked_peptides =[]
			  array_of_no_linked_piece = []
			 
			@post_frag_seqs.each do |aiueo|
							  one = []; two = [] ; three = [] ; four = []
							  whole = [] ; trash_can = []    ; onetwo = [] ;  threefour = []           
							  
					  aiueo.each do  |en|  # connects 1 and 2 + # connects 3 and 4. 
							 
									if    en.include?("1") then   one << en
									elsif en.include?("2") then   two << en
									elsif en.include?("3") then   three << en
									elsif en.include?("4") then   four << en
									else  trash_can << en 
									end
								 end
								 
								 onetwo =  (one + two).join
								 threefour = (three + four).join                
								 whole << onetwo << threefour << trash_can
								rr = whole.flatten!.delete_if {|x| x == ""}                   
								  
								  three2 = [] ; four2 = [] ; one2 =[] ; two2 = []
								   trash2 = []   
					  rr.each do |i|       #connects 3 and 4  # connects 1 and 2. 
					
									  if i.include?("3") then  three2 << i
									  elsif i.include?("4") then four2 << i
									  elsif i.include?("1") then one2 << i
									  elsif i.include?("2") then two2 << i
									  else trash2 << i
									  end
								 end
								 
								array_of_linked_peptides << (three2 + four2).join << one2 << two2 << trash2
							    array_of_linked_peptides.flatten!.delete_if {|x| x == ""} 
				   end
			 "Fragmentation of 1234 :"
			 #array_of_no_linked_piece
			  array_of_linked_peptides
        
	elsif @mode[0] == 2     #if the target peptide have two or three peptide then do this. 

		 whole12 =[]
		trash_can12 = []
		@post_frag_seqs.each do |aiueo|
						  one = []; two = [] ; three = [] ; four = []
						  whole = [] ; trash_can = []
						 
				  aiueo.each do  |en|
						 
								if    en.include?("1") or en.include?("3")
								   one << en
								elsif en.include?("2") or en.include?("4")
								   two << en
								else  
								trash_can << en 	
								end                  
							 end                       
							 (one + two).join
							 whole12 << (one + two).join << trash_can
							 
							 whole12.flatten!.delete_if {|x| x == ""}
							 
							 end
						 whole12                    
				  end                          

      end
 end

 
 #connect for two cys (#12)
 #connect for four cys one disulifde (#12) or (#34)
 #connect for four cys two disulifde (#12 and 34)