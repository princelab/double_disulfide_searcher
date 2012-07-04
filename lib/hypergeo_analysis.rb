#This program caculate the primary sequence score. 
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')
require "extract_data_and_bin.rb"
require "tools"
require 'rubygems'
require 'distribution'

def hypergeo_analysis(experim_spectra,predicted_spectra,delta,qvalue,up_range,low_range)

#The sum of number of unique predicted spectra(number of hits in a sample) and cut off above and below the analysis ranges. 
succ_in_pop = eliminate_outside_mass_range(predicted_spectra,low_range,up_range).uniq
pool_of_samples = eliminate_outside_mass_range(experim_spectra,low_range,up_range).uniq
nu_succ_in_pop = succ_in_pop.size
sample_size = pool_of_samples.size
#Match experimental spectra with predicted spectra (they should be exactly the same since I binned both). 
 matches = succ_in_pop.select do |predmz| 
  pool_of_samples.any? do |actmz|
    (predmz-actmz).abs.round(3) <= 0.00001
      end
end
### prevents stoping whtn 0 hits

#mzs that were found to be match
p "match_mass"
p  matched_mass = matches.uniq.sort
#number of matches between the experimental spectra and predicted spectra
 no_macthes = matched_mass.size
#population size
 population = (up_range-low_range)/(delta*2) 
 if no_macthes == 0 then    
[0.9999,0.0001,no_macthes,qvalue,sample_size,matched_mass,succ_in_pop.sort,pool_of_samples]
else
 hyper_cdf = 1 - Distribution::Hypergeometric.cdf(no_macthes-1,nu_succ_in_pop,sample_size,population.to_i)
 [hyper_cdf.to_f,Math.log10(hyper_cdf.to_f)*-10,no_macthes,qvalue,sample_size,matched_mass,succ_in_pop.sort,pool_of_samples]
end
 
 end