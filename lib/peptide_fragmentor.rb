#Fragment that input peptide and cacualte their b and y series. 
class Fragmentor
  def initialize(peptide)
    @peptide = peptide
  end
  
  #double fragmnetation with two intact disulifde bond
  def by_fragmentation
  peptide2 = @peptide.split('').insert(0,"h").insert(-1,"oh").join
		frag__b =  (2..@peptide.size+1).collect do |num|
            peptide2.split('').insert(num,'b').join                
             end	
        frag__y =   frag__b.collect do |po|
           (2..(@peptide.size+1)).to_a.collect do |ei|
             po.split('').insert(ei,'y').join                                 
                end     
             end
		 
  frag__2good = frag__y.flatten.delete_if {|x| x.include?("by") or x.include?("yb")}
  final_arry_spectra = frag__2good.collect do |pep_b|
   pep_b.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'%-h').split("-")
            end                      
   final_arry_spectra
  end
  
   def byy_fragmentation
  peptide2 = @peptide.split('').insert(0,"h").insert(-1,"oh").join
		frag__b =  (2..@peptide.size+1).collect do |num|
            peptide2.split('').insert(num,'b').join                
             end	
        frag__y =   frag__b.collect do |po|
           (2..(@peptide.size+1)).to_a.collect do |ei|
             po.split('').insert(ei,'y').join                                 
                end
			end
		frag_byy = frag__y.flatten.collect do |d|
			(2..(@peptide.size+1)).to_a.collect do |g|
			d.split('').insert(g,'y').join
             end
			end
  frag__2good = frag_byy.flatten.delete_if {|x| x.include?("by") or x.include?("yb") or  x.include?("yy") or x.include?("yyb")} or  x.include?("yby") or  x.include?("byy")
  final_arry_spectra = frag__2good.collect do |pep_b|
   pep_b.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'%-h').split("-")
            end                      
   final_arry_spectra
  end
  
  def byb_fragmentation
  peptide2 = @peptide.split('').insert(0,"h").insert(-1,"oh").join
		frag__b =  (2..@peptide.size+1).collect do |num|
            peptide2.split('').insert(num,'b').join                
             end	
        frag__y =   frag__b.collect do |po|
           (2..(@peptide.size+1)).to_a.collect do |ei|
             po.split('').insert(ei,'y').join                                 
                end
			end
		frag_byb = frag__y.flatten.collect do |d|
			(2..(@peptide.size+1)).to_a.collect do |g|
			d.split('').insert(g,'b').join
             end
			end
  frag__2good = frag_byb.flatten.delete_if {|x| x.include?("by") or x.include?("yb") or  x.include?("bb") or x.include?("ybb")} or  x.include?("bby") or  x.include?("byb")
  final_arry_spectra = frag__2good.collect do |pep_b|
   pep_b.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'%-h').split("-")
            end                      
   final_arry_spectra
  end
  
  #single fragmentation with two intact disulfide bond. 
  def single_connected_fragmentation
 peptide2 = @peptide.split('').insert(0,"h").insert(-1,"oh").join
     frag__b =  (2..@peptide.size+1).collect do |num|
          peptide2.split('').insert(num,'b').join                  
             end
     frag__y =  (2..(@peptide.size)).to_a.collect do |ei|
          peptide2.split('').insert(ei,'y').join                                    
             end			
     final_arry_spectra = [frag__b,frag__y].flatten.collect do |pep_b|
				pep_b.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'%-hh+').split("-")
            end                      
   final_arry_spectra
 end
 
 def fragmentation
 final_yb = [] ; frag__b = []  ; frag___finaly = [] ; frag___finalb = []; frag__y = [] 
 
   peptide2 = @peptide.split('').insert(0,"h").insert(-1,"oh").join
                     (2..@peptide.size).collect do |num|
                                   frag__b << peptide2.split('').insert(num,'b').join
                                                end
                                            
                    (2..@peptide.size).to_a.collect do |ei|
                                  frag__y << peptide2.split('').insert(ei,'y').join
                                                end
      "y-series"
   frag__y.each do |pep_y|
   frag___finaly << pep_y.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'-+h').split("-")
             end

      "b-series"
   frag__b.each do |pep_b|
   frag___finalb <<  pep_b.gsub!(/[by]/, 'b'=>'+-h', 'y'=>'-+h').split("-")
 # proton is attach to the right side
             end
  frag___finalb
 #making copying for xyz
 frag___finalx= Marshal.load( Marshal.dump(frag___finaly) )
 frag___finalz= Marshal.load( Marshal.dump(frag___finaly) )
 #making copying for xyz
 frag___finala= Marshal.load( Marshal.dump(frag___finalb) )
 frag___finalc= Marshal.load( Marshal.dump(frag___finalb) )
 peptide2b= Marshal.load( Marshal.dump(peptide2) )
 peptide2a= Marshal.load( Marshal.dump(peptide2) )
 peptide2y= Marshal.load( Marshal.dump(peptide2) )
 peptide2z= Marshal.load( Marshal.dump(peptide2) )


##All of the these go up to FCGLCVCPCN(no K)
  bfrag =  frag___finalb.collect do |bb|
            bb[0] 
        end
  bfrag << (peptide2b.delete "h" "o").insert(0,"h")
 
   afrag = frag___finala.collect do |aa|
             aa[0].insert(0,"@*")
         end
  afrag << (peptide2a.delete "h" "o").insert(0,"h").insert(0,"*@")
  
  cfrag = frag___finalc.collect do |cc| 
             cc[0].insert(0,"hhhn")
         end           
    
 #All of these go up to (F)CGLCVCPCNK, with no #F
    yfrag = frag___finaly.collect do |iy|
               iy[1].insert(0,"h")  #charged fragments
                   end
   yfrag.insert(0,peptide2y.insert(0,"h"))
   
    xfrag = frag___finalx.collect do |po|
               po[1].insert(0,"co%")
               end
    zfrag = frag___finalz.collect do |eo|
               (eo[1].delete "h" "o").insert(-1,"oh").insert(0,"&%")
               end
    zfrag.insert(0,(peptide2z.delete "h" "o").insert(-1,"oh").insert(0,"&%"))
  
  all_frag = [bfrag,afrag,cfrag,yfrag,xfrag,zfrag]
  
  end      
end
	