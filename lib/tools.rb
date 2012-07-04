# This file contain supplmentary codes necessary to run other files. 

class ScreenOutNonChargedFragments
def self.run(fragmented_arrays)
       screen_out_frag_array = []
 fragmented_arrays.map do |we|
					  "with charge #{we}"
					   if we.include?("+")
	screen_out_frag_array   <<  we
					   else 
					   "no charge #{we}" 
					  end
				end	
	screen_out_frag_array	
          end
	end
	
def bin_it(array,delta)
	array.collect {|y| ((y*(1/(delta*2))).round.to_f/(1/(delta*2))).round(2)}
end

def frequency_analyzer(number,name)
 items = Hash.new(0)
  number.each do |i|
		items[i] += 1
  end


mass_frequency = [[],[]]
  items.sort_by {|key,value| value}.each do |key, value|
	mass_frequency[0]	<< key
	mass_frequency[1]   << value
 end
  mass_frequency[0]
  mass_frequency[1]
  mass_frequency[0].size
  mass_frequency[1].size

File.open(name, "w+") do |f| 
   f.puts ""
   f.puts mass_frequency[0]
   f.puts "----------------------"
   f.puts mass_frequency[1]
   end
   
end

 

def compare_match(array1,array2)
	matches = array1.select do |predmz| 
                array2.uniq.any? do |actmz|
                (predmz-actmz).abs.round(3) <= 0.00001
      end
end
end
		  
def compare_uniq(array1,array2,delta)
		match = array1.select do |predictmzs|
			array2.any? do |expmzs|
			 (predictmzs-expmzs).abs.round(2)  <= delta
				        end
			 end
	      array1
		  array2
		  match
	this	= ( array1 - match )
		  end

def eliminate_outside_mass_range(predicted_spectra,low_range,up_range)
succ_in_pop = []
	predicted_spectra.each do |i|
			if i > low_range and i < up_range
				succ_in_pop << i
			end
     end
  succ_in_pop
end

def clasify(input)  #inputs need to be [[4433,34343],[34343,34343]....etc]
store_bin = []
(0..24).collect {|r| store_bin << []}

input.each do |ms|
	if    ms[0].to_f < 100
		store_bin[1] << ms
	elsif ms[0].to_f < 200
		store_bin[2] << ms
	elsif ms[0].to_f < 300
		store_bin[3] << ms
	elsif ms[0].to_f < 400
		store_bin[4] << ms
	elsif ms[0].to_f < 500
		store_bin[5] << ms
	elsif ms[0].to_f < 600
		store_bin[6] << ms
	elsif ms[0].to_f < 700
		store_bin[7] << ms
	elsif ms[0].to_f < 800
		store_bin[8] << ms
	elsif ms[0].to_f < 900
		store_bin[9] << ms
	elsif ms[0].to_f < 1000
		store_bin[10] << ms
	elsif ms[0].to_f < 1100
		store_bin[11] << ms	
	elsif ms[0].to_f < 1200
		store_bin[12] << ms
	elsif ms[0].to_f < 1300
		store_bin[13] << ms
	elsif ms[0].to_f < 1400
		store_bin[14] << ms
	elsif ms[0].to_f < 1500
		store_bin[15] << ms
	elsif ms[0].to_f < 1600
		store_bin[16] << ms
	elsif ms[0].to_f < 1700
		store_bin[17] << ms
	elsif ms[0].to_f < 1800
		store_bin[18] << ms
	elsif ms[0].to_f < 1900
		store_bin[19] << ms
	elsif ms[0].to_f < 2000
		store_bin[20] << ms
	elsif ms[0].to_f < 2100
		store_bin[21] << ms
	elsif ms[0].to_f < 2200
		store_bin[22] << ms
	elsif ms[0].to_f < 2300
		store_bin[23] << ms
	else ms[0].to_f < 2400
		store_bin[24] << ms
   end
 end
  	store_bin
end