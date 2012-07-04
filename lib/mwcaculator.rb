
###Caculate monoisotopic or average molecular weight of input string. Note that input is ARRAY and output is also going to be ARRAY
module MWcaculator
	class Mwcaculator
		
		def initialize(ave_mono)
		@ave_mono = ave_mono
		end
		
		def caculate_mw(aaseq)
		if @ave_mono == "mono" then
					ha =   { #my_fragmentation notation 
							 "1" => (103.009184- 1.007825032), #oxidized cysteine
							 "2" => (103.009184- 1.007825032), #oxidized cysteine
							 "3" => (103.009184- 1.007825032), #oxidized cysteine
							 "4" => (103.009184- 1.007825032), #oxidized cysteine
							 "?" => (103.009184- 1.007825032-1.007825032), #homolytic cleavage
							 "!" => 103.009184,   #homolytic cleavages
							 "<" => (103.009184-1.007825032-1.007825032-31.9720707), #heterolytic cleavages
                             ">" => (103.009184+31.9720707),  #heterolytic cleavages    
							 "%" => - 1.007825032,     #-1 during the second fragmentation
							 "B" => 1.007825032,
							 "h" => 1.007825032,
							 "o" => 15.994914622,
							 "c" => 12.000000000,   
							 "@" => -15.994914622,
							 "*" => -12.000000000,
							 "n" => 14.003074,
							 "&" => -14.003074,
							 #standard amio acid
							 "G" => 57.021464,
							 "A" => 71.037114,
							 "S" => 87.032028,
							 "P" => 97.052764,
							 "V" => 99.068414,
							 "T" => 101.047678,
							 "C" => 103.009184,
							 "I" => 113.084064,
							 "L" => 113.084064,
							 "N" => 114.042927,
							 "D" => 115.026943,
							 "Q" => 128.058578,
							 "K" => 128.094963,
							 "E" => 129.042593,
							 "M" => 131.040485,
							 "H" => 137.058912,
							 "F" => 147.068414,
							 "R" => 156.101111,
							 "Y" => 163.063329,
							 "W" => 186.079313
							 }          
			mw_mono = aaseq.collect do |f|
						 ( f.count("G")*ha["G"] +
						   f.count("A")*ha["A"] +
						   f.count("S")*ha["S"] +
						   f.count("P")*ha["P"] +
						   f.count("V")*ha["V"] +
						   f.count("T")*ha["T"] +
						   f.count("C")*ha["C"] +
						   f.count("I")*ha["I"] +
						   f.count("L")*ha["L"] +
						   f.count("N")*ha["N"] +
						   f.count("D")*ha["D"] +
						   f.count("Q")*ha["Q"] +
						   f.count("K")*ha["K"] +
						   f.count("E")*ha["E"] +
						   f.count("M")*ha["M"] +
						   f.count("H")*ha["H"] +
						   f.count("F")*ha["F"] +
						   f.count("R")*ha["R"] +
						   f.count("Y")*ha["Y"] +
						   f.count("W")*ha["W"] +
						   #my_lang
						   f.count("1")*ha["1"] +
						   f.count("2")*ha["2"] +
						   f.count("3")*ha["3"] +
						   f.count("4")*ha["4"] +
						   f.count("h")*ha["h"] +
						   f.count("%")*ha["%"] +
						   f.count("B")*ha["B"] +
						   f.count("o")*ha["o"] +
						   f.count("c")*ha["c"] +
						   f.count("@")*ha["@"] +
						   f.count("*")*ha["*"] +
						   f.count("n")*ha["n"] +
						   f.count("&")*ha["&"] +
						   f.count("<")*ha["<"] +
						   f.count(">")*ha[">"] +
						   f.count("?")*ha["?"] +
						   f.count("!")*ha["!"]
						   )
				 end
							mw_mono
		else
      mw_ave  =   aaseq.collect do |f|
                      ha =   { #my_fragmentation notation 
							 "1" => (103.009184- 1.007825032),
							 "2" => (103.009184- 1.007825032),
							 "3" => (103.009184- 1.007825032),
							 "4" => (103.009184- 1.007825032),
							 "?" => (103.009184- 1.007825032), 
						     "<" => (103.009184-1.007825032- 1.007825032-31.9720707),
                             ">" => (103.009184 + 31.9720707),
							 "%" => - 1.00794,
							 "B" => 1.00794,
							 "h" => 1.00794,
							 "o" => 15.9994,
							 "c" => 12.011,   
							 "@" => -15.9994,
							 "*" => -12.011,
							 "n" => 14.00674,
							 "&" => -14.00674,
							 #standard amio acid
							 "G" => 57.0519,
							 "A" => 71.0788,
							 "S" => 87.0782,
							 "P" => 97.1167,
							 "V" => 99.1326,
							 "T" => 101.1051,
							 "C" => 103.1388,
							 "I" => 113.1594,
							 "L" => 113.1594,
							 "N" => 114.1038,
							 "D" => 115.0886,
							 "Q" => 128.1307,
							 "K" => 128.1741,
							 "E" => 129.1155,
							 "M" => 131.1926,
							 "H" => 137.1411,
							 "F" => 147.1766,
							 "R" => 156.1875,
							 "Y" => 163.1760,
							 "W" => 186.2132
							 }          
					 ( f.count("G")*ha["G"] +
					   f.count("A")*ha["A"] +
					   f.count("S")*ha["S"] +
					   f.count("P")*ha["P"] +
					   f.count("V")*ha["V"] +
					   f.count("T")*ha["T"] +
					   f.count("C")*ha["C"] +
					   f.count("I")*ha["I"] +
					   f.count("L")*ha["L"] +
					   f.count("N")*ha["N"] +
					   f.count("D")*ha["D"] +
					   f.count("Q")*ha["Q"] +
					   f.count("K")*ha["K"] +
					   f.count("E")*ha["E"] +
					   f.count("M")*ha["M"] +
					   f.count("H")*ha["H"] +
					   f.count("F")*ha["F"] +
					   f.count("R")*ha["R"] +
					   f.count("Y")*ha["Y"] +
					   f.count("W")*ha["W"] +
					   #my_lang
					   f.count("1")*ha["1"] +
					   f.count("2")*ha["2"] +
					   f.count("3")*ha["3"] +
					   f.count("4")*ha["4"] +
					   f.count("h")*ha["h"] +
					   f.count("%")*ha["%"] +
					   f.count("B")*ha["B"] +
					   f.count("o")*ha["o"] +
					   f.count("c")*ha["c"] +
					   f.count("@")*ha["@"] +
					   f.count("*")*ha["*"] +
					   f.count("n")*ha["n"] +
					   f.count("&")*ha["&"] +
					   f.count("<")*ha["<"] +
					   f.count(">")*ha[">"] +
					   f.count("?")*ha["?"]
					   )
					   end
				mw_ave
					end
			 end
		end
	end
	