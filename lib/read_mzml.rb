#This file extracts ms/ms spectra of desired parameters from the RAW file" 
require 'mspire/mzml'

def extract(name,msms)
mzml_file = "C:/Ruby192/myproject/exp_data/mzml/#{name}"

Mspire::Mzml.open(mzml_file) do |mzml|
  mzml.each do |spectrum|
    next unless spectrum.ms_level == 2
	if spectrum.precursor_mz.round(2) == msms #and spectrum.precursor_charge == 2
	 "Precursor charge"
	 spectrum.precursor_charge 
	 "Precursor mass"
     spectrum.precursor_mz
	 "Size of the Specrum"
     spectrum.mzs.size
	 "Spectrum intensities size"
     spectrum.intensities.size
     da = spectrum.peaks.collect {|t| t.join("&")}
	 "rt"
	 spectrum.retention_time
	 
	 File.open("C:/Ruby192/myproject/exp_data/#{msms}-#{(spectrum.retention_time/60).to_f.round(2)}.txt", "w+") do |f| 
	  f.puts da
      f.puts (spectrum.retention_time/60).to_f.round(2)
 	end
   end
  end
 end
end
[592.74].each do |i|
extract("Data_Ndependent2.mzML",i)
end