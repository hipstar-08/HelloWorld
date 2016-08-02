
#--consecutive repetition of a particular letter 

 
a=Array.new
b=Array.new
a=["Dauresselam", "slab", "fuss", "boolean", "clap"]
p=0
l=a.length
puts l

for i in 0...l
    flag=0
    temp=Array.new   
    la=a[i].length
    temp = a[i]
	
	n=temp[0]
    for j in 1...la
	   if n==temp[j]
	      flag=1
       else
         n=temp[j]	   
	   end
    end	
	if flag == 1
	b[p]=a[i]
	p=p+1
	end
end	

puts "Array is: #{b}"	
	
           
    	   

	   


