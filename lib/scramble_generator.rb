#This program generate randmo fragments.  
def scramble_generator_for_uniq_fragmentation(up_range,low_range,mass_tolerance)
 population = ((up_range-low_range)/(mass_tolerance*2)).round(0)
 array_of_no = (1..20000).map {|i| i*0.15}
 array_of_no_binned =  array_of_no.collect {|y| ((y*(1/(mass_tolerance*2))).round.to_f/(1/(mass_tolerance*2))).round(2)}
 array_trim = array_of_no_binned.uniq.delete_if {|d| d > up_range or d < low_range}
 array_trim.sample(1000)
 end
 
def generate_random_peptide_from_20AA(no_residues)
	["G","A","V","L","I","M","F","W","P","S","T","C","Y","N","Q","D","E","K","R","H"].sample(no_residues).join
	end	
