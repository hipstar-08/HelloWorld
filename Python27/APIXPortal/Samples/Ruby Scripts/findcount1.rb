
#finding number of occurance of the characters

data = String.new("good")
cnt = Array.new

l= data.length
for i in 0...l
  cnt[i]= data.count(data[i])  #counting characters
 end 
for k in 0...l
   puts  "Char #{data[k]} displayed  #{cnt[k]} times"
end
 
	
           
    	   

	   


