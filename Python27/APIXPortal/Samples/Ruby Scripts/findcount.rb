
#finding number of occurance of the characters

data = String.new("testing well")
char = Array.new
cnt= Array.new
l= data.length
p=data[0]

for i in 0...l
  p=data[i]
  count=0
  
  
  
  for j in i...l
  count=1
    if p==(data[j])
     count=count+1
	end 
    
 end  
char[i]=p
   cnt[i]=count
end   
end 
for k in 0...l
   puts  "Char #{char[k]} displayed  #{cnt[k]} times"
end
 
	
           
    	   

	   


