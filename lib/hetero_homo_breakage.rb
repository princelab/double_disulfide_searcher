#This program make theortical heterolytic and homolytic disulifde cleaved peptide fragments. 
class Sul_breaker
	  
	def self.run(aaseq)
	
	if aaseq.count("1234") == 4

  #heterolytic cleavages 
    heteroA = aaseq.clone.gsub!(/[12]/, '1' => '<', '2' => '>')
    heteroB = aaseq.clone.gsub!(/[12]/, '2' => '<', '1' => '>')
	heteroC1 = aaseq.clone.gsub!(/[34]/, '3' => '<', '4' => '>')
	heteroC2 = aaseq.clone.gsub!(/[34]/, '4' => '<', '3' => '>')
	 #homolytic cleavages. #replace 1 with ? or ! #replace 2 with 2 or 1. 
	homoC1 = aaseq.clone.gsub!(/[12]/, '1' => '?', '2' => '!')
	homoC2 = aaseq.clone.gsub!(/[12]/, '2' => '?', '1' => '!')
	homoC3 = aaseq.clone.gsub!(/[34]/, '3' => '?', '4' => '!')
	homoC4 = aaseq.clone.gsub!(/[34]/, '4' => '?', '3' => '!')
	
   [[heteroA,heteroB,heteroC1,heteroC2],[homoC1,homoC2,homoC3,homoC4]]  
   
    elsif aaseq.count("12") == 2
	heteroA = aaseq.clone.gsub!(/[12]/, '1' => '<', '2' => '>')  
    heteroB = aaseq.clone.gsub!(/[12]/, '2' => '<', '1' => '>')
    homoC1 = aaseq.clone.gsub!(/[12]/, '1' => '?', '2' => '!')
	homoC2 = aaseq.clone.gsub!(/[12]/, '2' => '?', '1' => '!')
	
    [[heteroA,heteroB],[homoC1,homoC2]]
	
	else  p "no disulfid bonds"
	    ["UUUUUUUUUUUUUUUUUUUUUUU"]
	
    end
end
end