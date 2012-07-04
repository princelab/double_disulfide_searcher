#this program give the final output. 
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')
require 'mwcaculator'
require 'connector'
require 'peptide_Fragmentor'
require 'hetero_homo_breakage'
require 'hypergeo_analysis'
require 'uniq_peak_analysis'
require 'disulfide_pattern_generator'
require 'uniq_frag'
require 'GenerateTheorticalSpectra'
require 'make_fragments_from_disulfide_cleavages'
def interface(pep_seq,tolerance,qvalue,single_disulfide_mode,uniqmode,low_range,uni_frag_mode,file_name)
    #Caculate_theorticcal_upper_limit_by_cauclating MW
       up_ran = "" ; maxmas = MWcaculator::Mwcaculator.new("mono") ; maxmas.caculate_mw([pep_seq + "hhho"]).each {|y| up_ran = y} ; up_range = up_ran.to_i
	#generate different disulifde pattern
	pep_pattern = DisulfidePatternGenerator.new(pep_seq)
	pep_sequence_array = pep_pattern.generate_disulfide_pattern(single_disulfide_mode)			
	
		array_of_scores_for_each_pattern = pep_sequence_array.collect do |pep_sequence|
		
					arr_all_mode_theortical_spectra_strings  =  GenerateAllModeTheorticalSpectra.run(pep_sequence,single_disulfide_mode)
					arr_all_mode_theortical_spectra_mzs = arr_all_mode_theortical_spectra_strings.collect do |i|
							ConvertStringToMass.run([i],tolerance).flatten.delete_if {|d| d.class == String}
					end
					
							experimental_spectra_mzs =  extract_data_and_bin((File.open("#{file_name}")),qvalue,tolerance).uniq
							p "Experimental Spectra"
						p experimental_spectra_mzs
						result = hypergeo_analysis(experimental_spectra_mzs,arr_all_mode_theortical_spectra_mzs[0..3].flatten.uniq,tolerance,qvalue,up_range,low_range)

							if uni_frag_mode == true
							 "uniq_fragmenetaion_mode_percentage"
										  uniq_frag_an= uniq_fragment_analysis(arr_all_mode_theortical_spectra_mzs,result[5],tolerance,up_range,low_range,result[-1])
							else
									result#[1]
							end
		end

			if uni_frag_mode == true
				
						array_of_scores_for_each_pattern
			
			else
						puts "PEPTIDE:#{pep_seq}|No.of disulfide pattern:#{pep_sequence_array.size}"
						p "p-values"
						p array_of_scores_for_each_pattern#.transpose[0]
						
						if uniqmode == true
						#predicted_uniq_peaks for each pattern
						 uni = Unique_peaks_analyzer.new(array_of_scores_for_each_pattern,tolerance,up_range,low_range)
						 pre = uni.find_unique_peaks("predicted","nya")
						 #predicted_uniq_peaks for each pattern that had an actual match
						 uni.find_unique_peaks("hits",pre)
						 uni.common_peaks		 
						end
			end
			
 end

