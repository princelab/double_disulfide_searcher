#This program extract_top Q_peaks from every 100 thompson interval. 
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')
require "tools"

def extract_data_and_bin(exp_spectr,qval,delta)
     #Make Raw data into an array. 

data1 = exp_spectr.read.split("\n")
 rt = data1[-1].to_f.round(1)
data1.pop ;   st_mzs_int = data1.collect {|o| o.split("&")}

  msz_f   =  st_mzs_int.transpose[0]
   int_f   =  st_mzs_int.transpose[1].collect {|t| t.to_f}

	#Make m/zs and intesnity into Hash so that I can order them according to intensity. 
	sp_hash = Hash.new {|h,k| h[k] = []}
	[msz_f,int_f].transpose.collect {|ww| sp_hash["#{ww[0]}"] << ww[1] }
    sp_hash = sp_hash.sort {|a,b| b[1] <=> a[1] }
	
	#Take sorted data and round m/zs according to mass tolerance (usually +-0.15*2 => 0.3 m/z) => bin m/zs. Then, I round the m/zs to 0.01.
	sorted_d = [sp_hash.to_a.transpose[0], sp_hash.to_a.transpose[1].flatten].transpose.collect {|ee| [ee[0].to_f,ee[1]]}
    sorted_data = [sorted_d_bin = bin_it(sorted_d.transpose[0],delta),sorted_d.transpose[1]].transpose
final_data = []
qvalue = qval
    #Store [m/zs,intensity] accodring to 100Th

=begin not
   p"ARAE"
   sorted_data
   if sorted_data.size >= qvalue
			sorted_data[0..qvalue-1].each {|w| final_data << w}
	elsif sorted_data.size < qvalue
	        sorted_data.each {|w| final_data << w}
	else 
	 p 'you failed'
	 end
=end

  clasify(sorted_data).each do |e|
    if e.size >= qvalue
			e[0..qvalue-1].each {|w| final_data << w}
	elsif e.size < qvalue
	        e.each {|w| final_data << w}
	else 
	 p 'you failed'
	 end
	end

	final_data_mzs = final_data.transpose[0]
end