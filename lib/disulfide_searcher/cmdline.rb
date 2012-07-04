module DisulfideSearcher
  CmdLineDefaults = "--sequence AASDFSADFSAFSA --run-file somefile.txt".split(/ /)
  RunDefaults = {:sequence=>"AASDFSADFSAFSA", :run_file=>"somefile.txt", :output_file=>nil, :mass_tolerance=>0.3, :lower_mz_limit=>200, :output_percent_coverage=>false, :optimizeQ=>false, :help=>false, :sequence_given=>true, :run_file_given=>true}
  class CmdLine
    def self.run(argv)
      require 'trollop'
      parser = Trollop::Parser.new do 
        opt :sequence, "Input the peptide sequence", required: true, type: :string
        opt :run_file, "Input file", :required => true, type: :string
        opt :output_file, "Output file --suitable automatic name will be used if not specified", type: :string
        opt :mass_tolerance, "Mass tolerance for MS/MS matching", type: :float, default: 0.3
        opt :lower_mz_limit, "Lower mass limit for searching", type: :int, default: 200
        opt :output_percent_coverage, "Output the percent coverage of each fraggment ion type", default: false
        opt :optimizeQ, "Optimize for best Q value within Andromeda type algorithm"
      end
      opts = Trollop::with_standard_exception_handling parser do 
        #raise Trollop::HelpNeeded if argv.empty? # show help if empty
        parser.parse(argv)
      end
      p opts
      
    end
  end
end


if $0 == __FILE__
  ARGV = DisulfideSearcher::CmdLineDefaults if ARGV.empty? 
  p ARGV
  DisulfideSearcher::CmdLine.run(ARGV)
end
