#This program caculate % observed/theortical spectra of MS/MS spectra. 

$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')
require 'GenerateTheorticalSpectra'
require 'scramble_generator'
require 'rubygems'
require 'distribution'
require 'tools'

def uniq_fragment_analysis(all_ma,match,tolerance,up_range,low_range,experimental_spectra)
  all_mass = all_ma.map {|w| w.uniq}
#caculate
#generate_unique_mzs_for_each_fragmentation
   p "Unique fragmentation from single,double, heterolytic and homolytic disulfide cleavages"
    single_all = all_mass[0]
    double_uniq = all_mass[1]-all_mass[0]-all_mass[2]#-all_mass[3]
    hetero_uniq = all_mass[2]-all_mass[1]-all_mass[0]#-all_mass[3]
    homo_uniq = all_mass[3]-all_mass[1]-all_mass[2]-all_mass[0]
   scramble  = scramble_generator_for_uniq_fragmentation(up_range,low_range,tolerance)
	p single_all.sort; p double_uniq.sort ; p hetero_uniq.sort ; p  homo_uniq.sort
    random_match_count = compare_match(scramble,experimental_spectra).size

  hits_from_each_fragmentation = [single_all,double_uniq,hetero_uniq,homo_uniq].collect do |u|
	    uu = u.delete_if {|i| i < low_range}
		p "total unique fragmentation: #{uu.size}"
		 compare_match(uu,match)
		end
  p "total_hits"
  p match.size
  p "single_hits"
  p  hits_from_each_fragmentation[0]#.size
  p si_per = (hits_from_each_fragmentation[0].size.to_f/single_all.size)
  p "hits from unique_double_fragmentation:"
  p hits_from_each_fragmentation[1]#.size
  p dou_per = (hits_from_each_fragmentation[1].size.to_f/double_uniq.size)
  p "hits from unique_hetero_disulifde_fragmentation:"
  p hits_from_each_fragmentation[2].size
  p hete_per = (hits_from_each_fragmentation[2].size.to_f/hetero_uniq.size)
  p "hits from unique_homo_disulifde_fragmentation:"
  p hits_from_each_fragmentation[3].size
  p homo_per = (hits_from_each_fragmentation[3].size.to_f/homo_uniq.size)
  p "Hits from 10000 ranmdoly selected number within the range in"
  p scramble_per = (random_match_count.to_f/1000)
  #up_range,low_range,mass_tolerance)
  #double hypergeometric distribution
  p [si_per,dou_per,hete_per,homo_per,scramble_per]
end