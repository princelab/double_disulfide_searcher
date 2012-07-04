# Distribution Function implemented here is from = distribution * https://github.com/clbustos/distribution== DESCRIPTION:Statistical Distributions library.
#This program caculate the pattern diagnostic score for all possible disulide patterns. 
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'distribution'
require 'tools'
 
class Unique_peaks_analyzer
	
	def initialize(array_of_scores_for_each_pattern,tolerance,up_range,low_range)
		@array_of_scores_for_each_pattern = array_of_scores_for_each_pattern
		@tolerance = tolerance
		@up_range = up_range
		@low_range= low_range
		end

	def common_peaks
	 p "common_peaks"
	  common_bins = []
	   @array_of_scores_for_each_pattern.transpose[6].flatten.sort.each do |i|
			if @array_of_scores_for_each_pattern.transpose[6].flatten.count(i) == @array_of_scores_for_each_pattern.size
			          common_bins      <<   i 
					       end
					end
		#common_peaks_from_all_possible_combination
		#hypergeometric_distribution_score_for_the_common_peaks
		 popul = (@up_range-@low_range)/(@tolerance*2)
		 
		  experimental_spectra = @array_of_scores_for_each_pattern.transpose[-1][0]
		p common_bins.uniq
		   sample_size = experimental_spectra.size
		   no_of_sucuss_in_pop = common_bins.uniq.size
		   
		   matches = compare_match(common_bins,experimental_spectra)
					   
		if matches.size == 0 then   
            p   "NO MATCH COMMON"		
			 no_matches = 0
		else
		  no_matches = matches.uniq.size

		#(no_macthes-1,nu_succ_in_pop1324,experimental_spectra.uniq.count,population.to_i)
		 ab = 1 - Distribution::Hypergeometric.cdf(no_matches-1,no_of_sucuss_in_pop,sample_size,popul.to_i)
		 p ab.to_f
		 end
	 end

	def find_unique_peaks(condition,predict_mazes_for_hygeo)

		if condition.include?("pred")
	    p array_pred_mzs = @array_of_scores_for_each_pattern.transpose[6]
		puts "Predicted unique peaks"
		elsif condition.include?("hit")
		puts "unique peaks that had an actual match"
		array_pred_mzs = @array_of_scores_for_each_pattern.transpose[5]
		end
		
		if @array_of_scores_for_each_pattern.size == 3
		
		 p uniq_peaks = [array_pred_mzs[0] - array_pred_mzs[1]-array_pred_mzs[2],
					     array_pred_mzs[1] - array_pred_mzs[0]-array_pred_mzs[2],
					   	array_pred_mzs[2]-array_pred_mzs[0]-array_pred_mzs[1]]
						
		elsif @array_of_scores_for_each_pattern.size == 6
		
	    p uniq_peaks = [array_pred_mzs[0] - array_pred_mzs[1]-array_pred_mzs[2]-array_pred_mzs[3] - array_pred_mzs[4]-array_pred_mzs[5],
					array_pred_mzs[1] - array_pred_mzs[0]-array_pred_mzs[2]-array_pred_mzs[3] - array_pred_mzs[4]-array_pred_mzs[5],
					array_pred_mzs[2] - array_pred_mzs[1]-array_pred_mzs[0]-array_pred_mzs[3] - array_pred_mzs[4]-array_pred_mzs[5],
					array_pred_mzs[3] - array_pred_mzs[1]-array_pred_mzs[2]-array_pred_mzs[0] - array_pred_mzs[4]-array_pred_mzs[5],
					array_pred_mzs[4] - array_pred_mzs[1]-array_pred_mzs[2]-array_pred_mzs[3] - array_pred_mzs[0]-array_pred_mzs[5],
					array_pred_mzs[5] - array_pred_mzs[1]-array_pred_mzs[2]-array_pred_mzs[3] - array_pred_mzs[4]-array_pred_mzs[0] ]
		else
		  uniq_peaks = array_pred_mzs
		end

		if  condition.include?("hits") and @array_of_scores_for_each_pattern.size == 1
		  p "only one pattern: no unique mode"
		elsif condition.include?("hits") 
		popul = (@up_range-@low_range)/(@tolerance*2)
	    predict_mazes_for_hygeo_size = predict_mazes_for_hygeo.map {|f| f.size}
		uniq_peaks_size = uniq_peaks.map {|d| d.size}
		combin_pred_actual = [predict_mazes_for_hygeo_size,uniq_peaks_size].transpose
		p "p-values for jus the unique peaks::"
		combin_pred_actual.collect do |e|
		val = Distribution::Hypergeometric.cdf(e[1]-1,e[0],@array_of_scores_for_each_pattern[1][4],popul.to_i)
        if val == nil
		 p "no unique hits"
		elsif
		 ab = 1- val
		 p ab.to_f
			end
		 end
	   end
	uniq_peaks
	end
end