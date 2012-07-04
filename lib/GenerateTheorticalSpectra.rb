#This program generate all the theortical spectra(single backbone cleavage, double backbone cleavage, heterolytic disulidfe cleavage and homolytic disulifde cleavage). 
$LOAD_PATH << (File.dirname(__FILE__) + '/../lib')

require 'mwcaculator'
require 'connector'
require 'peptide_Fragmentor'
require 'hetero_homo_breakage'
require 'tools'

class GenerateTheorticalSpectra
	def self.run(pep_sequence,single_disulfide_mode)
	
	#Make theortical spectra for heterolytic/homolytic disulfide breakage.
			#If we have four cysteines, we must fragment disulfide broken peptide and connect them.
			disul_connected = MakeFragmentsFromDisulfideCleavages.run(pep_sequence,single_disulfide_mode)
				 
			#Make theortical single peptide backbone fragmentation spectra for a double disulfide bonded peptide. 
			 single_backbone_cleavage = Fragmentor.new(pep_sequence)
			 tt = single_backbone_cleavage.single_connected_fragmentation
			 #Connects the two cysteine paris up 
			 frags_single = Connector.new(tt)
			 single_connected = frags_single.connect_disulfide

			#Make Theortical double peptide backbone fragmentation spectra for a double disulide bonded
			nu = Fragmentor.new(pep_sequence)
			by = nu.byfragmentation
		
			#Connects the two cysteine-pairs up
			frags_double = Connector.new(by)
			double_connected = frags_double.connect_disulfide
			
			[single_connected,double_connected,disul_connected[0]]
	end
end

class ConvertStringToMass
	def self.run(array_strings,tolerance)
		#Bring all the conncted fragments together and Screen out the peptides that does not have a charge on it (represented by +)
		all_mzs_and_strings =   array_strings.map do |i|
		
						charged_sing_double_sul_frags = ScreenOutNonChargedFragments.run(i) #frags_double = Connector.new()
					
						#caculate mass of predicted m/zs		
						mass = MWcaculator::Mwcaculator.new("mono")
						mzs = mass.caculate_mw(charged_sing_double_sul_frags)
						
						#bin predicted mass by mass_tolerance*2
						predic_mzs_binned = bin_it(mzs,tolerance)
						#p predic_mzs_binned.sort 
						 mzs_and_strings = [predic_mzs_binned,charged_sing_double_sul_frags].transpose
		end
	end
end

class GenerateAllModeTheorticalSpectra
	def self.run(pep_sequence,single_disulfide_mode)
	
	#Make theortical spectra for heterolytic/homolytic disulfide breakage.
			#If we have four cysteines, we must fragment disulfide broken peptide and connect them.
			disul_connected = MakeFragmentsFromDisulfideCleavages.run(pep_sequence,single_disulfide_mode)
		    hete_connected = disul_connected[0] ; homo_connected = disul_connected[1]
			#Make theortical single peptide backbone fragmentation spectra for a double disulfide bonded peptide. 
			 single_backbone_cleavage = Fragmentor.new(pep_sequence)
			 tt = single_backbone_cleavage.single_connected_fragmentation
			 #Connects the two cysteine paris up 
			 frags_single = Connector.new(tt)
			 single_connected = frags_single.connect_disulfide

			#Make Theortical double peptide backbone fragmentation spectra for a double disulide bonded
			nu = Fragmentor.new(pep_sequence)
			by = nu.by_fragmentation
			#Connects the two cysteine-pairs up
			frags_double = Connector.new(by)
			double_connected = frags_double.connect_disulfide
			
			#Make Theortical Triple peptide backbone fragmentation spectra for a double disulide bonded
			tri = Fragmentor.new(pep_sequence)
			byy = tri.byy_fragmentation
			#Connects the two cysteine-pairs up
			frags_tri = Connector.new(byy)
			tri_connected = frags_tri.connect_disulfide

     	[single_connected,double_connected,hete_connected,tri_connected,homo_connected]
	end
end
