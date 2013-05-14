
data = File.open("somefile.txt")
data1 = data.read.split("\n")
p rt = data1[-1].to_f.round(1)
data1.pop ; p  st_mzs_int = data1.collect {|o| o.split("-")}
 p  msz_f   =  st_mzs_int.transpose[0].collect {|t| t.to_f}
 p  int_f   =  st_mzs_int.transpose[1]

	p msz_f.size
	p int_f.size
=begin
string_mzs_intesity = []
ret_time = []
data2 = data1.collect do |da|
	if da.include?("-")
        string_mzs_intesity	<< da.split("\n")
	else
		ret_time << da.split("\n")
	end
end

 st_mzs_int = string_mzs_intesity.collect do |w|
	sub_mzs	= w.collect {|o| o.split("-")}
			sub_mzs
	end
p st_mzs_int[0]
p rt = ret_time.flatten!.delete_if {|i| i == ""}
=end
